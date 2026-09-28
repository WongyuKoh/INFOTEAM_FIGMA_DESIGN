// 앱이 정상적으로 부팅되는지 확인하는 스모크 테스트.
//
// 원래 있던 내용은 `flutter create` 가 만들어주는 카운터 앱 템플릿이었다.
// 이 앱에는 카운터가 없어서 처음부터 실패하던 테스트라, 실제 앱에 맞게 다시 썼다.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:figma_design/di/injection.dart';
import 'package:figma_design/main.dart';

/// flutter_secure_storage 의 플랫폼 채널.
const _secureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

void main() {
  setUp(() async {
    // AppRoot 가 getIt<AuthBloc>() 을 쓰므로 DI 그래프를 먼저 등록한다.
    await getIt.reset();
    await configureDependencies();
    // ⚠️ testWidgets 는 가짜 시간(FakeAsync) 위에서 돌아간다.
    //    실제 플랫폼 채널 응답은 이 가짜 시간에 도착하지 않아서,
    //    모킹하지 않으면 TokenStorage.load() 의 Future 가 영원히 완료되지 않고
    //    AuthBloc 이 unknown 에 갇힌다 → 스플래시에서 화면이 안 넘어간다.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, (call) async {
          // 저장된 토큰이 없는 상태를 흉내낸다.
          return switch (call.method) {
            'readAll' => <String, String>{},
            'read' => null,
            _ => null,
          };
        });
  });

  tearDown(() async {
    await getIt.reset();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, null);
  });

  testWidgets('토큰이 없으면 스플래시를 거쳐 로그인 화면으로 간다', (tester) async {
    // AppRoot = Repository + AuthBloc 을 공급하는 최상단 위젯.
    // 초기 경로는 SplashRoute 이고, AuthBloc 이 저장된 토큰을 확인한 뒤
    // 결과에 따라 홈 또는 로그인으로 스택을 교체한다.
    await tester.pumpWidget(const AppRoot());
    await tester.pump(); // 라우터가 초기 경로(스플래시)를 그린다

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // ⚠️ 여기서 pumpAndSettle 을 쓰면 안 된다.
    //    스피너(CircularProgressIndicator)가 무한 애니메이션이라
    //    프레임이 영원히 안정되지 않아 타임아웃이 난다.
    //    → 정해진 횟수만큼만 프레임을 진행시킨다.
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // 테스트 환경에는 저장된 토큰이 없으므로 로그인 화면이 나와야 한다.
    expect(find.text('로그인'), findsWidgets);
    expect(find.text('이메일'), findsOneWidget);
    expect(find.text('비밀번호'), findsOneWidget);
    expect(find.text('계정이 없으신가요? 회원가입'), findsOneWidget);
  });
}
