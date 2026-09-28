// ============================================================
// 인증 상태 관리 검증
//
//   flutter test test/auth_bloc_test.dart
//
// 과제 조건 "로그인 상태는 앱을 완전히 종료했다가 다시 켜도 유지되어야 한다" 를
// AuthBloc 수준에서 확인한다. (보안 저장소는 메모리 가짜 구현으로 대체)
// ============================================================

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:figma_design/data/core/token_storage.dart';
import 'package:figma_design/data/repository/auth_repository_impl.dart';
import 'package:figma_design/data/service/auth_api.dart';
import 'package:figma_design/data/service/auth_service.dart';
import 'package:figma_design/domain/usecase/get_auth_status.dart';
import 'package:figma_design/domain/usecase/logout.dart';
import 'package:figma_design/domain/usecase/restore_session.dart';
import 'package:figma_design/presentation/auth/auth_bloc.dart';

const _channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

/// AuthBloc 을 실제 계층(RepositoryImpl → UseCase)으로 조립한다.
/// started/logout 경로는 TokenStorage 만 건드리므로 Service/Api 는 호출되지 않는다.
AuthBloc _buildAuthBloc() {
  final repo = AuthRepositoryImpl(AuthService(Dio()), AuthApi());
  return AuthBloc(RestoreSession(repo), GetAuthStatus(repo), Logout(repo));
}

/// 디스크 대신 메모리에 저장하는 가짜 보안 저장소.
/// 앱을 껐다 켜는 상황 = 메모리 캐시만 비우고 이 Map 은 유지하는 것.
late Map<String, String> fakeDisk;

/// [exp] 초 뒤에 만료되는 가짜 JWT 를 만든다.
String _jwt({required int expiresInSeconds, String nickname = 'crown3'}) {
  String enc(Map<String, dynamic> m) =>
      base64Url.encode(utf8.encode(jsonEncode(m))).replaceAll('=', '');
  final exp = DateTime.now().millisecondsSinceEpoch ~/ 1000 + expiresInSeconds;
  return '${enc({'alg': 'HS256'})}.'
      '${enc({'exp': exp, 'nickname': nickname, 'email': 'a@b.com'})}.'
      'signature';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    fakeDisk = {};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, (call) async {
          final args = (call.arguments as Map?)?.cast<String, dynamic>() ?? {};
          switch (call.method) {
            case 'readAll':
              return Map<String, String>.from(fakeDisk);
            case 'write':
              fakeDisk[args['key'] as String] = args['value'] as String;
              return null;
            case 'delete':
              fakeDisk.remove(args['key']);
              return null;
            case 'deleteAll':
              fakeDisk.clear();
              return null;
            default:
              return null;
          }
        });
  });

  tearDown(() async {
    await TokenStorage.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, null);
  });

  test('토큰이 없으면 unauthenticated 로 시작한다', () async {
    final bloc = _buildAuthBloc();
    bloc.add(const AuthEvent.started());

    final state = await bloc.stream.first;
    expect(state, isA<AuthUnauthenticated>());

    await bloc.close();
  });

  test('✅ 앱을 껐다 켜도 유효한 토큰이 있으면 로그인 상태가 유지된다', () async {
    // ① 로그인 상태를 저장소에 기록한다 (로그인 성공 직후 상황)
    TokenStorage.accessToken = _jwt(expiresInSeconds: 3600);
    TokenStorage.refreshToken = 'refresh-token';
    TokenStorage.email = 'a@b.com';
    TokenStorage.nickname = 'crown3';
    await TokenStorage.persist();

    // ② 앱 종료 흉내 — 메모리 캐시만 날린다. fakeDisk 는 그대로 남아 있다.
    TokenStorage.accessToken = null;
    TokenStorage.refreshToken = null;
    TokenStorage.email = null;
    TokenStorage.nickname = null;
    expect(TokenStorage.isLoggedIn, isFalse);

    // ③ 앱 재시작 — AuthBloc 이 저장소에서 복원한다
    final bloc = _buildAuthBloc();
    bloc.add(const AuthEvent.started());

    final state = await bloc.stream.first;
    expect(state, isA<AuthAuthenticated>());
    expect((state as AuthAuthenticated).nickname, 'crown3');
    expect(state.email, 'a@b.com');

    await bloc.close();
  });

  test('❌ 만료된 토큰이면 미인증으로 처리하고 저장소를 비운다', () async {
    // 이미 만료된(exp 가 과거) 토큰을 저장해 둔다
    TokenStorage.accessToken = _jwt(expiresInSeconds: -10);
    TokenStorage.refreshToken = 'refresh-token';
    await TokenStorage.persist();
    expect(fakeDisk, isNotEmpty);

    TokenStorage.accessToken = null;
    TokenStorage.refreshToken = null;

    final bloc = _buildAuthBloc();
    bloc.add(const AuthEvent.started());

    final state = await bloc.stream.first;
    expect(state, isA<AuthUnauthenticated>());
    // 만료 토큰은 정리된다
    expect(fakeDisk, isEmpty);

    await bloc.close();
  });

  test('로그아웃하면 메모리와 저장소가 모두 비워진다', () async {
    TokenStorage.accessToken = _jwt(expiresInSeconds: 3600);
    TokenStorage.nickname = 'crown3';
    TokenStorage.email = 'a@b.com';
    await TokenStorage.persist();
    expect(fakeDisk, isNotEmpty);

    final bloc = _buildAuthBloc();
    bloc.add(const AuthEvent.started());
    await bloc.stream.firstWhere((s) => s is! AuthUnknown);

    bloc.add(const AuthEvent.loggedOut());
    final state = await bloc.stream.first;

    expect(state, isA<AuthUnauthenticated>());
    expect(TokenStorage.isLoggedIn, isFalse);
    expect(fakeDisk, isEmpty); // 디스크까지 비워졌다

    await bloc.close();
  });
}
