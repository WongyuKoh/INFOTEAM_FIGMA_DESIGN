import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:figma_design/domain/entity/board.dart';

import '../core/api_config.dart';

part 'board_service.g.dart';

// @Body() : json의 맨 처음 위치, 이 위치에 body를 받겠다는거
// @Path('uuid')는 그 안의 uuid 위치에 uuid를 받겠다는 거

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
