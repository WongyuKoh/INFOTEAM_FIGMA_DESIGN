import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/auth_bloc.dart';
import '../locale/locale_bloc.dart';
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
        // 심화: 번역 문자열에 변수(닉네임)를 동적으로 삽입한다.
        Text(
          context.t.profile.welcome(nickname: nickname),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Column(
          spacing: 8,
          children: [
            _InfoRow(label: context.t.auth.nickname, value: nickname),
            _InfoRow(label: context.t.auth.email, value: email),
          ],
        ),
        const _LanguageSelector(),
        const _HelpButton(),
        Button(
          buttonTitle: context.t.profile.logout,
          topPadding: 15.0,
          leftPadding: 14.0,
          rightPadding: 14.0,
          bottomPadding: 14.0,
          textboxWidth: 306,
          onPressed: () => context.read<AuthBloc>().loggedOut(),
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
        const _LanguageSelector(),
        const _HelpButton(),
        Button(
          buttonTitle: context.t.auth.login,
          topPadding: 15.0,
          leftPadding: 14.0,
          rightPadding: 14.0,
          bottomPadding: 14.0,
          textboxWidth: 306,
          onPressed: () => context.router.push(const LoginRoute()),
        ),
        Button(
          buttonTitle: context.t.auth.signup,
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

/// 도움말 페이지를 인앱 웹뷰로 연다. (네이티브 WebView)
class _HelpButton extends StatelessWidget {
  const _HelpButton();

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () =>
          context.router.push(WebViewRoute(url: 'https://flutter.dev')),
      icon: const Icon(Icons.help_outline),
      label: Text(context.t.profile.help),
    );
  }
}

/// 언어 변경 UI. LocaleBloc 에 변경 이벤트를 보내 한국어 ↔ 영어를 전환한다.
class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, AppLocale>(
      builder: (context, locale) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Text('${context.t.profile.language}:'),
            _LangChip(
              label: context.t.profile.korean,
              selected: locale == AppLocale.ko,
              onTap: () => context.read<LocaleBloc>().change(AppLocale.ko),
            ),
            _LangChip(
              label: context.t.profile.english,
              selected: locale == AppLocale.en,
              onTap: () => context.read<LocaleBloc>().change(AppLocale.en),
            ),
          ],
        );
      },
    );
  }
}

class _LangChip extends StatelessWidget {
  const _LangChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF3B6EF6) : const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black54,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
