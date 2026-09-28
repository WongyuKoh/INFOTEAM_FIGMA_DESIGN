import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 토큰과 사용자 정보를 보관한다.
///
/// 두 겹 구조다.
///   1) 메모리 (static 필드) — Dio Interceptor 가 동기로 읽어야 해서 필요
///   2) flutter_secure_storage — 앱을 껐다 켜도 유지되도록 디스크에 암호화 저장
///      (iOS Keychain / Android Keystore)
///
/// 쓰기는 항상 둘 다 갱신하고, 앱 시작 시 [load] 로 디스크 → 메모리를 채운다.
class TokenStorage {
  static const _keyAccess = 'accessToken';
  static const _keyRefresh = 'refreshToken';
  static const _keyEmail = 'email';
  static const _keyNickname = 'nickname';

  /// 테스트에서 갈아끼울 수 있도록 final 로 두지 않는다.
  ///
  /// 옵션을 따로 주지 않는다. v10 부터 Android 는 기본으로 자체 암호화를 쓰고,
  /// 예전에 쓰던 `AndroidOptions(encryptedSharedPreferences: true)` 는
  /// Jetpack Security 지원 종료로 deprecated 되어 값이 무시된다.
  /// (기존 데이터는 첫 접근 시 자동 마이그레이션된다)
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  // --- 메모리 캐시 ---
  static String? accessToken;
  static String? refreshToken;
  static String? email;
  static String? nickname;

  static bool get isLoggedIn => accessToken != null && accessToken!.isNotEmpty;

  /// access token 의 `exp`(만료 시각)를 확인한다.
  /// 토큰이 없으면 false, exp 클레임이 없으면 판단할 수 없으므로 유효하다고 본다.
  static bool get isAccessTokenValid {
    final token = accessToken;
    if (token == null || token.isEmpty) return false;
    final exp = decodeJwtPayload(token)?['exp'];
    if (exp is! int) return true;
    return DateTime.now().millisecondsSinceEpoch < exp * 1000;
  }

  /// 앱 시작 시 한 번 호출. 디스크에 저장된 값을 메모리로 올린다.
  static Future<void> load() async {
    try {
      final all = await storage.readAll();
      accessToken = all[_keyAccess];
      refreshToken = all[_keyRefresh];
      email = all[_keyEmail];
      nickname = all[_keyNickname];
    } catch (e) {
      // 테스트/웹 등 보안 저장소를 못 쓰는 환경에서는 메모리만으로 동작한다.
      print('[TokenStorage] 불러오기 실패(메모리만 사용): $e');
    }
  }

  /// 메모리 값을 디스크에 반영한다. 값이 null 이면 해당 키를 지운다.
  static Future<void> persist() async {
    Future<void> write(String key, String? value) => value == null
        ? storage.delete(key: key)
        : storage.write(key: key, value: value);
    try {
      await Future.wait([
        write(_keyAccess, accessToken),
        write(_keyRefresh, refreshToken),
        write(_keyEmail, email),
        write(_keyNickname, nickname),
      ]);
    } catch (e) {
      print('[TokenStorage] 저장 실패: $e');
    }
  }

  /// 메모리와 디스크를 모두 비운다. (로그아웃)
  static Future<void> clear() async {
    accessToken = null;
    refreshToken = null;
    email = null;
    nickname = null;
    try {
      await storage.deleteAll();
    } catch (e) {
      print('[TokenStorage] 삭제 실패: $e');
    }
  }

  /// JWT 페이로드를 디코딩해서 Map 으로 반환. 형식이 잘못되면 null.
  static Map<String, dynamic>? decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      String payload = parts[1];
      // base64url padding 보정
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      final decoded = utf8.decode(base64Url.decode(payload));
      final json = jsonDecode(decoded);
      if (json is Map<String, dynamic>) return json;
      return null;
    } catch (_) {
      return null;
    }
  }

  /// access token 안에 들어있는 email/nickname 정보를 자동으로 채워준다.
  /// 닉네임을 찾았으면 true.
  static bool updateUserFromToken() {
    final token = accessToken;
    if (token == null) return false;
    return applyUserJson(decodeJwtPayload(token));
  }

  /// 로그인 응답 본문이나 JWT payload 처럼 형태가 정해지지 않은 JSON 에서
  /// email/nickname 을 찾아 저장한다. (user, data 같은 중첩 객체도 탐색)
  /// 닉네임을 찾았으면 true.
  static bool applyUserJson(Object? json) {
    final foundEmail = _findString(json, const ['email']);
    final foundNickname = _findString(json, _nicknameKeys);
    if (foundEmail != null) email = foundEmail;
    if (foundNickname != null) nickname = foundNickname;
    return foundNickname != null;
  }

  static const List<String> _nicknameKeys = [
    'nickname',
    'nickName',
    'name',
    'username',
    'userName',
  ];

  /// json 안에서 keys 중 하나에 해당하는 비어있지 않은 문자열을 찾는다.
  static String? _findString(Object? json, List<String> keys, {int depth = 0}) {
    if (json == null || depth > 4) return null;
    if (json is List) {
      for (final item in json) {
        final found = _findString(item, keys, depth: depth + 1);
        if (found != null) return found;
      }
      return null;
    }
    if (json is! Map) return null;
    for (final key in keys) {
      final value = json[key];
      if (value is String && value.isNotEmpty) return value;
    }
    for (final value in json.values) {
      final found = _findString(value, keys, depth: depth + 1);
      if (found != null) return found;
    }
    return null;
  }
}
