import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/core/locale_storage.dart';
import 'di/injection.dart';
import 'gen/fonts.gen.dart';
import 'i18n/strings.g.dart';
import 'presentation/auth/auth_bloc.dart';
import 'presentation/locale/locale_bloc.dart';
import 'router/app_router.dart';

Future<void> main() async {
  // 플랫폼 채널(SecureStorage 등) 준비 후 DI 그래프를 초기화한다.
  WidgetsFlutterBinding.ensureInitialized();

  // injectable 이 생성한 등록 코드를 실행한다. 이 한 줄이 예전의
  // MultiRepositoryProvider + 수동 registerXxx 를 모두 대신한다.
  await configureDependencies();

  // 저장된 언어 설정을 복원한다. (심화: 언어 유지) 없으면 base_locale(ko).
  final savedLocale = await LocaleStorage.load();
  if (savedLocale != null) await LocaleSettings.setLocale(savedLocale);

  runApp(const AppRoot());
}

/// Repository 는 더 이상 위젯 트리로 공급하지 않는다. getIt 이 전역으로 갖고 있다.
/// AuthBloc 은 getIt 의 LazySingleton, LocaleBloc 은 앱 전역 언어 상태다.
///
/// [TranslationProvider] 로 감싸야 화면들이 `context.t` 로 번역을 읽고,
/// 언어가 바뀌면 자동으로 다시 그려진다.
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<AuthBloc>()..start()),
          BlocProvider(create: (_) => LocaleBloc()),
        ],
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // LocaleBloc 의 상태(AppLocale)가 바뀌면 MaterialApp 전체를 다시 그린다.
    // → 전역 t 가 새 언어를 가리키므로 모든 화면의 문자열이 갱신된다.
    return BlocBuilder<LocaleBloc, AppLocale>(
      builder: (context, locale) {
        return MaterialApp.router(
          routerConfig: _appRouter.config(),
          title: context.t.app.title,
          locale: locale.flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          // Material/Cupertino/Widgets 위젯의 ko/en 로케일 지원
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          // 스크롤 끝에서 내용이 늘어나는 Android stretch 효과 제거
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
          ),
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: FontFamily.pretendard,
          ),
        );
      },
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
