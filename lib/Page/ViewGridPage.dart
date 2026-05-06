import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:figma_design/router/app_router.gr.dart';
import '../widgets/Button.dart';
import '../widgets/Navigator.dart';
import '../widgets/Header.dart';
import '../api/api_client.dart';
import '../api/board_service.dart';

@RoutePage()
class ViewGridPage extends StatefulWidget {
  const ViewGridPage({super.key});

  @override
  State<ViewGridPage> createState() => _ViewGridPageState();
}

class _ViewGridPageState extends State<ViewGridPage> {
  final _boardService = BoardService(ApiClient().dio);
  List _boards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBoards();
  }

  Future<void> _fetchBoards() async {
    print('[ViewGridPage] _fetchBoards 시작');
    try {
      final result = await _boardService.getBoards();
      print('[ViewGridPage] getBoards 응답: $result');
      if (!mounted) return;
      setState(() {
        _boards = result is List ? result : (result['boards'] ?? []);
        _isLoading = false;
      });
      print('[ViewGridPage] 게시판 ${_boards.length}개 로드됨');
    } catch (e) {
      print('[ViewGridPage] getBoards 실패: $e');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshBoards() async {
    print('[ViewGridPage] _refreshBoards 호출됨');
    if (!mounted) return;
    setState(() => _isLoading = true);
    await _fetchBoards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ViewGridHeader(onBoardCreated: _refreshBoards),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _boards.isEmpty
                    ? RefreshIndicator(
                        onRefresh: _refreshBoards,
                        child: ListView(
                          children: [
                            SizedBox(height: 200),
                            Center(child: Text('게시판이 없습니다 (당겨서 새로고침)')),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshBoards,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            top: 16.0,
                            left: 13.0,
                            right: 13.0,
                          ),
                          child: ListView.separated(
                            itemCount: _boards.length,
                            separatorBuilder: (_, _ii) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final board = _boards[index];
                              return Button(
                                buttonTitle: board['title'] ?? '',
                                topPadding: 15.0, leftPadding: 14.0,
                                rightPadding: 14.0, bottomPadding: 14.0,
                                textboxWidth: 317,
                                onPressed: () => context.router.push(
                                  BoardPostRoute(
                                    boardName: board['title'] ?? '',
                                    boardUuid: board['uuid'] ?? '',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNavigationBar(selectedIndex: 1),
    );
  }
}
