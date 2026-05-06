import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../widgets/Header.dart';
import '../widgets/TagInput.dart';
import '../widgets/TagCreateButton.dart';
import '../widgets/Tag.dart';
import '../api/api_client.dart';
import '../api/post_service.dart';
import '../router/app_router.gr.dart';

@RoutePage()
class CreateTagPage extends StatefulWidget {
  final String boardUuid;
  final String title;
  final String body;
  const CreateTagPage({
    super.key,
    required this.boardUuid,
    required this.title,
    required this.body,
  });

  @override
  State<CreateTagPage> createState() => _CreateTagPageState();
}

class _CreateTagPageState extends State<CreateTagPage> {
  final TextEditingController tagnamecontroller = TextEditingController();
  final List<String> _tags = [];
  final _postService = PostService(ApiClient().dio);

  @override
  void initState() {
    super.initState();
    tagnamecontroller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tagnamecontroller.dispose();
    super.dispose();
  }

  void _addTag() {
    if (tagnamecontroller.text.isNotEmpty) {
      setState(() {
        _tags.add(tagnamecontroller.text);
        tagnamecontroller.clear();
      });
    }
  }

  Future<void> _submitPost() async {
    try {
      await _postService.createPost(
        widget.boardUuid,
        {
          'title': widget.title,
          'body': widget.body,
          'tags': _tags,
        },
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시글이 등록되었습니다')),
      );
      context.router.popUntilRouteWithName(MyHomeRoute.name);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시글 등록 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NewtagCreateHeader(onComplete: _submitPost),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 366,
                  child: Column(
                    spacing: 24,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 48,
                        child: Row(
                          spacing: 10,
                          children: [
                            TagInputBox(controller: tagnamecontroller),
                            TagCreateButton(
                              tagTextEmpty: tagnamecontroller.text.isEmpty,
                              onTap: _addTag,
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _tags.map((tag) => Tag(tagText: tag)).toList(),
                      ),
                    ],
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
