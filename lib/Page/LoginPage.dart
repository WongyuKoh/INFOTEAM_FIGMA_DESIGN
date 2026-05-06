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
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _authService = AuthService(ApiClient().dio);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이메일과 비밀번호를 입력해주세요')),
      );
      return;
    }
    try {
      final result = await _authService.login({
        'email': _emailController.text,
        'password': _passwordController.text,
      });
      print('[로그인] 응답 전체: $result');
      final accessToken = result['accessToken'] ?? result['access_token'];
      final refreshToken = result['refreshToken'] ?? result['refresh_token'];
      TokenStorage.accessToken = accessToken?.toString();
      TokenStorage.refreshToken = refreshToken?.toString();
      // 입력한 이메일은 폼에서 알 수 있고, 닉네임은 JWT 에서 추출 시도
      TokenStorage.email = _emailController.text;
      TokenStorage.updateUserFromToken();
      print('[로그인] 저장된 email=${TokenStorage.email}, nickname=${TokenStorage.nickname}');
      if (mounted) context.router.replace(const MyHomeRoute());
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SigninupHeader(inorup: '로그인'),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 16.0, left: 18.0, right: 18.0),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputBox(InputBoxText: '이메일', controller: _emailController),
                  InputBox(InputBoxText: '비밀번호', controller: _passwordController),
                  Button(
                    buttonTitle: '로그인',
                    topPadding: 15, leftPadding: 14, rightPadding: 14, bottomPadding: 14,
                    textboxWidth: 306,
                    onPressed: _login,
                  ),
                  GestureDetector(
                    onTap: () => context.router.push(const SignUpRoute()),
                    child: Text(
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
    );
  }
}
