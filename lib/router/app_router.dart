import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart'; // 코드가 생성된 후 생성될 파일
// 기능별 폴더에서 페이지를 가져온다. 각 폴더 안에 그 화면의 Bloc 이 함께 있다.
import '../presentation/board_list/ViewGridPage.dart';
import '../presentation/board_post/BoardPostPage.dart';
import '../presentation/create_post/CreatePostPage.dart';
import '../presentation/create_tag/CreateTagPage.dart';
import '../presentation/home/HomePage.dart';
import '../presentation/login/LoginPage.dart';
import '../presentation/newboard/NewboardPage.dart';
import '../presentation/post/PostPage.dart';
import '../presentation/profile/ProfilePage.dart';
import '../presentation/search/SearchPage.dart';
import '../presentation/signup/SignUpPage.dart';
import '../presentation/splash/SplashPage.dart';
import '../presentation/webview/WebViewPage.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // '/' 는 초기 화면. 저장된 토큰을 확인한 뒤 홈 또는 로그인으로 보낸다.
    AutoRoute(page: SplashRoute.page, path: '/', initial: true),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignUpRoute.page, path: '/signup'),
    AutoRoute(page: MyHomeRoute.page, path: '/home'),
    AutoRoute(page: ProfileRoute.page, path: '/profile'),
    AutoRoute(page: ViewGridRoute.page, path: '/view-grid'),
    AutoRoute(page: NewboardRoute.page, path: '/create-new-board'),
    AutoRoute(page: SearchRoute.page, path: '/search'),
    AutoRoute(page: PostRoute.page, path: '/post'),
    AutoRoute(page: BoardPostRoute.page, path: '/board-post'),
    AutoRoute(page: CreatePostRoute.page, path: '/create-post'),
    AutoRoute(page: CreateTagRoute.page, path: '/create-tag'),
    AutoRoute(page: WebViewRoute.page, path: '/webview'),
  ];
}
