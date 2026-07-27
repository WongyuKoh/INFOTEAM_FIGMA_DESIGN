import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/PostInput.dart';
import '../widgets/PhotoAdd.dart';
import '../widgets/Header.dart';
import '../router/app_router.gr.dart';

@RoutePage()
class CreatePostPage extends StatefulWidget {
  final String boardUuid;
  const CreatePostPage({super.key, required this.boardUuid});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  /// 서버가 이미지를 base64 문자열로 주고받아서 고른 즉시 인코딩해 둔다.
  final List<String> _images = [];

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _goToTagPage() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('제목을 입력해주세요')));
      return;
    }
    context.router.push(
      CreateTagRoute(
        boardUuid: widget.boardUuid,
        title: _titleController.text,
        body: _bodyController.text,
        images: List.of(_images),
      ),
    );
  }

  Future<void> _addPhoto() async {
    try {
      // 원본 그대로 base64 로 보내면 본문이 너무 커져서 크기/품질을 줄인다.
      final picked = await _picker.pickMultiImage(
        maxWidth: 1440,
        maxHeight: 1440,
        imageQuality: 85,
      );
      if (picked.isEmpty) return;

      final encoded = <String>[];
      for (final file in picked) {
        encoded.add(base64Encode(await file.readAsBytes()));
      }
      if (!mounted) return;
      setState(() => _images.addAll(encoded));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('사진을 불러오지 못했습니다: $e')));
    }
  }

  void _removePhoto(int index) {
    setState(() => _images.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NewpostCreateHeader(onNext: _goToTagPage),
          Expanded(
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목/본문은 좌우 18, 사진 줄은 좌우 10 이라 여백을 따로 준다.
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: PostTitleInput(controller: _titleController),
                  ),
                  SizedBox(height: 17),
                  // 본문은 제목과 사진 영역 사이의 남은 공간을 모두 차지한다.
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: PostBodyInput(controller: _bodyController),
                    ),
                  ),
                  PhotoRow(
                    onAdd: _addPhoto,
                    photos: _images,
                    onRemove: _removePhoto,
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
