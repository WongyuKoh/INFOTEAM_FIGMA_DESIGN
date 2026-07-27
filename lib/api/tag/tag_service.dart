import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../core/api_config.dart';

part 'tag_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class TagService {
  factory TagService(Dio dio, {String baseUrl}) = _TagService;

  @GET('/tag')
  Future<dynamic> getTags();

  @POST('/tag')
  Future<dynamic> createTag(@Body() Map<String, dynamic> body);

  @GET('/tag/search')
  Future<dynamic> searchTags(@Query('keyword') String keyword);
}
