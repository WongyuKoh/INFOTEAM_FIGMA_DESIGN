// ============================================================
// 🏋️ 연습 과제 — 이 화면을 BLoC 으로 바꿔보세요
// ============================================================
// 지금 이 파일은 "BLoC 도입 전" 상태(setState 방식)로 되돌려놓은 것입니다.
// 같은 폴더의 board_post_bloc.dart 에 주석으로 할 일이 적혀 있습니다.
//
// 순서:
//   1) board_post_bloc.dart 를 완성한다
//   2) dart run build_runner build   (freezed 코드 생성)
//   3) 이 파일을 BlocProvider + BlocBuilder 구조로 고친다
//   4) flutter analyze 로 확인
//
// 막히면 lib/Page/board_list/ 를 보세요. 똑같은 패턴의 정답지입니다.
// ============================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';

import '../../router/app_router.gr.dart';
import '../../widgets/Header.dart';
import '../../widgets/NoticeThumbnail.dart';

import '../../di/injection.dart';
import 'board_post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BoardPostPage extends StatelessWidget implements AutoRouteWrapper {
  const BoardPostPage({
    super.key,
    required this.boardName,
    required this.boardUuid,
  });

  final String boardName;
  final String boardUuid;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      // boardUuid(런타임 인자)는 param1 로, PostRepository 는 getIt 이 주입한다.
      create: (_) => getIt<BoardPostBloc>(param1: boardUuid)..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PostHeader(
            postName: boardName,
            onEdit: () async {
              final bloc = context.read<BoardPostBloc>();
              await context.router.push(CreatePostRoute(boardUuid: boardUuid));
              bloc.refresh();
            },
          ),
          Expanded(child: const _BoardPostList()),
        ],
      ),
    );
  }
}

class _BoardPostList extends StatelessWidget {
  const _BoardPostList();

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<BoardPostBloc>();
    bloc.refresh();
    // add() 는 즉시 반환하므로 로딩이 끝날 때까지 기다려야
    // 당김 스피너가 제때 사라진다.
    await bloc.stream.firstWhere(
      (s) => s is! BoardPostLoading,
      // 새로고침 도중 화면을 나가면 스트림이 먼저 닫힌다.
      // orElse 가 없으면 StateError 가 난다.
      orElse: () => bloc.state,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardPostBloc, BoardPostState>(
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
                    onPressed: () => context.read<BoardPostBloc>().refresh(),
                    child: Text(context.t.common.retry),
                  ),
                ),
              ],
            ),
          ),
          loaded: (posts) => RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: posts.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 200),
                      Center(child: Text(context.t.boardPost.empty)),
                    ],
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 18.0,
                      right: 18.0,
                    ),
                    itemCount: posts.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return NoticeThumbnail(
                        noticeTitle: post.title,
                        noticeDetail: post.body,
                        postContext: post,
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
