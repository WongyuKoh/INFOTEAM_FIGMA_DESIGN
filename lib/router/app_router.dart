import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart'; // 코드가 생성된 후 생성될 파일
import '../Page/HomePage.dart';
import '../Page/ProfilePage.dart';
import '../Page/ViewGridPage.dart';
import '../Page/NewboardPage.dart';
import '../Page/SearchPage.dart';
import '../Page/PostPage.dart';
import '../Page/BoardPostPage.dart';
import '../Page/CreatePostPage.dart';
import '../Page/CreateTagPage.dart';
import '../Page/LoginPage.dart';
import '../Page/SignUpPage.dart';


@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    // '/'는 초기 화면을 의미합니다.
    AutoRoute(page: LoginRoute.page, path: '/', initial: true),
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