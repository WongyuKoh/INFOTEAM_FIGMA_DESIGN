// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:collection/collection.dart' as _i14;
import 'package:figma_design/api/post/post_models.dart' as _i15;
import 'package:figma_design/Page/BoardPostPage.dart' as _i1;
import 'package:figma_design/Page/CreatePostPage.dart' as _i2;
import 'package:figma_design/Page/CreateTagPage.dart' as _i3;
import 'package:figma_design/Page/HomePage.dart' as _i5;
import 'package:figma_design/Page/LoginPage.dart' as _i4;
import 'package:figma_design/Page/NewboardPage.dart' as _i6;
import 'package:figma_design/Page/PostPage.dart' as _i7;
import 'package:figma_design/Page/ProfilePage.dart' as _i8;
import 'package:figma_design/Page/SearchPage.dart' as _i9;
import 'package:figma_design/Page/SignUpPage.dart' as _i10;
import 'package:figma_design/Page/ViewGridPage.dart' as _i11;
import 'package:flutter/material.dart' as _i13;

/// generated route for
/// [_i1.BoardPostPage]
class BoardPostRoute extends _i12.PageRouteInfo<BoardPostRouteArgs> {
  BoardPostRoute({
    _i13.Key? key,
    required String boardName,
    required String boardUuid,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         BoardPostRoute.name,
         args: BoardPostRouteArgs(
           key: key,
           boardName: boardName,
           boardUuid: boardUuid,
         ),
         initialChildren: children,
       );

  static const String name = 'BoardPostRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BoardPostRouteArgs>();
      return _i1.BoardPostPage(
        key: args.key,
        boardName: args.boardName,
        boardUuid: args.boardUuid,
      );
    },
  );
}

class BoardPostRouteArgs {
  const BoardPostRouteArgs({
    this.key,
    required this.boardName,
    required this.boardUuid,
  });

  final _i13.Key? key;

  final String boardName;

  final String boardUuid;

  @override
  String toString() {
    return 'BoardPostRouteArgs{key: $key, boardName: $boardName, boardUuid: $boardUuid}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BoardPostRouteArgs) return false;
    return key == other.key &&
        boardName == other.boardName &&
        boardUuid == other.boardUuid;
  }

  @override
  int get hashCode => key.hashCode ^ boardName.hashCode ^ boardUuid.hashCode;
}

/// generated route for
/// [_i2.CreatePostPage]
class CreatePostRoute extends _i12.PageRouteInfo<CreatePostRouteArgs> {
  CreatePostRoute({
    _i13.Key? key,
    required String boardUuid,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         CreatePostRoute.name,
         args: CreatePostRouteArgs(key: key, boardUuid: boardUuid),
         initialChildren: children,
       );

  static const String name = 'CreatePostRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatePostRouteArgs>();
      return _i2.CreatePostPage(key: args.key, boardUuid: args.boardUuid);
    },
  );
}

class CreatePostRouteArgs {
  const CreatePostRouteArgs({this.key, required this.boardUuid});

  final _i13.Key? key;

  final String boardUuid;

  @override
  String toString() {
    return 'CreatePostRouteArgs{key: $key, boardUuid: $boardUuid}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreatePostRouteArgs) return false;
    return key == other.key && boardUuid == other.boardUuid;
  }

  @override
  int get hashCode => key.hashCode ^ boardUuid.hashCode;
}

/// generated route for
/// [_i3.CreateTagPage]
class CreateTagRoute extends _i12.PageRouteInfo<CreateTagRouteArgs> {
  CreateTagRoute({
    _i13.Key? key,
    required String boardUuid,
    required String title,
    required String body,
    List<String> images = const [],
    List<_i12.PageRouteInfo>? children,
  }) : super(
         CreateTagRoute.name,
         args: CreateTagRouteArgs(
           key: key,
           boardUuid: boardUuid,
           title: title,
           body: body,
           images: images,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateTagRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateTagRouteArgs>();
      return _i3.CreateTagPage(
        key: args.key,
        boardUuid: args.boardUuid,
        title: args.title,
        body: args.body,
        images: args.images,
      );
    },
  );
}

