import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'post_service.g.dart';

@RestApi(baseUrl: 'https://api.bulletin.newbies.gistory.me')
abstract class PostService {
  factory PostService(Dio dio, {String baseUrl}) = _PostService;

  @GET('/posts')
  Future<dynamic> getPosts({
    @Query('boardUuid') String? boardUuid,
    @Query('tag') String? tag,
  });

  @GET('/posts/{uuid}')
  Future<dynamic> getPost(@Path('uuid') String uuid);

  @POST('/posts')
  Future<dynamic> createPost(
    @Query('boardUuid') String boardUuid,
    @Body() Map<String, dynamic> body,
  );

  @GET('/posts/search')
  Future<dynamic> searchPosts(@Query('keyword') String keyword);
}
