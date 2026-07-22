import 'dart:convert';

class TokenStorage {
  static String? accessToken;
  static String? refreshToken;
  static String? email;
  static String? nickname;

  static bool get isLoggedIn => accessToken != null && accessToken!.isNotEmpty;

  static void clear() {
    accessToken = null;
    refreshToken = null;
    email = null;
    nickname = null;
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
