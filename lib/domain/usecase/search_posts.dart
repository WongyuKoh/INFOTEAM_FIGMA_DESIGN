import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/entity/post.dart';
import 'package:figma_design/domain/repository/post_repository.dart';

/// 키워드로 게시글 검색.
@injectable
class SearchPosts {
  const SearchPosts(this._repository);

  final PostRepository _repository;

  Future<List<Post>> call(String keyword) => _repository.searchPosts(keyword);
}
