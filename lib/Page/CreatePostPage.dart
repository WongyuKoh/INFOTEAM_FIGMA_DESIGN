import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../widgets/Input.dart';
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

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _goToTagPage() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('제목을 입력해주세요')),
      );
      return;
    }
    context.router.push(CreateTagRoute(
      boardUuid: widget.boardUuid,
      title: _titleController.text,
      body: _bodyController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NewpostCreateHeader(onNext: _goToTagPage),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 16.0, left: 18.0, right: 18.0),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputBox(InputBoxText: '게시글 제목', controller: _titleController),
                  InputBox(InputBoxText: '게시글 내용', controller: _bodyController),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
