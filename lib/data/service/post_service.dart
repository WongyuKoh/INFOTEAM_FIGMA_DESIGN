import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:figma_design/domain/entity/post.dart';

import '../core/api_config.dart';

part 'post_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class PostService {
  factory PostService(Dio dio, {String baseUrl}) = _PostService;

  @GET('/posts')
  Future<PostListResponse> getPosts({
    @Query('boardUuid') String? boardUuid,
    @Query('tag') String? tag,
  });

  @GET('/posts/{uuid}')
  Future<Post> getPost(@Path('uuid') String uuid);

  @POST('/posts')
  Future<dynamic> createPost(
    @Query('boardUuid') String boardUuid,
    @Body() Map<String, dynamic> body,
  );

  @GET('/posts/search')
  Future<PostListResponse> searchPosts(@Query('keyword') String keyword);
}
