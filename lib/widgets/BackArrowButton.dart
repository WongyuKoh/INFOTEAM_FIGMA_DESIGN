import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';

class BackArrowButton extends StatelessWidget {
  final double opacity;
  const BackArrowButton({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: 24,
        height: 24,
        child: IconButton(
          constraints: BoxConstraints.tightFor(width: 24, height: 24),
          padding: EdgeInsets.fromLTRB(5.1, 5, 0, 0),
          icon: Assets.icons.left.svg(
            width: 7.9, // 👈 아이콘의 가로 크기
            height: 14, // 👈 아이콘의 세로 크기
            fit: BoxFit.contain,
          ),
          onPressed: () {
            context.router.back();
            print("left 버튼 클릭");
          },
        ),
      ),
    );
  }
}
