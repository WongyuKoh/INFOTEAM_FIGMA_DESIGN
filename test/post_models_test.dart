import 'package:flutter_test/flutter_test.dart';
import 'package:figma_design/api/post/post_models.dart';

void main() {
  group('PostListResponse.fromJson', () {
    test('실제 /posts 응답을 파싱한다', () {
      final response = PostListResponse.fromJson({
        'count': 3,
        'list': [
          {
            'id': '9c0847eb-50f1-4ede-8399-6565a1583c64',
            'title': '괜차나',
            'body': '괜차나 딩딩딩',
            'tags': <String>[],
            'board': {
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
            'createdAt': '2024-08-31T15:11:16.342+00:00',
            'createdBy': {
              'id': 'c9cb1f66-68c8-413f-8915-134db8c9c682',
              'email': 'crowntheking@gm.gist.ac.kr',
              'nickname': 'crown3',
              'createdAt': '2024-08-26T16:34:43.308+00:00',
            },
            'images': <Map<String, dynamic>>[],
          },
          {
            'id': 'd3a70b1d-6d37-44df-a3a6-6e035238bc8b',
            'title': '태그 테스트',
            'body': '태그 테스트',
            'tags': ['1210', '1'],
            'board': {'id': 'ccc7d068', 'title': '새 게판'},
            'createdAt': '2024-09-09T15:59:28.489+00:00',
            'createdBy': {'id': '6cae63b1', 'email': 'yejin@naver.com'},
            'images': [
              {
                'image': 'UklGRooMAABXRUJQVlA4IH4MAADQRACdASrIAMgA',
                'id': 'b53a',
              },
            ],
          },
        ],
      });

      expect(response.count, 3);
      expect(response.list, hasLength(2));

      final first = response.list.first;
      expect(first.id, '9c0847eb-50f1-4ede-8399-6565a1583c64');
      expect(first.title, '괜차나');
      expect(first.body, '괜차나 딩딩딩');
      expect(first.tags, isEmpty);
      expect(first.images, isEmpty);
      expect(first.hasImage, isFalse);
      expect(first.thumbnailBase64, isNull);
      expect(first.board?.title, 'WingBang');
      expect(first.board?.creator?.nickname, 'crown3');
      expect(first.createdBy?.email, 'crowntheking@gm.gist.ac.kr');
      expect(first.createdAt, DateTime.parse('2024-08-31T15:11:16.342+00:00'));

      final second = response.list[1];
      expect(second.tags, ['1210', '1']);
      expect(second.hasImage, isTrue);
      expect(second.thumbnailBase64, startsWith('UklGRooMAABXRUJQ'));
      expect(second.images.single.id, 'b53a');
      // 응답에 없는 중첩 필드는 예외 없이 null 로 남는다.
      expect(second.board?.createdAt, isNull);
      expect(second.createdBy?.nickname, isEmpty);
    });

    test('필드가 누락되거나 null 이어도 예외를 던지지 않는다', () {
      final response = PostListResponse.fromJson({
        'list': [
          {'id': 'only-id'},
          {'title': null, 'body': null, 'tags': null, 'images': null},
        ],
      });

      // count 가 없으면 목록 길이로 대체한다.
      expect(response.count, 2);

      final bare = response.list.first;
      expect(bare.title, isEmpty);
      expect(bare.tags, isEmpty);
      expect(bare.images, isEmpty);
      expect(bare.board, isNull);
      expect(bare.createdBy, isNull);
      expect(bare.createdAt, isNull);

      final nulls = response.list[1];
      expect(nulls.hasImage, isFalse);
      expect(nulls.thumbnailBase64, isNull);
    });

    test('목록 키가 posts 이거나 없어도 처리한다', () {
      expect(PostListResponse.fromJson({'posts': []}).list, isEmpty);
      expect(PostListResponse.fromJson({'count': 0}).list, isEmpty);
      expect(PostListResponse.fromJson({}).isEmpty, isTrue);
    });

    test('빈 문자열 이미지는 썸네일로 쓰지 않는다', () {
      final post = Post.fromJson({
        'images': [
          {'image': '', 'id': 'a'},
          {'image': 'REALDATA', 'id': 'b'},
        ],
      });

      expect(post.images, hasLength(2));
      expect(post.thumbnailBase64, 'REALDATA');
    });
  });
}
