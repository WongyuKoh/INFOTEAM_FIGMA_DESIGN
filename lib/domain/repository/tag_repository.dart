/// 태그 데이터 접근 "계약".
abstract interface class TagRepository {
  /// 이미 등록된 태그면 무시하고 넘어간다.
  Future<void> createTagIgnoringDuplicate(String key);
}
