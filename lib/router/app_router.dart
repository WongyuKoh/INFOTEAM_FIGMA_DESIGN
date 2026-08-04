import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart'; // 코드가 생성된 후 생성될 파일
// 기능별 폴더에서 페이지를 가져온다. 각 폴더 안에 그 화면의 Bloc 이 함께 있다.
import '../Page/board_list/ViewGridPage.dart';
import '../Page/board_post/BoardPostPage.dart';
import '../Page/create_post/CreatePostPage.dart';
import '../Page/create_tag/CreateTagPage.dart';
import '../Page/home/HomePage.dart';
import '../Page/login/LoginPage.dart';
import '../Page/newboard/NewboardPage.dart';
import '../Page/post/PostPage.dart';
import '../Page/profile/ProfilePage.dart';
import '../Page/search/SearchPage.dart';
import '../Page/signup/SignUpPage.dart';
import '../Page/splash/SplashPage.dart';

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
  ];
}
