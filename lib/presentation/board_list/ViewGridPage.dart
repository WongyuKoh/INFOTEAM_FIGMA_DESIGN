import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/Button.dart';
import '../../widgets/Header.dart';
import '../../widgets/Navigator.dart';
import 'board_list_bloc.dart';

@RoutePage()
class ViewGridPage extends StatelessWidget implements AutoRouteWrapper {
  const ViewGridPage({super.key});

  /// auto_route 는 push 시점에 위젯을 감쌀 수 없어서, 페이지 쪽에서
  /// 자기 자신을 BlocProvider 로 감싸 돌려준다.
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BoardListBloc>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ViewGridHeader(
            // 게시판을 새로 만들고 돌아오면 목록을 다시 불러온다.
            onBoardCreated: () =>
                context.read<BoardListBloc>().refresh(),
          ),
          const Expanded(child: _BoardListView()),
        ],
      ),
      bottomNavigationBar: MainBottomNavigationBar(selectedIndex: 1),
    );
  }
}

class _BoardListView extends StatelessWidget {
  const _BoardListView();

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<BoardListBloc>();
    bloc.refresh();
    // add() 는 즉시 반환하므로 로딩이 끝날 때까지 기다려야
    // 당김 스피너가 제때 사라진다.
    await bloc.stream.firstWhere(
      (s) => s is! BoardListLoading,
      // 새로고침 도중 화면을 나가면 스트림이 먼저 닫힌다.
      // orElse 가 없으면 StateError 가 난다.
      orElse: () => bloc.state,
    ); // s가 BoardListLoading 상태가 아닐때까지 대기
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardListBloc, BoardListState>(
      builder: (context, state) {
        return state.when(
          // 초기 상태 — 아직 아무것도 안 함. 아무것도 그리지 않는다.
          // started 이벤트가 곧바로 들어오므로 실제로는 한 프레임도 안 보인다.
          init: () => const SizedBox.shrink(),

          loading: () => const Center(child: CircularProgressIndicator()),
          // ⚠️ ListView 에 padding 을 주지 않으면 Flutter 가 MediaQuery.padding
          //    (상태바 높이)을 SliverPadding 으로 자동 삽입한다.
          //    헤더가 이미 SafeArea 로 처리했으므로 중복 여백이 되고,
          //    스크롤 콘텐츠 안에 들어가 있어서 스크롤하면 사라졌다 나타난다.
          //    → padding 을 명시하면 자동 삽입이 꺼진다.
          failure: (message) => RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 180),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(message, textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => context.read<BoardListBloc>().refresh(),
                    child: Text(context.t.common.retry),
                  ),
                ),
              ],
            ),
          ),

          loaded: (boards) => RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: boards.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 200),
                      Center(child: Text(context.t.board.empty)),
                    ],
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 13.0,
                      right: 13.0,
                    ),
                    itemCount: boards.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final board = boards[index];
                      return Button(
                        buttonTitle: board.title,
                        topPadding: 15.0,
                        leftPadding: 14.0,
                        rightPadding: 14.0,
                        bottomPadding: 14.0,
                        textboxWidth: 317,
                        onPressed: () => context.router.push(
                          BoardPostRoute(
                            boardName: board.title,
                            boardUuid: board.id,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
