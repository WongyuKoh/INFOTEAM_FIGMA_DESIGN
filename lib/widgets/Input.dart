import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';

class InputBox extends StatefulWidget {

  final String InputBoxText;
  final TextEditingController controller;
  const InputBox({super.key, required this.InputBoxText,required this.controller});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {

  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _hasText = widget.controller.text.isNotEmpty;  // 텍스트 있으면 true
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 366,
      height: 75,
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 19,
            child: Text(
              widget.InputBoxText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: '제목 입력',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: _hasText ? Color(0xFFFF4500) : Color(0xFFB3B3B3),
                    width : 1.5,     // 기본 상태
                  ),
                ),
                focusedBorder: OutlineInputBorder(  // 추가
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: _hasText ? Color(0xFFFF4500) : Color(0xFFB3B3B3),  // 포커스 시 주황색
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}