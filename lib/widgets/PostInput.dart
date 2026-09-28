import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';

/// 글쓰기 화면의 제목 입력란.
/// 테두리 없이 아래쪽 밑줄만 있는 형태. (Figma Write - "제목" + Line 1)
class PostTitleInput extends StatelessWidget {
  final TextEditingController controller;

  /// null 이면 현재 언어의 기본 힌트(context.t.post.titleLabel)를 쓴다.
  /// (기본값에 t 를 직접 넣을 수 없어 build 에서 해석한다)
  final String? hintText;

  const PostTitleInput({super.key, required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 1.47,
    );

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.next,
      style: style.copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText ?? context.t.post.titleLabel,
        hintStyle: style.copyWith(color: Color(0xFF727272)),
        isDense: true,
        // 제목 아래 10, 밑줄까지 포함해 디자인의 98~140 구간을 맞춘다.
        contentPadding: EdgeInsets.only(bottom: 10),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFDADADA), width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFDADADA), width: 1),
        ),
      ),
    );
  }
}

/// 글쓰기 화면의 본문 입력란.
/// 테두리 없이 남은 영역을 모두 차지하며 여러 줄을 입력할 수 있다.
class PostBodyInput extends StatelessWidget {
  final TextEditingController controller;

  /// null 이면 현재 언어의 기본 힌트(context.t.post.bodyHint)를 쓴다.
  final String? hintText;

  const PostBodyInput({super.key, required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.47,
    );

    return TextField(
      controller: controller,
      // expands 를 쓰려면 maxLines/minLines 가 모두 null 이어야 한다.
      maxLines: null,
      minLines: null,
      expands: true,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      style: style.copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText ?? context.t.post.bodyHint,
        hintStyle: style.copyWith(color: Color(0xFF727272)),
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
