import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:figma_design/Page/create_tag/CreateTagPage.dart';
import 'package:figma_design/repository/post_repository.dart';
import 'package:figma_design/repository/tag_repository.dart';
import 'package:figma_design/widgets/PhotoAdd.dart';
import 'package:figma_design/router/app_router.dart';
import 'package:figma_design/router/app_router.gr.dart';

import 'photo_row_test.dart' show kTinyPng;

/// 갤러리 대신 정해진 이미지를 돌려주는 가짜 피커.
class _FakeImagePicker extends ImagePickerPlatform {
  _FakeImagePicker(this.images);

  final List<Uint8List> images;
  MultiImagePickerOptions? lastOptions;

  @override
  Future<List<XFile>> getMultiImageWithOptions({
    MultiImagePickerOptions options = const MultiImagePickerOptions(),
  }) async {
    lastOptions = options;
    return [
      for (var i = 0; i < images.length; i++)
        XFile.fromData(images[i], name: 'picked-$i.png', mimeType: 'image/png'),
    ];
  }
}

/// 글쓰기 화면을 라우터와 함께 띄운다. (다음 버튼 이동까지 확인하기 위함)
Widget _app() {
  final router = AppRouter();
  // 각 화면의 Bloc 이 Repository 를 context 에서 꺼내므로 main.dart 와 같은
  // Provider 구성을 테스트에서도 갖춰준다.
  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => PostRepository()),
      RepositoryProvider(create: (_) => TagRepository()),
    ],
    child: MaterialApp.router(
      routerConfig: router.config(
        deepLinkBuilder: (_) =>
            DeepLink([CreatePostRoute(boardUuid: 'board-1')]),
      ),
    ),
  );
}

void main() {
  testWidgets('제목/내용 입력란과 사진 추가 영역이 보인다', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('게시글 작성'), findsOneWidget);
    expect(find.text('제목'), findsOneWidget);
    expect(find.text('내용을 입력해주세요'), findsOneWidget);
    expect(find.byType(PhotoAddBox), findsOneWidget);
    expect(find.text('사진 추가'), findsOneWidget);
  });

  testWidgets('제목이 비어 있으면 다음 버튼이 이동하지 않고 안내를 띄운다', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();

    expect(find.text('제목을 입력해주세요'), findsOneWidget);
    expect(find.byType(CreateTagPage), findsNothing);
  });

  testWidgets('제목을 입력하고 다음을 누르면 태그 추가 화면으로 넘어간다', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '오늘의 점심');
    await tester.enterText(find.byType(TextField).last, '학식 후기입니다');
    await tester.pump();

    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();

    final tagPage = tester.widget<CreateTagPage>(find.byType(CreateTagPage));
    expect(tagPage.boardUuid, 'board-1');
    expect(tagPage.title, '오늘의 점심');
    expect(tagPage.body, '학식 후기입니다');
  });

  testWidgets('사진 추가로 고른 사진이 썸네일로 붙고, 다음 화면까지 전달된다', (tester) async {
    final bytes = base64Decode(kTinyPng);
    final picker = _FakeImagePicker([bytes, bytes]);
    ImagePickerPlatform.instance = picker;

    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PhotoAddBox));
    await tester.pumpAndSettle();

    // 고른 만큼 썸네일이 붙는다.
    expect(find.byType(PhotoItem), findsNWidgets(2));
    // 본문이 커지지 않도록 크기/품질 제한을 걸고 요청한다.
    expect(picker.lastOptions?.imageOptions.maxWidth, 1440);
    expect(picker.lastOptions?.imageOptions.imageQuality, 85);

    // 썸네일 하나를 지우면 하나만 남는다.
    await tester.tap(find.byIcon(Icons.cancel).first);
    await tester.pumpAndSettle();
    expect(find.byType(PhotoItem), findsOneWidget);

    // 남은 사진이 base64 로 태그 화면까지 넘어간다.
    await tester.enterText(find.byType(TextField).first, '사진 있는 글');
    await tester.pump();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();

    final tagPage = tester.widget<CreateTagPage>(find.byType(CreateTagPage));
    expect(tagPage.images, [base64Encode(bytes)]);
  });
}
