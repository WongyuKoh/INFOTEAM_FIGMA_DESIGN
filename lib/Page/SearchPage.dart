import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';
import '../widgets/Navigator.dart';
import '../widgets/Header.dart';
import '../widgets/NoticeThumbnail.dart';
import '../api/api_client.dart';
import '../api/post_service.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final _postService = PostService(ApiClient().dio);

  List _results = [];
  bool _isLoading = false;
  String _lastSearched = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = _searchController.text;

    // 이전과 같은 텍스트면 API 호출 안함
    if (text == _lastSearched) return;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (text.isEmpty) {
      setState(() {
        _results = [];
        _lastSearched = '';
      });
      return;
    }

    // 500ms 동안 입력이 없으면 API 호출
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(text);
    });
  }

  Future<void> _search(String keyword) async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final result = await _postService.searchPosts(keyword);
      if (!mounted) return;
      setState(() {
        _results = result is List ? result : (result['posts'] ?? []);
        _lastSearched = keyword;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final isEmpty = _searchController.text.isEmpty;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            child: SearchHeader(controller: _searchController),
          ),
          Positioned(
            top: 51 + statusBarHeight, left: 0, right: 0, bottom: 0,
            child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : isEmpty || _results.isEmpty
                ? _buildEmptyView(isEmpty)
                : _buildResultList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView(bool isEmpty) {
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
              color: Color(0xFFB3B3B3),
              fit: BoxFit.contain,
            ),
          ),
          Text(
            isEmpty ? '검색 키워드를 입력해보세요' : '검색 결과가 없습니다',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultList() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 26.0, left: 18.0, right: 18.0),
      child: ListView.separated(
        itemCount: _results.length,
        separatorBuilder: (_, __) => SizedBox(height: 20),
        itemBuilder: (context, index) {
          final post = _results[index];
          final imageUrl = post['imageUrl'] as String?;
          return NoticeThumbnail(
            noticeTitle: post['title'] ?? '',
            noticeDetail: post['body'] ?? '',
            ImageExist: imageUrl != null,
            imageUrl: imageUrl,
          );
        },
      ),
    );
  }
}
