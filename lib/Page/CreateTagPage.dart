import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../widgets/Header.dart';
import '../widgets/TagInput.dart';
import '../widgets/TagCreateButton.dart';
import '../widgets/Tag.dart';
import '../api/core/api_client.dart';
import '../api/post/post_service.dart';
import '../api/tag/tag_service.dart';
import '../router/app_router.gr.dart';

@RoutePage()
class CreateTagPage extends StatefulWidget {
  final String boardUuid;
  final String title;
  final String body;

  /// 글쓰기 화면에서 고른 사진들. base64 문자열이다.
  final List<String> images;

  const CreateTagPage({
    super.key,
    required this.boardUuid,
    required this.title,
    required this.body,
    this.images = const [],
  });

  @override
  State<CreateTagPage> createState() => _CreateTagPageState();
}

class _CreateTagPageState extends State<CreateTagPage> {
  final TextEditingController tagnamecontroller = TextEditingController();
  final List<String> _tags = [];
  final _postService = PostService(ApiClient().dio);
  final _tagService = TagService(ApiClient().dio);
  bool _isSubmitting = false;

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
    // 완료를 연타하면 글이 여러 건 생성되므로 전송 중에는 무시한다.
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);
    try {
      // 서버에 등록되지 않은 태그는 글 생성 시 무시되므로 먼저 등록한다.
      for (final tag in _tags) {
        try {
          await _tagService.createTag({'key': tag});
        } catch (_) {
          // 이미 등록된 태그면 실패해도 그냥 넘어간다.
        }
      }
      await _postService.createPost(widget.boardUuid, {
        'title': widget.title,
        'body': widget.body,
        'tags': _tags,
        'images': widget.images,
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('게시글이 등록되었습니다')));
      context.router.popUntilRouteWithName(MyHomeRoute.name);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('게시글 등록 실패: $e')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
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
                        children: _tags
                            .map((tag) => Tag(tagText: tag))
                            .toList(),
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
