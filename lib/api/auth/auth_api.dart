import '../core/api_client.dart';
import '../core/token_storage.dart';

class AuthApi {
  final dio = ApiClient().dio;

  // 로그인
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });

    // 토큰 자동 저장
    TokenStorage.accessToken = response.data['accessToken'];
    TokenStorage.refreshToken = response.data['refreshToken'];

    return response.data;
  }

  // 회원가입
  Future<Map<String, dynamic>> register(
    String email,
    String nickname,
    String password,
  ) async {
    final response = await dio.post('/auth/register', data: {
      'email': email,
      'nickname': nickname,
      'password': password,
    });
    return response.data;
  }

  /// 로그인 직후 닉네임을 확보해서 TokenStorage 에 저장한다.
  /// 서버에 내 정보(/auth/me 같은) 엔드포인트가 없기 때문에 아래 순서로 찾는다.
  ///   1) 로그인 응답 본문
  ///   2) accessToken(JWT) payload
  ///   3) /posts 조회 후 내 이메일과 일치하는 작성자의 닉네임
  Future<String?> loadNickname({Object? loginResponse}) async {
    if (TokenStorage.applyUserJson(loginResponse)) {
      print('[로그인] 닉네임 출처: 로그인 응답');
      return TokenStorage.nickname;
    }
    if (TokenStorage.updateUserFromToken()) {
      print('[로그인] 닉네임 출처: accessToken');
      return TokenStorage.nickname;
    }
    final fromPosts = await _fetchNicknameFromPosts();
    if (fromPosts != null) print('[로그인] 닉네임 출처: /posts 작성자 정보');
    return fromPosts;
  }

  /// /posts 응답에 들어있는 작성자(createdBy) / 게시판 생성자(creator) 중
  /// 내 이메일과 같은 사용자를 찾아 닉네임을 가져온다.
  Future<String?> _fetchNicknameFromPosts() async {
    final myEmail = TokenStorage.email?.toLowerCase();
    if (myEmail == null || myEmail.isEmpty) return null;
    try {
      final response = await dio.get('/posts');
      final list = _asMap(response.data)?['list'];
      if (list is! List) return null;
      for (final raw in list) {
        final post = _asMap(raw);
        if (post == null) continue;
        final users = [
          _asMap(post['createdBy']),
          _asMap(_asMap(post['board'])?['creator']),
        ];
        for (final user in users) {
          if (user == null) continue;
          if (user['email']?.toString().toLowerCase() != myEmail) continue;
          final nickname = user['nickname']?.toString();
          if (nickname != null && nickname.isNotEmpty) {
            TokenStorage.nickname = nickname;
            return nickname;
          }
        }
      }
    } catch (e) {
      print('[로그인] 닉네임 조회 실패: $e');
    }
    return null;
  }

  static Map<String, dynamic>? _asMap(Object? value) =>
      value is Map ? Map<String, dynamic>.from(value) : null;

  // 토큰 갱신
  Future<Map<String, dynamic>> refresh() async {
    final response = await dio.post('/auth/refresh', data: {
      'refreshToken': TokenStorage.refreshToken,
    });

    // 새 토큰 저장
    TokenStorage.accessToken = response.data['accessToken'];
    TokenStorage.refreshToken = response.data['refreshToken'];

    return response.data;
  }
}
