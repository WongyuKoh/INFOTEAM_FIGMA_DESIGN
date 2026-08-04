// ============================================================
// "emit 은 왜 await 를 안 붙이나? 붙일 필요가 없나?"
//
//   flutter test test/emit_timing_test.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

sealed class DemoEvent {}

/// emit 사이에 await 가 있는 핸들러 (실제 API 호출과 같은 모양)
class WithAwait extends DemoEvent {}

/// emit 사이가 전부 동기 코드인 핸들러
class WithoutAwait extends DemoEvent {}

class DemoBloc extends Bloc<DemoEvent, String> {
  DemoBloc() : super('init') {
    on<WithAwait>((event, emit) async {
      emit('loading');
      await Future<void>.delayed(const Duration(milliseconds: 10)); // ← 제어권을 넘김
      emit('loaded');
    });

    on<WithoutAwait>((event, emit) {
      emit('loading');
      // 동기 계산 — 제어권을 넘기지 않는다
      var sum = 0;
      for (var i = 0; i < 100000; i++) {
        sum += i;
      }
      emit('loaded($sum)'.substring(0, 6)); // 'loaded'
    });
  }
}

/// 어떤 상태로 실제 build 가 일어났는지 기록하는 화면
Widget buildApp(DemoBloc bloc, List<String> buildLog) {
  return MaterialApp(
    home: BlocProvider.value(
      value: bloc,
      child: BlocBuilder<DemoBloc, String>(
        builder: (context, state) {
          buildLog.add(state);
          return Text(state, textDirection: TextDirection.ltr);
        },
      ),
    ),
  );
}

void main() {
  test('emit 은 동기다 — 호출한 순간 state 가 이미 바뀌어 있다', () async {
    final bloc = DemoBloc();
    final received = <String>[];
    final sub = bloc.stream.listen(received.add);

    expect(bloc.state, 'init');

    bloc.add(WithoutAwait());
    // add() 는 이벤트를 큐에 넣기만 하므로 아직 아무 일도 안 일어났다.
    expect(bloc.state, 'init');

    await Future<void>.delayed(Duration.zero);

    // 핸들러가 실행되며 emit 이 두 번 호출됐고, 둘 다 즉시 반영됐다.
    expect(bloc.state, 'loaded');
    expect(received, ['loading', 'loaded']); // 스트림에는 두 개 다 흘렀다

    await sub.cancel();
  });

  testWidgets('✅ await 가 있으면 로딩 화면이 실제로 그려진다', (tester) async {
    final bloc = DemoBloc();
    addTearDown(bloc.close);
    final buildLog = <String>[];
    await tester.pumpWidget(buildApp(bloc, buildLog));

    bloc.add(WithAwait());
    await tester.pump(); // 프레임 1장 — 이 시점의 상태는 loading

    expect(find.text('loading'), findsOneWidget); // 사용자가 스피너를 본다

    await tester.pump(const Duration(milliseconds: 20)); // 응답 도착 후
    expect(find.text('loaded'), findsOneWidget);

    // 로딩 상태로 화면이 실제로 한 번 그려졌다
    expect(buildLog, ['init', 'loading', 'loaded']);
  });

  testWidgets('❌ await 가 없으면 로딩 화면은 한 프레임도 그려지지 않는다', (tester) async {
    final bloc = DemoBloc();
    addTearDown(bloc.close);
    final buildLog = <String>[];
    await tester.pumpWidget(buildApp(bloc, buildLog));

    bloc.add(WithoutAwait());
    await tester.pump();

    expect(find.text('loaded'), findsOneWidget);

    // 스트림에는 'loading' 이 흘렀지만(위 첫 번째 테스트에서 확인),
    // 화면이 그려질 틈 없이 'loaded' 로 덮여서 build 조차 되지 않았다.
    expect(buildLog, ['init', 'loaded']);
    expect(buildLog.contains('loading'), isFalse);
  });
}
