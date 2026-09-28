import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/auth_bloc.dart';
import '../../router/app_router.gr.dart';

/// 앱의 첫 화면.
///
/// [AuthBloc] 이 보안 저장소의 토큰을 확인하는 동안 스피너를 보여주고,
/// 결과가 나오면 홈 또는 로그인 화면으로 스택을 통째로 교체한다.
/// (replaceAll 이므로 뒤로가기로 이 화면에 돌아올 수 없다)
@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void _go(BuildContext context, AuthState state) {
    switch (state) {
      case AuthAuthenticated():
        context.router.replaceAll([const MyHomeRoute()]);
      case AuthUnauthenticated():
        context.router.replaceAll([const LoginRoute()]);
      case AuthUnknown():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 이 화면이 그려지기 전에 AuthBloc 이 이미 결론을 냈을 수 있다(빠른 토큰 복원).
    // 그 경우 BlocListener 의 "전이"를 놓치므로, 현재 상태를 보고 다음 프레임에 이동한다.
    final current = context.read<AuthBloc>().state;
    if (current is! AuthUnknown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) _go(context, current);
      });
    }

    return BlocListener<AuthBloc, AuthState>(
      // unknown → authenticated / unauthenticated 로 결론이 났을 때 반응한다.
      listenWhen: (prev, curr) => prev is AuthUnknown && curr is! AuthUnknown,
      listener: _go,
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
