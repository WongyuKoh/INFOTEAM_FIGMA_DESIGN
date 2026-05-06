import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';

class Tag extends StatelessWidget {
  final tagText;
  const Tag({super.key,required this.tagText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      padding: EdgeInsets.only(
        top: 4.0,    // 위쪽 여백
        left: 6.0,   // 왼쪽 여백
        right: 6.0,  // 오른쪽 여백
        bottom: 4.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF727272),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '#'+tagText,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 12,
          height: 1.47,
        ),
      ),
    );
  }
}