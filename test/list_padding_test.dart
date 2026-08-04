// ============================================================
// "목록 위 여백은 왜 생겼고, 무엇이 그걸 없앴나"를 실측하는 테스트
//
//   flutter test test/list_padding_test.dart
//
// 상태바 높이를 48 로 가정하고, 첫 항목이 화면 위에서 몇 픽셀에 놓이는지 잰다.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// 상태바 48px 이 있는 환경을 흉내낸다. (MediaQuery.padding.top = 48)
Widget _wrap(Widget listView) {
  return MediaQuery(
    data: const MediaQueryData(padding: EdgeInsets.only(top: 48)),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(width: 400, height: 600, child: listView),
      ),
    ),
  );
}

const _items = [
  SizedBox(height: 100, child: Text('첫번째')),
  SizedBox(height: 100, child: Text('두번째')),
];

void main() {
  testWidgets('A) 수정 전 — Container(top:16) + ListView(padding 없음)', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: ListView(children: _items),
        ),
      ),
    );

    // Container 의 16 + ListView 가 자동 삽입한 상태바 48 = 64
    expect(tester.getTopLeft(find.text('첫번째')).dy, 64);
    //                                              ▲ 여백이 두 겹으로 쌓였다
  });

  testWidgets('B) 수정 후 — ListView(padding: top 16)', (tester) async {
    await tester.pumpWidget(
      _wrap(
        ListView(padding: const EdgeInsets.only(top: 16), children: _items),
      ),
    );

    // padding 을 명시했으므로 자동 삽입이 꺼진다 → 16 만 남는다
    expect(tester.getTopLeft(find.text('첫번째')).dy, 16);
  });

  testWidgets('C) Container 만 지웠다면 — ListView(padding 없음)', (tester) async {
    await tester.pumpWidget(_wrap(ListView(children: _items)));

    // 16 은 사라지지만 상태바 48 은 그대로 남는다.
    // → Container 제거는 해결책이 아니었다는 증거
    expect(tester.getTopLeft(find.text('첫번째')).dy, 48);
  });

  testWidgets('D) 값이 0 이어도 "줬다"는 사실이 중요하다', (tester) async {
    await tester.pumpWidget(
      _wrap(ListView(padding: EdgeInsets.zero, children: _items)),
    );

    // EdgeInsets.zero 는 null 이 아니므로 자동 삽입이 꺼진다 → 여백 0
    expect(tester.getTopLeft(find.text('첫번째')).dy, 0);
  });
}
