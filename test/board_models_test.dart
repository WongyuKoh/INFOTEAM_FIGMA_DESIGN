import 'package:flutter_test/flutter_test.dart';
import 'package:figma_design/api/board/board_models.dart';

void main() {
  group('BoardListResponse.fromJson', () {
    test('실제 /boards 응답을 파싱한다', () {
      final response = BoardListResponse.fromJson({
        'count': 22,
        'list': [
          {
            'id': '265f245a-8a6e-4278-9af8-2935b3e8e153',
            'title': 'WingBang',
            'createdAt': '2024-08-27T08:03:25.784+00:00',
            'creator': {
              'id': 'c9cb1f66-68c8-413f-8915-134db8c9c682',
              'email': 'crowntheking@gm.gist.ac.kr',
              'nickname': 'crown3',
              'createdAt': '2024-08-26T16:34:43.308+00:00',
            },
          },
          {
            'id': 'ccc7d068-7b6c-4022-bc0c-4a02ace2dfcb',
            'title': '새 게판',
            'createdAt': '2024-09-04T02:14:01.384+00:00',
            'creator': {
              'id': '6cae63b1-5ea7-4d87-aab1-43847c7a8cee',
              'email': 'yejin@naver.com',
              'nickname': 'yejin',
              'createdAt': '2024-08-28T11:16:49.937+00:00',
            },
          },
        ],
      });

      // count 는 서버 값을 그대로 쓴다. 목록 길이(2)와 달라도 덮어쓰지 않는다.
      expect(response.count, 22);
      expect(response.list, hasLength(2));

      final first = response.list.first;
      expect(first.id, '265f245a-8a6e-4278-9af8-2935b3e8e153');
      expect(first.title, 'WingBang');
      expect(first.createdAt, DateTime.parse('2024-08-27T08:03:25.784+00:00'));
      expect(first.creator?.nickname, 'crown3');
      expect(first.creator?.email, 'crowntheking@gm.gist.ac.kr');

      expect(response.list[1].title, '새 게판');
    });

    test('필드가 누락되거나 null 이어도 예외를 던지지 않는다', () {
      final response = BoardListResponse.fromJson({
        'list': [
          {'id': 'only-id'},
          {'title': null, 'createdAt': null, 'creator': null},
        ],
      });

      // count 가 없으면 목록 길이로 대체한다.
      expect(response.count, 2);

      final bare = response.list.first;
      expect(bare.id, 'only-id');
      expect(bare.title, isEmpty);
      expect(bare.createdAt, isNull);
      expect(bare.creator, isNull);
      expect(bare.createdDateText, isEmpty);

      expect(response.list[1].creator, isNull);
    });

    test('목록 키가 boards 이거나 없어도 처리한다', () {
      expect(BoardListResponse.fromJson({'boards': []}).list, isEmpty);
      expect(BoardListResponse.fromJson({'count': 0}).list, isEmpty);
      expect(BoardListResponse.fromJson({}).isEmpty, isTrue);
    });

    test('createdDateText 는 0 을 채워 yyyy.MM.dd 로 만든다', () {
      // 오프셋 없는 문자열은 로컬 시각으로 파싱되므로 실행 환경 시간대와 무관하다.
      final board = Board.fromJson({'createdAt': '2024-09-05T10:00:00'});
      expect(board.createdDateText, '2024.09.05');
    });
  });
}
