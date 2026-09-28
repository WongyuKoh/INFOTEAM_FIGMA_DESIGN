import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:figma_design/domain/entity/post.dart';
import 'package:figma_design/domain/usecase/search_posts.dart';

part 'search_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class SearchEvent with _$SearchEvent {
  /// 검색창에 한 글자 입력될 때마다 발생. 여기서 바로 API 를 부르지 않고
  /// 500ms 디바운스를 건 뒤 [SearchSubmitted] 로 넘긴다.
  const factory SearchEvent.keywordChanged(String keyword) =
      SearchKeywordChanged;

  /// 실제 검색 실행.
  const factory SearchEvent.submitted(String keyword) = SearchSubmitted;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
@freezed
sealed class SearchState with _$SearchState {
  /// 아직 아무것도 입력하지 않은 상태.
  const factory SearchState.initial() = SearchInitial;
  const factory SearchState.loading() = SearchLoading;

  /// 검색 완료. 결과가 0건이면 [results] 가 빈 리스트다.
  const factory SearchState.loaded(String keyword, List<Post> results) =
      SearchLoaded;
  const factory SearchState.failure(String message) = SearchFailure;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._searchPosts) : super(const SearchState.initial()) {
    on<SearchKeywordChanged>(_onKeywordChanged);
    on<SearchSubmitted>(_onSubmitted);
  }

  // ── ViewModel 스타일 공개 API ── View 는 Event 를 몰라도 된다.
  // keywordChanged 는 내부에서 500ms 디바운스(transformer)를 타고 submit 으로 넘어간다.
  // 이 디바운스가 Bloc 을 유지하는 이유다. (Cubit 이면 직접 구현해야 함)
  void keywordChanged(String keyword) =>
      add(SearchEvent.keywordChanged(keyword));
  void submit(String keyword) => add(SearchEvent.submitted(keyword));

  final SearchPosts _searchPosts;
  Timer? _debounce;

  /// 마지막으로 검색한 키워드. 같은 키워드면 API 를 다시 부르지 않는다.
  String _lastSearched = '';

  void _onKeywordChanged(
    SearchKeywordChanged event,
    Emitter<SearchState> emit,
  ) {
    _debounce?.cancel();

    final keyword = event.keyword.trim();

    if (keyword.isEmpty) {
      _lastSearched = '';
      emit(const SearchState.initial());
      return;
    }
    if (keyword == _lastSearched) return;

    // 500ms 동안 추가 입력이 없으면 그때 실제 검색 이벤트를 넣는다.
    _debounce = Timer(const Duration(milliseconds: 500), () {
      add(SearchEvent.submitted(keyword));
    });
  }

  Future<void> _onSubmitted(
    SearchSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchState.loading());
    try {
      final results = await _searchPosts(event.keyword);
      _lastSearched = event.keyword;
      emit(SearchState.loaded(event.keyword, results));
    } catch (e) {
      emit(SearchState.failure(t.search.failure(error: e)));
    }
  }

  // Bloc 이 닫힐 때 타이머도 반드시 정리한다.
  // 안 하면 이미 닫힌 Bloc 에 add() 가 들어가 예외가 난다.
  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
