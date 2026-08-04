import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:figma_design/api/core/api_client.dart';
import 'package:figma_design/repository/post_repository.dart';
import 'package:figma_design/repository/tag_repository.dart';
import 'package:figma_design/router/app_router.dart';
import 'package:figma_design/router/app_router.gr.dart';

/// 실제 네트워크로 나가지 않고 요청만 기록하는 어댑터.
/// 앱 코드를 그대로 두고 무엇이 전송되는지 확인하기 위한 것이다.
class _CapturingAdapter implements HttpClientAdapter {
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      '{}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// 태그 화면을 라우터·Provider 와 함께 띄운다.
/// 리팩터링 후 CreateTagPage 는 AutoRouteWrapper 로 Bloc 을 주입받으므로
/// 라우터를 거쳐야 wrappedRoute 가 적용된다.
Widget _app({List<String> images = const []}) {
  final router = AppRouter();
  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => PostRepository()),
      RepositoryProvider(create: (_) => TagRepository()),
    ],
    child: MaterialApp.router(
      routerConfig: router.config(
        deepLinkBuilder: (_) => DeepLink([
          CreateTagRoute(
            boardUuid: 'board-1',
            title: '제목',
            body: '본문',
            images: images,
          ),
        ]),
      ),
    ),
  );
}

void main() {
  late _CapturingAdapter adapter;

  setUp(() {
    adapter = _CapturingAdapter();
    // ApiClient 는 싱글톤이므로 어댑터만 교체하면 페이지 코드를 그대로 검증할 수 있다.
    ApiClient().dio.httpClientAdapter = adapter;
  });

  testWidgets('추가한 태그가 /tag 등록과 /posts 본문에 실려 나간다', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    // 태그 두 개를 입력하고 '추가' 를 누른다.
    await tester.enterText(find.byType(TextField), '맛집');
    await tester.pump();
    await tester.tap(find.text('추가'));
    await tester.pump();

    await tester.enterText(find.byType(TextField), '광주');
    await tester.pump();
    await tester.tap(find.text('추가'));
    await tester.pump();

    // 화면에 칩으로 표시되는지 확인.
    expect(find.text('#맛집'), findsOneWidget);
    expect(find.text('#광주'), findsOneWidget);

    // '완료' 로 전송.
    await tester.tap(find.text('완료'));
    await tester.pumpAndSettle();

    final tagRequests = adapter.requests
        .where((r) => r.path == '/tag')
        .toList();
    final postRequests = adapter.requests
        .where((r) => r.path == '/posts')
        .toList();

    // 1) 새 태그가 글 생성보다 먼저 /tag 에 등록된다.
    expect(tagRequests, hasLength(2));
    expect(tagRequests.every((r) => r.method == 'POST'), isTrue);
    expect(tagRequests.map((r) => (r.data as Map)['key']).toList(), [
      '맛집',
      '광주',
    ]);

    // 2) 글 생성 요청 본문에 태그가 그대로 실린다.
    expect(postRequests, hasLength(1));
    final body = postRequests.single.data as Map;
    expect(body['tags'], ['맛집', '광주']);
    expect(body['title'], '제목');
    expect(body['body'], '본문');
    expect(postRequests.single.queryParameters['boardUuid'], 'board-1');

    // 스낵바 타이머 정리.
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('글쓰기에서 고른 사진이 글 생성 본문에 실려 나간다', (tester) async {
    await tester.pumpWidget(_app(images: const ['base64-1', 'base64-2']));
    await tester.pumpAndSettle();

    await tester.tap(find.text('완료'));
    await tester.pumpAndSettle();

    final body =
        adapter.requests.singleWhere((r) => r.path == '/posts').data as Map;
    expect(body['images'], ['base64-1', 'base64-2']);

    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('완료를 연타해도 글은 한 번만 생성된다', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '맛집');
    await tester.pump();
    await tester.tap(find.text('추가'));
    await tester.pump();

    // 응답을 기다리지 않고 연속으로 세 번 누른다.
    await tester.tap(find.text('완료'));
    await tester.tap(find.text('완료'));
    await tester.tap(find.text('완료'));
    await tester.pumpAndSettle();

    expect(adapter.requests.where((r) => r.path == '/posts').length, 1);

    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('태그를 추가하지 않으면 /tag 요청 없이 빈 배열이 전송된다', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('완료'));
    await tester.pumpAndSettle();

    expect(adapter.requests.where((r) => r.path == '/tag'), isEmpty);
    final body =
        adapter.requests.firstWhere((r) => r.path == '/posts').data as Map;
    expect(body['tags'], isEmpty);

    await tester.pump(const Duration(seconds: 5));
  });
}
