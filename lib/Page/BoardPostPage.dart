import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../widgets/Header.dart';
import '../widgets/NoticeThumbnail.dart';
import '../api/core/api_client.dart';
import '../api/post/post_models.dart';
import '../api/post/post_service.dart';
import '../router/app_router.gr.dart';

@RoutePage()
class BoardPostPage extends StatefulWidget {
  final String boardName;
  final String boardUuid;
  const BoardPostPage({
    super.key,
    required this.boardName,
    required this.boardUuid,
  });

  @override
  State<BoardPostPage> createState() => _BoardPostPageState();
}

class _BoardPostPageState extends State<BoardPostPage> {
  final _postService = PostService(ApiClient().dio);
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final result = await _postService.getPosts(boardUuid: widget.boardUuid);
      if (!mounted) return;
      setState(() {
        _posts = result.list;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PostHeader(
            postName: widget.boardName,
            onEdit: () => context.router.push(
              CreatePostRoute(boardUuid: widget.boardUuid),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _posts.isEmpty
                ? Center(child: Text('게시글이 없습니다'))
                : Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: 16.0,
                      left: 18.0,
                      right: 18.0,
                    ),
                    child: ListView.separated(
                      itemCount: _posts.length,
                      separatorBuilder: (_, __) => SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        return NoticeThumbnail(
                          noticeTitle: post.title,
                          noticeDetail: post.body,
                          postContext: post,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
