import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';

class TagInputBox extends StatefulWidget {
  final TextEditingController controller;
  const TagInputBox({super.key, required this.controller});

  @override
  State<TagInputBox> createState() => _TagInputBoxState();
}

class _TagInputBoxState extends State<TagInputBox> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _hasText = widget.controller.text.isNotEmpty; // 텍스트 있으면 true
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: 48,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: context.t.tag.inputHint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: _hasText ? Color(0xFFFF4500) : Color(0xFFB3B3B3),
              width: 1.5, // 기본 상태
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // 추가
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: _hasText
                  ? Color(0xFFFF4500)
                  : Color(0xFFB3B3B3), // 포커스 시 주황색
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
