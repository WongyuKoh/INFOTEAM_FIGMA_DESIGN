import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// 앱 전역에서 쓰는 단 하나의 Service Locator.
final getIt = GetIt.instance;

/// build_runner 가 생성한 `injection.config.dart` 의 `init()` 을 호출한다.
///
/// 손으로 registerXxx 를 나열하던 setupLocator 를 대체한다.
/// @injectable / @LazySingleton 이 붙은 모든 클래스가 여기서 자동 등록된다.
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
