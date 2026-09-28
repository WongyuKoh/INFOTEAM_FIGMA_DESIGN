import 'package:injectable/injectable.dart';

import 'package:figma_design/data/service/tag_service.dart';
import 'package:figma_design/domain/repository/tag_repository.dart';

/// [TagRepository] 의 실제 구현.
@LazySingleton(as: TagRepository)
class TagRepositoryImpl implements TagRepository {
  TagRepositoryImpl(this._service);

  final TagService _service;

  /// 이미 등록된 태그면 서버가 실패를 돌려주는데, 그건 정상 흐름이라 삼킨다.
  @override
  Future<void> createTagIgnoringDuplicate(String key) async {
    try {
      await _service.createTag({'key': key});
    } catch (_) {
      // 중복 태그 — 무시하고 진행한다.
    }
  }
}
