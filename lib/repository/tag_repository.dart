import '../api/core/api_client.dart';
import '../api/tag/tag_service.dart';

/// 태그 관련 데이터 접근.
class TagRepository {
  TagRepository({TagService? service})
    : _service = service ?? TagService(ApiClient().dio);

  final TagService _service;

  /// 이미 등록된 태그면 서버가 실패를 돌려주는데, 그건 정상 흐름이라 삼킨다.
  /// 등록 시도 자체가 목적이므로 호출자는 결과를 신경 쓸 필요가 없다.
  Future<void> createTagIgnoringDuplicate(String key) async {
    try {
      await _service.createTag({'key': key});
    } catch (_) {
      // 중복 태그 — 무시하고 진행한다.
    }
  }
}
