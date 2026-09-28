import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../data/core/api_client.dart';
import '../data/service/auth_api.dart';
import '../data/service/auth_service.dart';
import '../data/service/board_service.dart';
import '../data/service/post_service.dart';
import '../data/service/tag_service.dart';

/// 우리가 직접 어노테이션을 달 수 없는 타입들(외부 패키지 / retrofit 이 생성한
/// Service / 자체 싱글턴 ApiClient)을 injectable 에 공급하는 모듈.
///
/// - `get` 게터 → 파라미터 없는 생성
/// - 메서드(파라미터 있음) → injectable 이 파라미터 타입을 getIt 에서 주입
@module
abstract class RegisterModule {
  /// ApiClient 는 이미 자체 싱글턴(토큰 인터셉터 포함)이라 그 Dio 를 공유한다.
  @lazySingleton
  Dio get dio => ApiClient().dio;

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @lazySingleton
  AuthApi get authApi => AuthApi();

  // retrofit 이 생성한 Service 들 — Dio 를 주입받아 만든다.
  @lazySingleton
  AuthService authService(Dio dio) => AuthService(dio);

  @lazySingleton
  PostService postService(Dio dio) => PostService(dio);

  @lazySingleton
  BoardService boardService(Dio dio) => BoardService(dio);

  @lazySingleton
  TagService tagService(Dio dio) => TagService(dio);
}
