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
  static void updateUserFromToken() {
    final token = accessToken;
    if (token == null) return;
    final payload = decodeJwtPayload(token);
    if (payload == null) return;
    final emailFromToken = payload['email'] as String?;
    final nicknameFromToken =
        payload['nickname'] as String? ?? payload['name'] as String?;
    if (emailFromToken != null && emailFromToken.isNotEmpty) {
      email = emailFromToken;
    }
    if (nicknameFromToken != null && nicknameFromToken.isNotEmpty) {
      nickname = nicknameFromToken;
    }
  }
}
