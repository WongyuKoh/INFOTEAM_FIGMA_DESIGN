import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/Button.dart';
import '../../widgets/Header.dart';
import '../../widgets/Navigator.dart';

/// 화면 전용 Bloc 이 없다. 인증 상태는 앱 전역 [AuthBloc] 이 관리하므로
/// 여기서는 그것을 구독하기만 한다. (AutoRouteWrapper 도 필요 없음)
@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeHeader(),
          Expanded(
            child: BlocConsumer<AuthBloc, AuthState>(
              // 로그아웃되면 로그인 화면으로 스택을 통째로 교체한다.
              listenWhen: (prev, curr) =>
                  prev is AuthAuthenticated && curr is AuthUnauthenticated,
              listener: (context, state) =>
                  context.router.replaceAll([const LoginRoute()]),
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 18.0,
                    right: 18.0,
                  ),
                  child: switch (state) {
                    AuthAuthenticated(:final nickname, :final email) =>
                      _LoggedInView(nickname: nickname, email: email),
                    AuthUnauthenticated() => const _LoggedOutView(),
                    // 토큰 확인 중 — 잠깐 스쳐 지나간다.
                    AuthUnknown() => const SizedBox.shrink(),
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNavigationBar(selectedIndex: 2),
    );
  }
}

class _LoggedInView extends StatelessWidget {
  const _LoggedInView({required this.nickname, required this.email});

  final String nickname;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      children: [
        Column(
          spacing: 8,
          children: [
            _InfoRow(label: '닉네임', value: nickname),
            _InfoRow(label: '이메일', value: email),
          ],
        ),
        Button(
          buttonTitle: '로그아웃',
          topPadding: 15.0,
          leftPadding: 14.0,
          rightPadding: 14.0,
          bottomPadding: 14.0,
          textboxWidth: 306,
          onPressed: () =>
              context.read<AuthBloc>().add(const AuthEvent.loggedOut()),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF727272),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoggedOutView extends StatelessWidget {
  const _LoggedOutView();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      children: [
        Button(
          buttonTitle: '로그인',
          topPadding: 15.0,
          leftPadding: 14.0,
          rightPadding: 14.0,
          bottomPadding: 14.0,
          textboxWidth: 306,
          onPressed: () => context.router.push(const LoginRoute()),
        ),
        Button(
          buttonTitle: '회원가입',
          topPadding: 15.0,
          leftPadding: 14.0,
          rightPadding: 14.0,
          bottomPadding: 14.0,
          textboxWidth: 306,
          onPressed: () => context.router.push(const SignUpRoute()),
        ),
      ],
    );
  }
}
