import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';



class Button extends StatelessWidget {
  final String buttonTitle;
  final double topPadding;
  final double leftPadding;
  final double rightPadding;
  final double bottomPadding;
  final double textboxWidth;

  final Function() onPressed;

  const Button({super.key, 
    required this.onPressed, 
    required this.textboxWidth,
    this.buttonTitle = '',
    this.topPadding = 0.0,
    this.leftPadding = 0.0,
    this.rightPadding = 0.0,
    this.bottomPadding = 0.0});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topPadding,    // 위쪽 여백
        left: leftPadding,   // 왼쪽 여백
        right: rightPadding,  // 오른쪽 여백
        bottom: bottomPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          color: Colors.blue, // 테두리 색상
          width: 2, // 테두리 두께
        ),
      ),
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: textboxWidth,
            child: Text(
              buttonTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 24,
            width: 24,
            child: IconButton(
              constraints: BoxConstraints.tightFor(width: 24, height: 24),
              padding: EdgeInsets.zero,
              icon: Assets.icons.right.svg(
                width: 24,  // 👈 아이콘의 가로 크기
                height: 24, // 👈 아이콘의 세로 크기
                fit: BoxFit.contain,
              ),
              onPressed: (){
                print("arrow-right 버튼 클릭");
                onPressed();
              },
            ),
          )
          
        ],

      )
    );
  }
}