class CreateTagRouteArgs {
  const CreateTagRouteArgs({
    this.key,
    required this.boardUuid,
    required this.title,
    required this.body,
    this.images = const [],
  });

  final _i13.Key? key;

  final String boardUuid;

  final String title;

  final String body;

  final List<String> images;

  @override
  String toString() {
    return 'CreateTagRouteArgs{key: $key, boardUuid: $boardUuid, title: $title, body: $body, images: $images}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateTagRouteArgs) return false;
    return key == other.key &&
        boardUuid == other.boardUuid &&
        title == other.title &&
        body == other.body &&
        const _i14.ListEquality<String>().equals(images, other.images);
  }

  @override
  int get hashCode =>
      key.hashCode ^
      boardUuid.hashCode ^
      title.hashCode ^
      body.hashCode ^
      const _i14.ListEquality<String>().hash(images);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginPage();
    },
  );
}

/// generated route for
/// [_i5.MyHomePage]
class MyHomeRoute extends _i12.PageRouteInfo<void> {
  const MyHomeRoute({List<_i12.PageRouteInfo>? children})
    : super(MyHomeRoute.name, initialChildren: children);

  static const String name = 'MyHomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.MyHomePage();
    },
  );
}

/// generated route for
/// [_i6.NewboardPage]
class NewboardRoute extends _i12.PageRouteInfo<void> {
  const NewboardRoute({List<_i12.PageRouteInfo>? children})
    : super(NewboardRoute.name, initialChildren: children);

  static const String name = 'NewboardRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.NewboardPage();
    },
  );
}

/// generated route for
/// [_i7.PostPage]
class PostRoute extends _i12.PageRouteInfo<PostRouteArgs> {
  PostRoute({
    _i13.Key? key,
    required _i15.Post postContext,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         PostRoute.name,
         args: PostRouteArgs(key: key, postContext: postContext),
         initialChildren: children,
       );

  static const String name = 'PostRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostRouteArgs>();
      return _i7.PostPage(key: args.key, postContext: args.postContext);
    },
  );
}

class PostRouteArgs {
  const PostRouteArgs({this.key, required this.postContext});

  final _i13.Key? key;

  final _i15.Post postContext;

  @override
  String toString() {
    return 'PostRouteArgs{key: $key, postContext: $postContext}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostRouteArgs) return false;
    return key == other.key && postContext == other.postContext;
  }

  @override
  int get hashCode => key.hashCode ^ postContext.hashCode;
}

/// generated route for
/// [_i8.ProfilePage]
class ProfileRoute extends _i12.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i13.Key? key,
    bool islogin = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ProfileRoute.name,
         args: ProfileRouteArgs(key: key, islogin: islogin),
         initialChildren: children,
       );

  static const String name = 'ProfileRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>(
        orElse: () => const ProfileRouteArgs(),
      );
      return _i8.ProfilePage(key: args.key, islogin: args.islogin);
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key, this.islogin = false});

  final _i13.Key? key;

  final bool islogin;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, islogin: $islogin}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileRouteArgs) return false;
    return key == other.key && islogin == other.islogin;
  }

  @override
  int get hashCode => key.hashCode ^ islogin.hashCode;
}

/// generated route for
/// [_i9.SearchPage]
class SearchRoute extends _i12.PageRouteInfo<void> {
  const SearchRoute({List<_i12.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.SearchPage();
    },
  );
}

/// generated route for
/// [_i10.SignUpPage]
class SignUpRoute extends _i12.PageRouteInfo<void> {
  const SignUpRoute({List<_i12.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.SignUpPage();
    },
  );
}

/// generated route for
/// [_i11.ViewGridPage]
class ViewGridRoute extends _i12.PageRouteInfo<void> {
  const ViewGridRoute({List<_i12.PageRouteInfo>? children})
    : super(ViewGridRoute.name, initialChildren: children);

  static const String name = 'ViewGridRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.ViewGridPage();
    },
  );
}
