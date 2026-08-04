// ============================================================
// STEP 3. BLoC + Freezed — STEP 2와 "완전히 똑같이 동작"하는 코드
// ============================================================
// STEP 2의 State 클래스가 40줄이었는데, 여기선 5줄입니다.
// 나머지는 build_runner가 step3_bloc_freezed.freezed.dart 에 생성합니다.
//
//   flutter pub run build_runner build --delete-conflicting-outputs
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part = "이 파일의 일부가 저기 있다"는 선언.
// 생성된 파일은 이 파일의 private 멤버까지 공유합니다. (import가 아님에 주의)
part 'step3_bloc_freezed.freezed.dart';

// ------------------------------------------------------------
// 1) Event — 여러 종류 = "union(합집합) 타입" → sealed class
// ------------------------------------------------------------
@freezed
sealed class CounterEvent with _$CounterEvent {
  //                          ▲ 생성된 코드를 섞어 넣음 (mixin)

  // const factory 이름() = 실제클래스이름;
  //   왼쪽 = 내가 부를 이름   오른쪽 = Freezed가 만들 클래스 이름
  const factory CounterEvent.increment() = IncrementPressed;
  const factory CounterEvent.decrement() = DecrementPressed;

  // 값을 실어 보내는 이벤트도 한 줄
  const factory CounterEvent.addAmount(int amount) = AmountAdded;
}
// 👆 이 3줄이 STEP 2의 Event 클래스 4개(약 20줄)를 대체합니다.
//    CounterEvent.increment()  ← 이렇게 부르면 IncrementPressed 객체가 나옴

// ------------------------------------------------------------
// 2) State — 종류는 하나, 필드만 여럿 = "데이터 클래스" → abstract class
// ------------------------------------------------------------
@freezed
abstract class CounterState with _$CounterState {
  const factory CounterState({
    @Default(0) int count, // @Default = 기본값 지정
    @Default(0) int tapCount,
  }) = _CounterState;
}
// 👆 이 5줄로 Freezed가 자동 생성해주는 것:
//    ✅ copyWith()      ✅ == / hashCode     ✅ toString()
//    ✅ 모든 필드 final (불변 보장)
//
// ⚠️ 언제 sealed, 언제 abstract?
//    - 생성자가 여러 개(상태의 "종류"가 여럿)  → sealed class  → when/switch 사용
//    - 생성자가 하나(필드만 여럿)              → abstract class → copyWith 사용

// ------------------------------------------------------------
// 3) Bloc — STEP 2와 완전히 동일한 구조
// ------------------------------------------------------------
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    // ⚠️ on<...> 에는 "왼쪽 이름"이 아니라 "오른쪽 실제 클래스 이름"을 씁니다.
    //    on<CounterEvent.increment> (X)  →  on<IncrementPressed> (O)
    on<IncrementPressed>((event, emit) {
      emit(
        state.copyWith(count: state.count + 1, tapCount: state.tapCount + 1),
      );
    });

    on<DecrementPressed>((event, emit) {
      emit(
        state.copyWith(count: state.count - 1, tapCount: state.tapCount + 1),
      );
    });

    on<AmountAdded>((event, emit) {
      // event.amount 는 Freezed가 자동으로 만들어준 getter
      emit(
        state.copyWith(
          count: state.count + event.amount,
          tapCount: state.tapCount + 1,
        ),
      );
    });
  }
}

// ------------------------------------------------------------
// 4) UI — STEP 2와 사실상 동일 (Bloc/State 이름만 다름)
// ------------------------------------------------------------
class Step3Page extends StatelessWidget {
  const Step3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('STEP 3 · BLoC + Freezed')),
        body: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('STEP 2와 동작은 100% 동일'),
                  const SizedBox(height: 16),
                  Text('${state.count}', style: const TextStyle(fontSize: 64)),
                  Text('버튼 누른 횟수: ${state.tapCount}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () => context.read<CounterBloc>().add(
                          const CounterEvent.decrement(),
                        ),
                        child: const Text('-1'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () => context.read<CounterBloc>().add(
                          const CounterEvent.increment(),
                        ),
                        child: const Text('+1'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () => context.read<CounterBloc>().add(
                          const CounterEvent.addAmount(10),
                        ),
                        child: const Text('+10'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Freezed가 만들어준 toString()이 이렇게 예쁘게 찍힙니다
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'toString(): $state',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
