import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../widgets/Input.dart';
import '../widgets/Header.dart';
import '../widgets/Button.dart';
import '../api/api_client.dart';
import '../api/auth_service.dart';
import '../api/token_storage.dart';
import '../router/app_router.gr.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final _authService = AuthService(ApiClient().dio);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nicknameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 항목을 입력해주세요')),
      );
      return;
    }
    try {
      await _authService.register({
        'email': _emailController.text,
        'nickname': _nicknameController.text,
        'password': _passwordController.text,
      });
      // 회원가입 시 입력한 정보는 미리 저장해 두어, 이후 로그인 시 즉시 사용 가능하도록.
      TokenStorage.email = _emailController.text;
      TokenStorage.nickname = _nicknameController.text;
      if (mounted) context.router.replace(const LoginRoute());
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SigninupHeader(inorup: '회원가입'),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 16.0, left: 18.0, right: 18.0),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputBox(InputBoxText: '닉네임', controller: _nicknameController),
                  InputBox(InputBoxText: '이메일', controller: _emailController),
                  InputBox(InputBoxText: '비밀번호', controller: _passwordController),
                  Button(
                    buttonTitle: '회원가입',
                    topPadding: 15, leftPadding: 14, rightPadding: 14, bottomPadding: 14,
                    textboxWidth: 306,
                    onPressed: _register,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
