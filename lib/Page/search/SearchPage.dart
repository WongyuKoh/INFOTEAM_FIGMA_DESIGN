import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/post/post_models.dart';
import '../../gen/assets.gen.dart';
import '../../repository/post_repository.dart';
import '../../widgets/Header.dart';
import '../../widgets/NoticeThumbnail.dart';
import 'search_bloc.dart';

@RoutePage()
class SearchPage extends StatelessWidget implements AutoRouteWrapper {
  const SearchPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SearchBloc(ctx.read<PostRepository>()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const _SearchView();
}

/// 검색어 입력 컨트롤러는 순수 UI 상태라 위젯이 그대로 들고 있고,
/// 입력이 바뀔 때마다 Bloc 에 이벤트만 보낸다. (디바운스는 Bloc 담당)
class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    context.read<SearchBloc>().add(
      SearchEvent.keywordChanged(_searchController.text),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SearchHeader(controller: _searchController),
          ),
          Positioned(
            top: 51 + statusBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const _SearchMessage('검색 키워드를 입력해보세요'),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  failure: (message) => _SearchMessage(message),
                  loaded: (keyword, results) => results.isEmpty
                      ? const _SearchMessage('검색 결과가 없습니다')
                      : _SearchResultList(results: results),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchMessage extends StatelessWidget {
  const _SearchMessage(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        spacing: 9,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 65,
            height: 65,
            child: Assets.icons.search.svg(
              width: 54,
              height: 54,
              color: const Color(0xFFB3B3B3),
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultList extends StatelessWidget {
  const _SearchResultList({required this.results});

  final List<Post> results;

  @override
  Widget build(BuildContext context) {
    // ⚠️ ListView 에 padding 을 주지 않으면 Flutter 가 MediaQuery.padding
    //    (상태바 높이)을 SliverPadding 으로 자동 삽입한다.
    //    헤더가 이미 SafeArea 로 처리했으므로 중복 여백이 된다.
    return ListView.separated(
      padding: const EdgeInsets.only(top: 26.0, left: 18.0, right: 18.0),
      itemCount: results.length,
      separatorBuilder: (_, _) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final post = results[index];
        return NoticeThumbnail(
          noticeTitle: post.title,
          noticeDetail: post.body,
          postContext: post,
        );
      },
    );
  }
}
