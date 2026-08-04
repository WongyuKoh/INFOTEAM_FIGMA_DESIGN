// ============================================================
// BLoC + Freezed 학습용 실행 파일
//
// 실행:
//   flutter run -t lib/study/study_main.dart
//
// (기존 앱 main.dart 는 전혀 건드리지 않습니다)
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'step1_setstate.dart' show Step1Page;
import 'step2_bloc_no_freezed.dart' show Step2Page;
import 'step3_bloc_freezed.dart' show Step3Page;
import 'step4_async_states.dart' show Step4Page;

void main() {
  // 모든 Bloc의 이벤트/상태 전환을 콘솔에 찍어주는 관찰자.
  // 👉 앱을 조작하면서 콘솔을 보세요. BLoC의 흐름이 눈에 보입니다.
  Bloc.observer = _LoggingBlocObserver();
  runApp(const StudyApp());
}

class _LoggingBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('📥 EVENT  ${bloc.runtimeType} ← $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(
      '🔄 STATE  ${bloc.runtimeType}\n'
      '     이전: ${transition.currentState}\n'
      '     이후: ${transition.nextState}',
    );
  }
}

class StudyApp extends StatelessWidget {
  const StudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC + Freezed 학습',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const _MenuPage(),
    );
  }
}

class _MenuPage extends StatelessWidget {
  const _MenuPage();

  @override
  Widget build(BuildContext context) {
    final steps = <(String, String, Widget)>[
      ('STEP 1', 'setState — BLoC 없이 (비교용)', const Step1Page()),
      ('STEP 2', 'BLoC만 — State를 손으로 다 씀', const Step2Page()),
      ('STEP 3', 'BLoC + Freezed — 동작 동일, 코드 1/5', const Step3Page()),
      ('STEP 4', '비동기 + 4가지 상태 (실무 패턴)', const Step4Page()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('BLoC + Freezed 학습')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '순서대로 보세요. STEP 2 → 3 은 "동작은 같고 코드만 줄어드는" 비교이고,\n'
              'STEP 4 가 실제 프로젝트에서 쓰는 형태입니다.\n\n'
              '조작하면서 콘솔 로그를 같이 보면 흐름이 확실히 보입니다.',
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
          ),
          const Divider(height: 1),
          for (final (label, desc, page) in steps)
            ListTile(
              leading: CircleAvatar(child: Text(label.split(' ').last)),
              title: Text(label),
              subtitle: Text(desc),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => page)),
            ),
        ],
      ),
    );
  }
}
