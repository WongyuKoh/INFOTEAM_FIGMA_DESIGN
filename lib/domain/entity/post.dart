// /posts 계열 API 응답 모델.
//
// 서버가 필드를 누락하거나 null 로 보내도 예외 없이 기본값으로 파싱한다.
// 응답 한 건이 어긋났다고 화면 전체가 죽지 않게 하기 위함이다.

/// GET /posts, GET /posts/search 응답. 형태는 `{ "count": 28, "list": [...] }`.
class PostListResponse {
  const PostListResponse({required this.count, required this.list});

  final int count;
  final List<Post> list;

  factory PostListResponse.fromJson(Map<String, dynamic> json) {
    // 목록을 감싸는 키가 엔드포인트마다 다를 수 있어 알려진 후보를 모두 확인한다.
    final items = _asMapList(
      json['list'] ?? json['posts'] ?? json['data'],
    ).map(Post.fromJson).toList(growable: false);
    return PostListResponse(
      count: _asInt(json['count']) ?? items.length,
      list: items,
    );
  }

  bool get isEmpty => list.isEmpty;
}

/// 게시글 한 건.
class Post {
  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.images,
    this.board,
    this.createdBy,
    this.createdAt,
  });

  final String id;
  final String title;
  final String body;
  final List<String> tags;
  final List<PostImage> images;
  final PostBoard? board;
  final PostUser? createdBy;
  final DateTime? createdAt;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: _asString(json['id']),
    title: _asString(json['title']),
    body: _asString(json['body']),
    tags: _asStringList(json['tags']),
    images: _asMapList(
      json['images'],
    ).map(PostImage.fromJson).toList(growable: false),
    board: _asMap(json['board'])?.let(PostBoard.fromJson),
    createdBy: _asMap(json['createdBy'])?.let(PostUser.fromJson),
    createdAt: _asDateTime(json['createdAt']),
  );

  /// 썸네일로 쓸 첫 번째 이미지의 base64 문자열. 쓸 이미지가 없으면 null.
  String? get thumbnailBase64 {
    for (final image in images) {
      if (image.image.isNotEmpty) return image.image;
    }
    return null;
  }

  bool get hasImage => thumbnailBase64 != null;

  @override
  String toString() => 'Post($id, title: $title, images: ${images.length})';
}

/// 게시글에 첨부된 이미지.
class PostImage {
  const PostImage({required this.id, required this.image});

  final String id;

  /// base64 로 인코딩된 이미지 본문. `data:` 접두어는 붙어 있지 않다.
  final String image;

  factory PostImage.fromJson(Map<String, dynamic> json) =>
      PostImage(id: _asString(json['id']), image: _asString(json['image']));
}

/// 게시글이 속한 게시판.
class PostBoard {
  const PostBoard({
    required this.id,
    required this.title,
    this.createdAt,
    this.creator,
  });

  final String id;
  final String title;
  final DateTime? createdAt;
  final PostUser? creator;

  factory PostBoard.fromJson(Map<String, dynamic> json) => PostBoard(
    id: _asString(json['id']),
    title: _asString(json['title']),
    createdAt: _asDateTime(json['createdAt']),
    creator: _asMap(json['creator'])?.let(PostUser.fromJson),
  );
}

/// 작성자 / 게시판 생성자.
class PostUser {
  const PostUser({
    required this.id,
    required this.email,
    required this.nickname,
    this.createdAt,
  });

  final String id;
  final String email;
  final String nickname;
  final DateTime? createdAt;

  factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
    id: _asString(json['id']),
    email: _asString(json['email']),
    nickname: _asString(json['nickname']),
    createdAt: _asDateTime(json['createdAt']),
  );
}

// --- 파싱 헬퍼 ---

String _asString(Object? value) => value?.toString() ?? '';

int? _asInt(Object? value) =>
    value is int ? value : int.tryParse(value?.toString() ?? '');

DateTime? _asDateTime(Object? value) =>
    value == null ? null : DateTime.tryParse(value.toString());

Map<String, dynamic>? _asMap(Object? value) =>
    value is Map ? Map<String, dynamic>.from(value) : null;

List<Map<String, dynamic>> _asMapList(Object? value) => value is List
    ? value
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList(growable: false)
    : const [];

List<String> _asStringList(Object? value) => value is List
    ? value.map(_asString).where((e) => e.isNotEmpty).toList(growable: false)
    : const [];

extension _Let<T> on T {
  R let<R>(R Function(T) transform) => transform(this);
}
