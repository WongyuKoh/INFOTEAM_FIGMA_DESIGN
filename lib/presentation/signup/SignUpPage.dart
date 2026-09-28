import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/Button.dart';
import '../../widgets/Header.dart';
import '../../widgets/Input.dart';
import 'signup_bloc.dart';

@RoutePage()
class SignUpPage extends StatelessWidget implements AutoRouteWrapper {
  const SignUpPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpBloc>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const _SignUpView();
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<SignUpBloc>().submit(
      email: _emailController.text,
      nickname: _nicknameController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case SignUpStatus.success:
            context.router.replaceAll([const LoginRoute()]);
          case SignUpStatus.failure:
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          case SignUpStatus.initial:
          case SignUpStatus.submitting:
            break;
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SigninupHeader(inorup: context.t.auth.signup),
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
                    InputBox(
                      InputBoxText: context.t.auth.nickname,
                      controller: _nicknameController,
                    ),
                    InputBox(InputBoxText: context.t.auth.email, controller: _emailController),
                    InputBox(
                      InputBoxText: context.t.auth.password,
                      controller: _passwordController,
                    ),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      buildWhen: (prev, curr) =>
                          prev.isSubmitting != curr.isSubmitting,
                      builder: (context, state) {
                        return Button(
                          buttonTitle: state.isSubmitting ? context.t.auth.signupLoading : context.t.auth.signup,
                          topPadding: 15,
                          leftPadding: 14,
                          rightPadding: 14,
                          bottomPadding: 14,
                          textboxWidth: 306,
                          onPressed: state.isSubmitting ? () {} : _submit,
                        );
                      },
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
