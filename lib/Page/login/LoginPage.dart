import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../repository/auth_repository.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/Button.dart';
import '../../widgets/Header.dart';
import '../../widgets/Input.dart';
import 'login_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget implements AutoRouteWrapper {
  const LoginPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (ctx) => LoginBloc(ctx.read<AuthRepository>()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const _LoginView();
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<LoginBloc>().add(
      LoginEvent.submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // BlocListener = 화면을 그리는 게 아니라 "한 번만 실행할 부수효과" 담당.
    // 화면 이동이나 SnackBar 를 BlocBuilder 안에서 하면 리빌드마다 중복 실행된다.
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case LoginStatus.success:
            // 전역 인증 상태를 갱신한 뒤 홈으로 이동한다.
            context.read<AuthBloc>().add(const AuthEvent.loggedIn());
            context.router.replaceAll([const MyHomeRoute()]);
          case LoginStatus.failure:
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          case LoginStatus.initial:
          case LoginStatus.submitting:
            break;
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SigninupHeader(inorup: '로그인'),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 18.0,
                  right: 18.0,
                ),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InputBox(InputBoxText: '이메일', controller: _emailController),
                    InputBox(
                      InputBoxText: '비밀번호',
                      controller: _passwordController,
                    ),
                    // 전송 중에는 버튼을 눌러도 반응하지 않게 한다.
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (prev, curr) =>
                          prev.isSubmitting != curr.isSubmitting,
                      builder: (context, state) {
                        return Button(
                          buttonTitle: state.isSubmitting ? '로그인 중...' : '로그인',
                          topPadding: 15,
                          leftPadding: 14,
                          rightPadding: 14,
                          bottomPadding: 14,
                          textboxWidth: 306,
                          // Button 의 onPressed 는 non-null 이라 빈 함수로 막는다.
                          // (Bloc 쪽에서도 isSubmitting 중복 요청을 한 번 더 거른다)
                          onPressed: state.isSubmitting ? () {} : _submit,
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () => context.router.push(const SignUpRoute()),
                      child: const Text(
                        '계정이 없으신가요? 회원가입',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6E6E73),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
