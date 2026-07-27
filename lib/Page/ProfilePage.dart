import 'package:figma_design/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../widgets/Button.dart';
import '../widgets/Navigator.dart';
import '../widgets/Header.dart';
import '../api/core/token_storage.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  // 호환성을 위해 유지하지만 실제 로그인 여부는 TokenStorage 기준으로 판단한다.
  final bool islogin;

  const ProfilePage({super.key, this.islogin = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _logout() {
    setState(() {
      TokenStorage.clear();
    });
    context.router.replaceAll([const LoginRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = TokenStorage.isLoggedIn;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeHeader(),
          Expanded(
            child: Profile(
              islogin: isLogin,
              onLogout: _logout,
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNavigationBar(selectedIndex: 2),
    );
  }
}

class Profile extends StatelessWidget {
  final bool islogin;
  final VoidCallback? onLogout;

  const Profile({super.key, required this.islogin, this.onLogout});

  @override
  Widget build(BuildContext context) {
    final Widget loginTF = islogin ? IsLogin(onLogout: onLogout) : IsNotLogin();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 16.0,
        left: 18.0,
        right: 18.0,
      ),
      child: loginTF,
    );
  }
}

class IsLogin extends StatelessWidget {
  final VoidCallback? onLogout;
  const IsLogin({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    final nickname = TokenStorage.nickname ?? '-';
    final email = TokenStorage.email ?? '-';

    return Column(
      spacing: 18,
      children: [
        Column(
          spacing: 8,
          children: [
            Row(
              spacing: 12,
              children: [
                Text(
                  '닉네임',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF727272),
                  ),
                ),
                Expanded(
                  child: Text(
                    nickname,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 12,
              children: [
                Text(
                  '이메일',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF727272),
                  ),
                ),
                Expanded(
                  child: Text(
                    email,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Button(
          buttonTitle: '로그아웃',
          topPadding: 15.0,
          leftPadding: 14.0,
          rightPadding: 14.0,
          bottomPadding: 14.0,
          textboxWidth: 306,
          onPressed: () => onLogout?.call(),
        ),
      ],
    );
  }
}

class IsNotLogin extends StatelessWidget {
  const IsNotLogin({super.key});

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
          onPressed: () => context.router.push(LoginRoute()),
        ),
        Button(
          buttonTitle: '회원가입',
          topPadding: 15.0,
          leftPadding: 14.0,
          rightPadding: 14.0,
          bottomPadding: 14.0,
          textboxWidth: 306,
          onPressed: () => context.router.push(SignUpRoute()),
        ),
      ],
    );
  }
}
