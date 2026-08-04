import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:figma_design/api/core/token_storage.dart';

String _fakeJwt(Map<String, dynamic> payload) {
  String encode(Map<String, dynamic> part) =>
      base64Url.encode(utf8.encode(jsonEncode(part))).replaceAll('=', '');
  return '${encode({'alg': 'HS256'})}.${encode(payload)}.signature';
}

void main() {
  setUp(TokenStorage.clear);

  group('applyUserJson', () {
    test('최상위 nickname/email 을 저장한다', () {
      expect(
        TokenStorage.applyUserJson({'email': 'a@b.com', 'nickname': '홍길동'}),
        isTrue,
      );
      expect(TokenStorage.nickname, '홍길동');
      expect(TokenStorage.email, 'a@b.com');
    });

    test('중첩된 user 객체에서도 찾는다', () {
      expect(
        TokenStorage.applyUserJson({
          'accessToken': 'x',
          'user': {'email': 'a@b.com', 'nickname': 'crown3'},
        }),
        isTrue,
      );
      expect(TokenStorage.nickname, 'crown3');
    });

    test('nickname 이 없으면 name 을 사용한다', () {
      expect(TokenStorage.applyUserJson({'name': 'yejin'}), isTrue);
      expect(TokenStorage.nickname, 'yejin');
    });

    test('닉네임이 없으면 false 를 반환하고 기존 값을 지우지 않는다', () {
      TokenStorage.nickname = '기존닉';
      expect(TokenStorage.applyUserJson({'accessToken': 'x'}), isFalse);
      expect(TokenStorage.nickname, '기존닉');
    });
  });

  group('updateUserFromToken', () {
    test('JWT payload 의 nickname 을 저장한다', () {
      TokenStorage.accessToken = _fakeJwt({
        'sub': '1',
        'email': 'a@b.com',
        'nickname': 'crown3',
      });
      expect(TokenStorage.updateUserFromToken(), isTrue);
      expect(TokenStorage.nickname, 'crown3');
      expect(TokenStorage.email, 'a@b.com');
    });

    test('토큰이 없거나 형식이 잘못되면 false', () {
      expect(TokenStorage.updateUserFromToken(), isFalse);
      TokenStorage.accessToken = 'not-a-jwt';
      expect(TokenStorage.updateUserFromToken(), isFalse);
    });
  });
}
