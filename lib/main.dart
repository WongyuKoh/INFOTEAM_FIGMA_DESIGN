import 'package:flutter/material.dart';
import 'gen/fonts.gen.dart';
import 'router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ///const MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Namer App',
      // 스크롤 끝에서 내용이 늘어나는 Android stretch 효과 제거
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        overscroll: false,
      ),
      theme: ThemeData(useMaterial3: true, fontFamily: FontFamily.pretendard),
    );
  }
}

// @RoutePage()
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   // ...
// }

// @RoutePage()
// class DetailPage extends StatelessWidget {
//   const DetailPage({super.key});
//   // ...
// }
