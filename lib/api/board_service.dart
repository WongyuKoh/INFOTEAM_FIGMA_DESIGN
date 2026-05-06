import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'board_service.g.dart';

@RestApi(baseUrl: 'https://api.bulletin.newbies.gistory.me')
abstract class BoardService {
  factory BoardService(Dio dio, {String baseUrl}) = _BoardService;

  @GET('/boards')
  Future<dynamic> getBoards();

  @POST('/boards')
  Future<dynamic> createBoard(@Body() Map<String, dynamic> body);

  @DELETE('/boards/{uuid}')
  Future<void> deleteBoard(@Path('uuid') String uuid);
}
