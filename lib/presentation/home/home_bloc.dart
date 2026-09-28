import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:figma_design/domain/entity/post.dart';
import 'package:figma_design/domain/usecase/get_posts.dart';

part 'home_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = HomeStarted;
  const factory HomeEvent.refreshed() = HomeRefreshed;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
/// 서로 배타적인 3가지 상태.
/// "로딩 중이면서 동시에 에러" 같은 불가능한 조합을 아예 만들 수 없다.
@freezed
sealed class HomeState with _$HomeState {
  /// 아무것도 하기 전. 화면에 아무것도 그리지 않는다.
  /// started 이벤트가 들어오면 즉시 loading 으로 바뀐다.
  const factory HomeState.init() = HomeInit;

  const factory HomeState.loading() = HomeLoading;
  const factory HomeState.loaded(List<Post> posts) = HomeLoaded;
  const factory HomeState.failure(String message) = HomeFailure;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
/// 홈 화면의 전체 게시글 목록.
@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getPosts) : super(const HomeState.init()) {
    // started 와 refreshed 는 하는 일이 같아 핸들러를 공유한다.
    on<HomeStarted>(_onLoad);
    on<HomeRefreshed>(_onLoad);
  }

  // ── ViewModel 스타일 공개 API ── View 는 Event 를 몰라도 된다.
  void load() => add(const HomeEvent.started());
  void refresh() => add(const HomeEvent.refreshed());

  final GetPosts _getPosts;

  Future<void> _onLoad(HomeEvent event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    try {
      final posts = await _getPosts();
      emit(HomeState.loaded(posts));
    } catch (e) {
      emit(HomeState.failure(t.home.loadFailure(error: e)));
    }
  }
}
