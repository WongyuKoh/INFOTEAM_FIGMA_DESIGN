import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../core/api_config.dart';
import 'board_models.dart';

part 'board_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class BoardService {
  factory BoardService(Dio dio, {String baseUrl}) = _BoardService;

  @GET('/boards')
  Future<BoardListResponse> getBoards();

  @POST('/boards')
  Future<dynamic> createBoard(@Body() Map<String, dynamic> body);

  @DELETE('/boards/{uuid}')
  Future<void> deleteBoard(@Path('uuid') String uuid);
}
