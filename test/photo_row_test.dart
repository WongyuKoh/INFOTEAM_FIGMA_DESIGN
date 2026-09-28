import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:figma_design/i18n/strings.g.dart';
import 'package:figma_design/widgets/PhotoAdd.dart';

/// 1x1 짜리 투명 PNG. 실제 이미지 디코딩까지 태우기 위한 최소 샘플.
const String kTinyPng =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  testWidgets('사진이 없으면 추가 박스만 보인다', (tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(body: PhotoRow(onAdd: () {})),
        ),
      ),
    );

    expect(find.byType(PhotoAddBox), findsOneWidget);
    expect(find.byType(PhotoItem), findsNothing);
  });

  testWidgets('고른 사진 수만큼 썸네일이 붙는다', (tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(body: PhotoRow(photos: [kTinyPng, kTinyPng])),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(PhotoAddBox), findsOneWidget);
    expect(find.byType(PhotoItem), findsNWidgets(2));
  });

  testWidgets('썸네일의 X 를 누르면 해당 인덱스로 삭제가 요청된다', (tester) async {
    final removed = <int>[];
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: PhotoRow(photos: [kTinyPng, kTinyPng], onRemove: removed.add),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byIcon(Icons.cancel).last);
    await tester.pump();

    expect(removed, [1]);
  });

  test('data URI 접두어가 붙어 있어도 디코딩된다', () {
    expect(decodeBase64Image(kTinyPng), isNotNull);
    expect(decodeBase64Image('data:image/png;base64,$kTinyPng'), isNotNull);
    expect(decodeBase64Image('이건 base64 가 아님'), isNull);
  });
}
