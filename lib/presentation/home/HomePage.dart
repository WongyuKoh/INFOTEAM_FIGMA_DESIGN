import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../domain/usecase/watch_shake.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/Header.dart';
import '../../widgets/Navigator.dart';
import '../../widgets/NoticeThumbnail.dart';
import 'board_picker_sheet.dart';
import 'home_bloc.dart';

@RoutePage()
class MyHomePage extends StatelessWidget implements AutoRouteWrapper {
  const MyHomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..load(),
      child: this,
    );
  }

  /// 게시판 선택 → 글쓰기 화면 → 돌아오면 목록 새로고침.
  Future<void> _onWrite(BuildContext context) async {
    final bloc = context.read<HomeBloc>();
    final router = context.router;

    final selected = await showBoardPickerSheet(context);
    if (selected == null) return;

    await router.push(CreatePostRoute(boardUuid: selected.id));
    bloc.refresh();
  }

  @override
  Widget build(BuildContext context) {
    // 기기를 흔들면 목록을 새로고침한다. (네이티브 모션 센서)
    return _ShakeToRefresh(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeHeader(onWrite: () => _onWrite(context)),
            const Expanded(child: _HomePostList()),
          ],
        ),
        bottomNavigationBar: MainBottomNavigationBar(selectedIndex: 0),
      ),
    );
  }
}

/// 흔들기(가속도계)를 구독해 [HomeBloc] 을 새로고침시키는 래퍼.
/// WatchShake UseCase 만 알고, 어떤 센서 플러그인을 쓰는지는 모른다.
class _ShakeToRefresh extends StatefulWidget {
  const _ShakeToRefresh({required this.child});

  final Widget child;

  @override
  State<_ShakeToRefresh> createState() => _ShakeToRefreshState();
}

class _ShakeToRefreshState extends State<_ShakeToRefresh> {
  StreamSubscription<void>? _sub;

  @override
  void initState() {
    super.initState();
    _sub = getIt<WatchShake>().call().listen((_) {
      if (!mounted) return;
      context.read<HomeBloc>().refresh();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.t.home.shakeRefreshed),
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _HomePostList extends StatelessWidget {
  const _HomePostList();

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<HomeBloc>();
    bloc.refresh();
    await bloc.stream.firstWhere(
      (s) => s is! HomeLoading,
      // 새로고침 도중 화면을 나가면 스트림이 먼저 닫힌다.
      orElse: () => bloc.state,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.when(
          // 초기 상태 — 아직 아무것도 안 함. 아무것도 그리지 않는다.
          // started 이벤트가 곧바로 들어오므로 실제로는 한 프레임도 안 보인다.
          init: () => const SizedBox.shrink(),

          loading: () => const Center(child: CircularProgressIndicator()),

          failure: (message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(message, textAlign: TextAlign.center),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      context.read<HomeBloc>().refresh(),
                  child: Text(context.t.common.retry),
                ),
              ],
            ),
          ),

          // ⚠️ ListView 에 padding 을 주지 않으면 Flutter 가 MediaQuery.padding
          //    (상태바 높이)을 SliverPadding 으로 자동 삽입한다.
          //    헤더가 이미 SafeArea 로 처리했으므로 여기선 중복 여백이 되고,
          //    스크롤 콘텐츠 안에 들어가 있어서 스크롤하면 사라졌다 나타난다.
          //    → padding 을 명시하면 자동 삽입이 꺼진다.
          loaded: (posts) => RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: posts.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 200),
                      Center(child: Text(context.t.home.empty)),
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
