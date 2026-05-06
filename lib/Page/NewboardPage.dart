import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';
import '../widgets/Input.dart';
import '../widgets/Navigator.dart';
import '../widgets/Header.dart';
import '../api/api_client.dart';
import '../api/board_service.dart';

@RoutePage()
class NewboardPage extends StatefulWidget {
  const NewboardPage({super.key});

  @override
  State<NewboardPage> createState() => _NewboardPageState();
}

class _NewboardPageState extends State<NewboardPage> {
  final TextEditingController _boardnamecontroller = TextEditingController();
  final _boardService = BoardService(ApiClient().dio);

  @override
  void dispose() {
    _boardnamecontroller.dispose();
    super.dispose();
  }

  Future<void> _createBoard() async {
    if (_boardnamecontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시판 이름을 입력해주세요')),
      );
      return;
    }
    try {
      final result = await _boardService.createBoard({'title': _boardnamecontroller.text});
      print('[게시판 생성] 성공: $result');
      if (mounted) context.router.maybePop(true);
    } catch (e) {
      print('[게시판 생성] 실패: $e');
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시판 생성 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NewboardCreateHeader(onComplete: _createBoard),
          Expanded(
            child: Newboard(controller: _boardnamecontroller),
          ),
        ]
      ),
    );
  }
}

class Newboard extends StatelessWidget {
  final TextEditingController controller;
  const Newboard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 16.0,
        left: 18.0,
        right: 18.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputBox(InputBoxText: '게시판 이름', controller: controller),
        ],
      ),
    );
  }
}