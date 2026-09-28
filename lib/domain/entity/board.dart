// /boards 계열 API 응답 모델.
//
// 서버가 필드를 누락하거나 null 로 보내도 예외 없이 기본값으로 파싱한다.
// 응답 한 건이 어긋났다고 화면 전체가 죽지 않게 하기 위함이다.

/// GET /boards 응답. 형태는 `{ "count": 22, "list": [...] }`.
class BoardListResponse {
  const BoardListResponse({required this.count, required this.list});

  final int count;
  final List<Board> list;

  factory BoardListResponse.fromJson(Map<String, dynamic> json) {
    // 목록을 감싸는 키가 엔드포인트마다 다를 수 있어 알려진 후보를 모두 확인한다.
    final items = _asMapList(
      json['list'] ?? json['boards'] ?? json['data'],
    ).map(Board.fromJson).toList(growable: false);
    return BoardListResponse(
      count: _asInt(json['count']) ?? items.length,
      list: items,
    );
  }

  bool get isEmpty => list.isEmpty;
}

/// 게시판 한 건.
class Board {
  const Board({
    required this.id,
    required this.title,
    this.createdAt,
    this.creator,
  });

  /// 게시판 식별자. 게시글 조회/작성 시 `boardUuid` 로 넘기는 값이다.
  final String id;
  final String title;
  final DateTime? createdAt;
  final BoardUser? creator;

  factory Board.fromJson(Map<String, dynamic> json) => Board(
    id: _asString(json['id']),
    title: _asString(json['title']),
    createdAt: _asDateTime(json['createdAt']),
    creator: _asMap(json['creator'])?.let(BoardUser.fromJson),
  );

  /// 생성일을 `2024.09.09` 형태로. 한국 시간 기준. 없으면 빈 문자열.
  String get createdDateText {
    final d = createdAt?.toLocal();
    if (d == null) return '';
    return '${d.year}.'
        '${d.month.toString().padLeft(2, '0')}.'
        '${d.day.toString().padLeft(2, '0')}';
  }

  @override
  String toString() => 'Board($id, title: $title)';
}

/// 게시판을 만든 사용자.
class BoardUser {
  const BoardUser({
    required this.id,
    required this.email,
    required this.nickname,
    this.createdAt,
  });

  final String id;
  final String email;
  final String nickname;
  final DateTime? createdAt;

  factory BoardUser.fromJson(Map<String, dynamic> json) => BoardUser(
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

extension _Let<T> on T {
  R let<R>(R Function(T) transform) => transform(this);
}
