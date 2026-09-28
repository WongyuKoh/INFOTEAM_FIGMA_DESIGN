import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/repository/tag_repository.dart';

/// 태그 등록. 중복이면 무시한다.
@injectable
class CreateTag {
  const CreateTag(this._repository);

  final TagRepository _repository;

  Future<void> call(String key) => _repository.createTagIgnoringDuplicate(key);
}
