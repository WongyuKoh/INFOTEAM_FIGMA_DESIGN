import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../widgets/Navigator.dart';
import '../widgets/Header.dart';
import '../widgets/NoticeThumbnail.dart';
import '../api/core/api_client.dart';
import '../api/board/board_models.dart';
import '../api/board/board_service.dart';
import '../api/post/post_models.dart';
import '../api/post/post_service.dart';
import '../router/app_router.gr.dart';

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _postService = PostService(ApiClient().dio);
  final _boardService = BoardService(ApiClient().dio);
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      PostListResponse result = await _postService.getPosts();
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

  Future<void> _onWrite() async {
    // 게시판 목록을 가져와서 선택 다이얼로그를 띄움 → 선택된 게시판으로 글쓰기 페이지 이동
    try {
      final result = await _boardService.getBoards();
      if (!mounted) return;
      final boards = result.list;
      if (boards.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('먼저 게시판을 만들어주세요')));
        return;
      }
      final selected = await showModalBottomSheet<Board>(
        context: context,
        builder: (ctx) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '어떤 게시판에 글을 쓸까요?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // 게시판이 많으면 시트 높이를 넘기므로 목록만 스크롤되게 한다.
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: boards.length,
                  itemBuilder: (_, index) => ListTile(
                    title: Text(boards[index].title),
                    onTap: () => Navigator.of(ctx).pop(boards[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      if (selected == null || !mounted) return;
      await context.router.push(CreatePostRoute(boardUuid: selected.id));
      // 글쓰기 페이지에서 돌아오면 게시글 목록 새로고침
      if (mounted) {
        setState(() => _isLoading = true);
        await _fetchPosts();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('게시판 목록을 불러올 수 없습니다: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeHeader(onWrite: _onWrite),
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
      bottomNavigationBar: MainBottomNavigationBar(selectedIndex: 0),
    );
  }
}
