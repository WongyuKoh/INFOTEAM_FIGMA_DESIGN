import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../router/app_router.gr.dart';

/// 앱의 첫 화면.
///
/// [AuthBloc] 이 보안 저장소의 토큰을 확인하는 동안 스피너를 보여주고,
/// 결과가 나오면 홈 또는 로그인 화면으로 스택을 통째로 교체한다.
/// (replaceAll 이므로 뒤로가기로 이 화면에 돌아올 수 없다)
@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      // unknown → authenticated / unauthenticated 로 결론이 났을 때만 반응한다.
      listenWhen: (prev, curr) => prev is AuthUnknown && curr is! AuthUnknown,
      listener: (context, state) {
        switch (state) {
          case AuthAuthenticated():
            context.router.replaceAll([const MyHomeRoute()]);
          case AuthUnauthenticated():
            context.router.replaceAll([const LoginRoute()]);
          case AuthUnknown():
            break;
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
