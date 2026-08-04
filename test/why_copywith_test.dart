// ============================================================
// "왜 변수를 직접 고치면 안 되고 copyWith로 새 객체를 만들어야 하는가"
// 를 실제로 증명하는 테스트
//
//   flutter test test/why_copywith_test.dart
// ============================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

// ------------------------------------------------------------
// 이벤트
// ------------------------------------------------------------
sealed class CountEvent {}

class MutateInPlace extends CountEvent {} // ❌ 변수 직접 수정

class CreateNewState extends CountEvent {} // ✅ 새 객체 생성

// ------------------------------------------------------------
// 일부러 final을 뺀 State (수정 가능하게)
// ------------------------------------------------------------
class MutableState {
  int count; // ⚠️ final 아님 — 직접 수정 가능

  MutableState(this.count);

  MutableState copyWith({int? count}) => MutableState(count ?? this.count);

  @override
  String toString() => 'MutableState($count)';
}

class DemoBloc extends Bloc<CountEvent, MutableState> {
  DemoBloc() : super(MutableState(0)) {
    on<MutateInPlace>((event, emit) {
      state.count++; // 값을 직접 바꾸고
      emit(state); // 같은 객체를 그대로 emit
    });

    on<CreateNewState>((event, emit) {
      emit(state.copyWith(count: state.count + 1)); // 새 객체를 emit
    });
  }
}

void main() {
  test('❌ 변수 직접 수정: 데이터는 바뀌지만 UI로 전달되지 않는다', () async {
    final bloc = DemoBloc();

    // UI(BlocBuilder)가 실제로 받는 것 = 이 stream
    final received = <int>[];
    final sub = bloc.stream.listen((s) => received.add(s.count));

    bloc.add(MutateInPlace()); // 0 → 1
    bloc.add(MutateInPlace()); // 1 → 2
    bloc.add(MutateInPlace()); // 2 → 3
    await Future<void>.delayed(Duration.zero);

    // 데이터 자체는 정상적으로 3까지 올라갔다
    expect(bloc.state.count, 3);

    // 그런데 UI는 딱 한 번밖에 알림을 못 받았다!
    // (bloc_base.dart:102 의 `_emitted` 플래그 때문에 첫 emit만 통과)
    expect(received, [1]);
    //            ▲ [1, 2, 3] 이 아니다. 화면은 1에서 멈춘 채 얼어붙는다.

    await sub.cancel();
    await bloc.close();
  });

  test('✅ copyWith로 새 객체: 매번 UI로 전달된다', () async {
    final bloc = DemoBloc();

    final received = <int>[];
    final sub = bloc.stream.listen((s) => received.add(s.count));

    bloc.add(CreateNewState());
    bloc.add(CreateNewState());
    bloc.add(CreateNewState());
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.count, 3);
    expect(received, [1, 2, 3]); // 세 번 모두 전달됨 ✅

    await sub.cancel();
    await bloc.close();
  });

  test('❌ 직접 수정은 "이전 상태 vs 현재 상태" 비교도 파괴한다', () async {
    final bloc = DemoBloc();

    // buildWhen / listenWhen / onTransition 이 쓰는 바로 그 비교
    final transitions = <String>[];
    final sub = bloc.stream.listen(null);

    bloc.add(MutateInPlace());
    await Future<void>.delayed(Duration.zero);

    // 직접 수정하면 previous 와 current 가 "같은 객체"가 되어버린다.
    // → previous.count 를 봐도 이미 바뀐 값이라 "무엇이 변했는지" 알 수 없다.
    final before = bloc.state; // 참조를 붙잡아 둠
    final beforeValue = before.count;

    bloc.add(MutateInPlace());
    await Future<void>.delayed(Duration.zero);

    transitions.add('붙잡아둔 값: $beforeValue, 지금 그 객체: ${before.count}');

    // 과거의 스냅샷이었어야 할 before 가 몰래 바뀌어 있다
    expect(beforeValue, 1);
    expect(before.count, 2); // 😱 같은 객체라서 뒤에서 변조됨
    expect(identical(before, bloc.state), isTrue);

    await sub.cancel();
    await bloc.close();
  });

  test('✅ 새 객체를 만들면 과거 상태는 과거 그대로 남는다', () async {
    final bloc = DemoBloc();
    final sub = bloc.stream.listen(null);

    bloc.add(CreateNewState());
    await Future<void>.delayed(Duration.zero);

    final before = bloc.state;

    bloc.add(CreateNewState());
    await Future<void>.delayed(Duration.zero);

    expect(before.count, 1); // 스냅샷이 그대로 보존됨 ✅
    expect(bloc.state.count, 2);
    expect(identical(before, bloc.state), isFalse);

    await sub.cancel();
    await bloc.close();
  });

  // ==========================================================
  // "== 은 값 비교인데, 값이 0에서 1로 바뀌었으면 false 여야 하지 않나?"
  // ==========================================================
  test('값 기반 ==를 직접 구현해도, 같은 객체를 고치면 여전히 true', () {
    final a = ValueEqualsState(0);
    final b = a; // 새 객체가 아니라 "같은 객체에 붙인 두 번째 이름"

    expect(identical(a, b), isTrue); // 상자는 하나뿐

    a.count = 1; // 상자 안의 값을 고쳐 씀 → 0 은 지워짐

    expect(b.count, 1); // b 도 같이 바뀐다 (같은 상자니까)
    expect(a == b, isTrue); // 1 == 1 → true. 비교할 "0" 이 남아있지 않다.
    //   ▲ Bloc 내부의 `state == _state` 가 바로 이 상황이다.
  });

  test('새 객체를 만들면 0과 1이 공존하므로 ==가 false가 된다', () {
    final a = ValueEqualsState(0);
    final b = ValueEqualsState(a.count + 1); // 별개의 상자를 새로 만듦

    expect(identical(a, b), isFalse); // 상자가 둘
    expect(a.count, 0); // 과거가 살아있음
    expect(b.count, 1);
    expect(a == b, isFalse); // 0 == 1 → false ✅ emit 통과
  });

  test('값이 진짜로 같으면 새 객체여도 ==는 true (불필요한 리빌드 차단)', () {
    final a = ValueEqualsState(7);
    final b = ValueEqualsState(7); // 서로 다른 객체지만 값이 같음

    expect(identical(a, b), isFalse);
    expect(a == b, isTrue); // → Bloc이 emit을 걸러서 리빌드를 아껴준다
  });
}

// ============================================================
// "== 은 값 비교인데 왜 true 가 나오는가?"
// → 비교 대상이 애초에 "같은 객체 하나"이기 때문
// ============================================================

/// 값 기반 == 를 직접 구현한 State (직접 구현해도 소용없음을 보이기 위함)
class ValueEqualsState {
  int count; // final 아님

  ValueEqualsState(this.count);

  @override
  bool operator ==(Object other) =>
      other is ValueEqualsState && other.count == count; // 👈 명백한 값 비교

  @override
  int get hashCode => count.hashCode;
}
