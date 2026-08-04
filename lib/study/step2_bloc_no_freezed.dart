// ============================================================
// STEP 2. BLoC만 사용 (Freezed 없음) — 손으로 다 쓰는 버전
// ============================================================
// ⭐ 이 파일의 목적: "Freezed가 대체 뭘 대신 써주는 건데?"를 눈으로 보기
//
// BLoC의 개념은 딱 3개뿐입니다:
//   1) Event  : "이런 일이 일어났다"  (사용자 입력, 화면 진입 등)
//   2) State  : "지금 화면은 이렇다"  (그려야 할 데이터)
//   3) Bloc   : Event를 받아 State를 내보내는 변환기
//
//   [UI] --add(Event)--> [Bloc] --emit(State)--> [UI]
//        └──────────── 단방향 순환 ────────────┘
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ------------------------------------------------------------
// 1) Event 정의 — "무슨 일이 일어났는가"
// ------------------------------------------------------------
// sealed = 이 파일 밖에서 상속 불가 → switch 문에서 "빠짐없음" 검사가 됨
sealed class PlainCounterEvent {
  const PlainCounterEvent();
}

class PlainIncrementPressed extends PlainCounterEvent {
  const PlainIncrementPressed();
}

class PlainDecrementPressed extends PlainCounterEvent {
  const PlainDecrementPressed();
}

// 값을 실어 보내는 이벤트는 필드 + 생성자를 손으로 써야 함
class PlainAmountAdded extends PlainCounterEvent {
  final int amount;
  const PlainAmountAdded(this.amount);
}

// ------------------------------------------------------------
// 2) State 정의 — "지금 화면 상태는 무엇인가"
// ------------------------------------------------------------
// 😩 여기가 바로 Freezed가 없앨 지옥입니다. 필드 2개짜리인데도 이 분량.
class PlainCounterState {
  final int count;
  final int tapCount;

  const PlainCounterState({this.count = 0, this.tapCount = 0});

  // (A) copyWith — 불변 객체에서 "일부만 바꾼 새 객체"를 만드는 필수 메서드
  //     필드가 늘어날 때마다 여기도 손으로 늘려야 함 → 빼먹으면 조용히 버그
  PlainCounterState copyWith({int? count, int? tapCount}) {
    return PlainCounterState(
      count: count ?? this.count,
      tapCount: tapCount ?? this.tapCount,
    );
  }

  // (B) == 와 hashCode — ⚠️ 이거 없으면 BLoC이 고장납니다!
  //     BLoC은 "이전 state == 새 state"이면 emit을 무시(리빌드 생략)합니다.
  //     기본 ==는 "같은 메모리 주소인가?"라서 새 객체는 항상 != 가 되고,
  //     그러면 값이 그대로여도 매번 리빌드가 일어납니다.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlainCounterState &&
        other.count == count &&
        other.tapCount == tapCount;
  }

  @override
  int get hashCode => Object.hash(count, tapCount);

  // (C) toString — 디버깅/로그용
  @override
  String toString() => 'PlainCounterState(count: $count, tapCount: $tapCount)';
}

// ------------------------------------------------------------
// 3) Bloc 정의 — Event를 State로 변환하는 규칙
// ------------------------------------------------------------
class PlainCounterBloc extends Bloc<PlainCounterEvent, PlainCounterState> {
  //                                 ▲ 받는 것        ▲ 내보내는 것

  // super(...) 에 넣는 게 "초기 상태"
  PlainCounterBloc() : super(const PlainCounterState()) {
    // on<이벤트타입>(핸들러)
    //   = "이 타입의 이벤트가 들어오면 이 함수를 실행해라" 라는 등록
    on<PlainIncrementPressed>((event, emit) {
      // state = 현재 상태 (Bloc이 항상 들고 있음)
      // emit() = 새 상태를 내보냄 → 구독 중인 BlocBuilder가 리빌드됨
      emit(
        state.copyWith(count: state.count + 1, tapCount: state.tapCount + 1),
      );
    });

    on<PlainDecrementPressed>((event, emit) {
      emit(
        state.copyWith(count: state.count - 1, tapCount: state.tapCount + 1),
      );
    });

    on<PlainAmountAdded>((event, emit) {
      // event 안에 실려온 값을 꺼내 쓴다
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
// 4) UI
// ------------------------------------------------------------
class Step2Page extends StatelessWidget {
  // 👈 StatefulWidget이 아니어도 됨!
  const Step2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider = Bloc을 만들어서 아래쪽 위젯들에게 공급 + 화면 나갈 때 자동 close
    return BlocProvider(
      create: (_) => PlainCounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('STEP 2 · BLoC (Freezed 없음)')),
        // BlocBuilder = 상태를 구독해서, 바뀔 때마다 builder를 다시 실행
        body: BlocBuilder<PlainCounterBloc, PlainCounterState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('상태가 Bloc 안에 있음'),
                  const SizedBox(height: 16),
                  Text('${state.count}', style: const TextStyle(fontSize: 64)),
                  Text('버튼 누른 횟수: ${state.tapCount}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        // read = Bloc 인스턴스만 꺼내오기 (구독 X)
                        // 콜백 안에서는 항상 read를 씁니다
                        onPressed: () => context.read<PlainCounterBloc>().add(
                          const PlainDecrementPressed(),
                        ),
                        child: const Text('-1'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () => context.read<PlainCounterBloc>().add(
                          const PlainIncrementPressed(),
                        ),
                        child: const Text('+1'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () => context.read<PlainCounterBloc>().add(
                          const PlainAmountAdded(10),
                        ),
                        child: const Text('+10'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      '👆 잘 동작하지만, State 클래스에 copyWith / == / hashCode / '
                      'toString 을 전부 손으로 썼습니다.\n'
                      '필드가 5개, 10개가 되면? → STEP 3으로.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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
