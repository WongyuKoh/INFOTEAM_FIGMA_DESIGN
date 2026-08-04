import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'gen/fonts.gen.dart';
import 'repository/auth_repository.dart';
import 'repository/board_repository.dart';
import 'repository/post_repository.dart';
import 'repository/tag_repository.dart';
import 'router/app_router.dart';

void main() {
  runApp(const AppRoot());
}

/// Repository 들을 앱 최상단(= 라우터보다 위)에 한 번만 만들어 공급한다.
///
/// 라우터보다 위에 있어야 push 로 열리는 모든 화면에서 context.read 로 꺼낼 수 있다.
/// (Navigator 가 띄우는 화면은 "이전 화면의 자식"이 아니라 Navigator 의 자식이다)
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => PostRepository()),
        RepositoryProvider(create: (_) => BoardRepository()),
        RepositoryProvider(create: (_) => TagRepository()),
      ],
      // 인증 상태는 앱 전체가 공유하므로 라우터보다 위에 둔다.
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) =>
                AuthBloc(ctx.read<AuthRepository>())
                  ..add(const AuthEvent.started()),
          ),
        ],
        child: MyApp(),
      ),
    );
  }
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
