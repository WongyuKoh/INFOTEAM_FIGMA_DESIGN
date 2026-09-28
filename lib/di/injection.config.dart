// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:figma_design/data/repository/auth_repository_impl.dart'
    as _i695;
import 'package:figma_design/data/repository/board_repository_impl.dart'
    as _i104;
import 'package:figma_design/data/repository/motion_repository_impl.dart'
    as _i424;
import 'package:figma_design/data/repository/post_repository_impl.dart'
    as _i732;
import 'package:figma_design/data/repository/tag_repository_impl.dart' as _i557;
import 'package:figma_design/data/service/auth_api.dart' as _i226;
import 'package:figma_design/data/service/auth_service.dart' as _i872;
import 'package:figma_design/data/service/board_service.dart' as _i663;
import 'package:figma_design/data/service/post_service.dart' as _i448;
import 'package:figma_design/data/service/tag_service.dart' as _i968;
import 'package:figma_design/di/register_module.dart' as _i117;
import 'package:figma_design/domain/repository/auth_repository.dart' as _i674;
import 'package:figma_design/domain/repository/board_repository.dart' as _i287;
import 'package:figma_design/domain/repository/motion_repository.dart' as _i836;
import 'package:figma_design/domain/repository/post_repository.dart' as _i498;
import 'package:figma_design/domain/repository/tag_repository.dart' as _i378;
import 'package:figma_design/domain/usecase/create_board.dart' as _i964;
import 'package:figma_design/domain/usecase/create_post.dart' as _i5;
import 'package:figma_design/domain/usecase/create_tag.dart' as _i935;
import 'package:figma_design/domain/usecase/delete_board.dart' as _i886;
import 'package:figma_design/domain/usecase/get_auth_status.dart' as _i1021;
import 'package:figma_design/domain/usecase/get_boards.dart' as _i527;
import 'package:figma_design/domain/usecase/get_posts.dart' as _i846;
import 'package:figma_design/domain/usecase/login.dart' as _i900;
import 'package:figma_design/domain/usecase/logout.dart' as _i710;
import 'package:figma_design/domain/usecase/register.dart' as _i368;
import 'package:figma_design/domain/usecase/restore_session.dart' as _i526;
import 'package:figma_design/domain/usecase/search_posts.dart' as _i183;
import 'package:figma_design/domain/usecase/watch_shake.dart' as _i436;
import 'package:figma_design/presentation/auth/auth_bloc.dart' as _i702;
import 'package:figma_design/presentation/board_list/board_list_bloc.dart'
    as _i678;
import 'package:figma_design/presentation/board_post/board_post_bloc.dart'
    as _i979;
import 'package:figma_design/presentation/create_post/create_post_bloc.dart'
    as _i815;
import 'package:figma_design/presentation/home/home_bloc.dart' as _i226;
import 'package:figma_design/presentation/login/login_bloc.dart' as _i977;
import 'package:figma_design/presentation/newboard/newboard_bloc.dart' as _i259;
import 'package:figma_design/presentation/search/search_bloc.dart' as _i814;
import 'package:figma_design/presentation/signup/signup_bloc.dart' as _i959;
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i183.ImagePicker>(() => registerModule.imagePicker);
    gh.lazySingleton<_i226.AuthApi>(() => registerModule.authApi);
    gh.lazySingleton<_i836.MotionRepository>(
      () => _i424.MotionRepositoryImpl(),
    );
    gh.lazySingleton<_i872.AuthService>(
      () => registerModule.authService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i448.PostService>(
      () => registerModule.postService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i663.BoardService>(
      () => registerModule.boardService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i968.TagService>(
      () => registerModule.tagService(gh<_i361.Dio>()),
    );
    gh.factory<_i815.CreatePostBloc>(
      () => _i815.CreatePostBloc(picker: gh<_i183.ImagePicker>()),
    );
    gh.factory<_i436.WatchShake>(
      () => _i436.WatchShake(gh<_i836.MotionRepository>()),
    );
    gh.lazySingleton<_i287.BoardRepository>(
      () => _i104.BoardRepositoryImpl(gh<_i663.BoardService>()),
    );
    gh.lazySingleton<_i674.AuthRepository>(
      () => _i695.AuthRepositoryImpl(
        gh<_i872.AuthService>(),
        gh<_i226.AuthApi>(),
      ),
    );
    gh.lazySingleton<_i378.TagRepository>(
      () => _i557.TagRepositoryImpl(gh<_i968.TagService>()),
    );
    gh.lazySingleton<_i498.PostRepository>(
      () => _i732.PostRepositoryImpl(gh<_i448.PostService>()),
    );
    gh.factory<_i964.CreateBoard>(
      () => _i964.CreateBoard(gh<_i287.BoardRepository>()),
    );
    gh.factory<_i886.DeleteBoard>(
      () => _i886.DeleteBoard(gh<_i287.BoardRepository>()),
    );
    gh.factory<_i527.GetBoards>(
      () => _i527.GetBoards(gh<_i287.BoardRepository>()),
    );
    gh.factory<_i5.CreatePost>(
      () => _i5.CreatePost(gh<_i498.PostRepository>()),
    );
    gh.factory<_i846.GetPosts>(
      () => _i846.GetPosts(gh<_i498.PostRepository>()),
    );
    gh.factory<_i183.SearchPosts>(
      () => _i183.SearchPosts(gh<_i498.PostRepository>()),
    );
    gh.factory<_i935.CreateTag>(
      () => _i935.CreateTag(gh<_i378.TagRepository>()),
    );
    gh.factory<_i1021.GetAuthStatus>(
      () => _i1021.GetAuthStatus(gh<_i674.AuthRepository>()),
    );
    gh.factory<_i900.Login>(() => _i900.Login(gh<_i674.AuthRepository>()));
    gh.factory<_i710.Logout>(() => _i710.Logout(gh<_i674.AuthRepository>()));
    gh.factory<_i368.Register>(
      () => _i368.Register(gh<_i674.AuthRepository>()),
    );
    gh.factory<_i526.RestoreSession>(
      () => _i526.RestoreSession(gh<_i674.AuthRepository>()),
    );
    gh.factory<_i226.HomeBloc>(() => _i226.HomeBloc(gh<_i846.GetPosts>()));
    gh.factory<_i959.SignUpBloc>(() => _i959.SignUpBloc(gh<_i368.Register>()));
    gh.factory<_i678.BoardListBloc>(
      () => _i678.BoardListBloc(gh<_i527.GetBoards>()),
    );
    gh.factory<_i977.LoginBloc>(() => _i977.LoginBloc(gh<_i900.Login>()));
    gh.factory<_i259.NewboardBloc>(
      () => _i259.NewboardBloc(gh<_i964.CreateBoard>()),
    );
    gh.factoryParam<_i979.BoardPostBloc, String, dynamic>(
      (boardUuid, _) =>
          _i979.BoardPostBloc(gh<_i846.GetPosts>(), boardUuid: boardUuid),
    );
    gh.lazySingleton<_i702.AuthBloc>(
      () => _i702.AuthBloc(
        gh<_i526.RestoreSession>(),
        gh<_i1021.GetAuthStatus>(),
        gh<_i710.Logout>(),
      ),
    );
    gh.factory<_i814.SearchBloc>(
      () => _i814.SearchBloc(gh<_i183.SearchPosts>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i117.RegisterModule {}
