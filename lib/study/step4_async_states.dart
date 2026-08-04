// ============================================================
// STEP 4. 비동기 + 여러 상태 — 실무에서 실제로 쓰는 패턴
//         (lib/Page/board_list 등 실제 화면과 같은 구조)
// ============================================================
// 여기서 State는 "필드 묶음"이 아니라 "서로 배타적인 상태의 종류"입니다.
//   초기 / 로딩중 / 성공(데이터 있음) / 실패(메시지 있음)
// → 이럴 때 sealed class + when() 을 씁니다.
//
// ⭐ 이 방식의 핵심 장점:
//   "로딩중이면서 동시에 에러"같은 불가능한 상태를 애초에 만들 수 없음.
//   bool isLoading + String? error + List? data 로 관리하면
//   2×2×2 = 8가지 조합 중 5가지가 말이 안 되는 상태입니다.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'step4_async_states.freezed.dart';

// ------------------------------------------------------------
// 0) 화면에 뿌릴 데이터 모델 — Freezed의 또 다른 용도
// ------------------------------------------------------------
@freezed
abstract class Article with _$Article {
  const factory Article({required int id, required String title}) = _Article;
}

// ------------------------------------------------------------
// 1) Event
// ------------------------------------------------------------
@freezed
sealed class ArticleEvent with _$ArticleEvent {
  const factory ArticleEvent.load() = ArticleLoadRequested;
  const factory ArticleEvent.deleted(int id) = ArticleDeleted;
}

// ------------------------------------------------------------
// 2) State — 4가지 "종류"
// ------------------------------------------------------------
@freezed
sealed class ArticleState with _$ArticleState {
  const factory ArticleState.initial() = ArticleInitial;
  const factory ArticleState.loading() = ArticleLoading;
  const factory ArticleState.success(List<Article> articles) = ArticleSuccess;
  const factory ArticleState.failure(String message) = ArticleFailure;
  //                                  ▲ 성공일 때만 데이터, 실패일 때만 메시지가 존재
}

// ------------------------------------------------------------
// 3) Bloc — 비동기 처리
// ------------------------------------------------------------
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  // 실패를 재현해보기 위한 스위치 (UI 버튼으로 토글)
  bool shouldFail = false;

  ArticleBloc() : super(const ArticleState.initial()) {
    on<ArticleLoadRequested>(_onLoad);
    on<ArticleDeleted>(_onDeleted);
  }

  // async 핸들러: emit을 여러 번 호출할 수 있습니다 (로딩 → 결과)
  Future<void> _onLoad(
    ArticleLoadRequested event,
    Emitter<ArticleState> emit,
  ) async {
    emit(const ArticleState.loading()); // ① 즉시 로딩 상태

    try {
      // ② 실제로는 여기서 repository/API 호출
      //    예) final list = await postApi.getPosts();
      await Future<void>.delayed(const Duration(seconds: 1));

      if (shouldFail) {
        throw Exception('서버가 응답하지 않습니다');
      }

      final articles = List.generate(
        8,
        (i) => Article(id: i + 1, title: '게시글 ${i + 1}'),
      );

      emit(ArticleState.success(articles)); // ③ 성공
    } catch (e) {
      emit(ArticleState.failure('$e')); // ④ 실패
    }
  }

  void _onDeleted(ArticleDeleted event, Emitter<ArticleState> emit) {
    // 현재 상태가 success 일 때만 의미가 있음 → 패턴 매칭으로 안전하게 꺼냄
    final current = state;
    if (current is! ArticleSuccess) return;

    // ⚠️ 리스트를 직접 수정(current.articles.remove(...))하면 안 됩니다.
    //    같은 객체라 == 비교에 걸려 emit이 무시될 수 있습니다.
    //    반드시 "새 리스트"를 만들어 emit 하세요.
    final next = current.articles.where((a) => a.id != event.id).toList();
    emit(ArticleState.success(next));
  }
}

// ------------------------------------------------------------
// 4) UI
// ------------------------------------------------------------
class Step4Page extends StatelessWidget {
  const Step4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // .. 캐스케이드 = "만들자마자 첫 로드 이벤트 발사"
      create: (_) => ArticleBloc()..add(const ArticleEvent.load()),
      child: const _Step4View(),
    );
  }
}

// BlocProvider의 create에서 만든 Bloc은 "그 자식"부터 접근 가능하므로,
// context.read를 쓰려면 이렇게 자식 위젯으로 한 겹 분리하는 게 안전합니다.
class _Step4View extends StatelessWidget {
  const _Step4View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STEP 4 · 비동기 + 4가지 상태'),
        actions: [
          // 실패 상황을 재현하는 토글
          IconButton(
            tooltip: '실패 모드로 다시 불러오기',
            icon: const Icon(Icons.bolt),
            onPressed: () {
              final bloc = context.read<ArticleBloc>();
              bloc.shouldFail = !bloc.shouldFail;
              bloc.add(const ArticleEvent.load());
            },
          ),
        ],
      ),
      // BlocListener = "그리기"가 아니라 "한 번만 실행할 부수효과"용
      //   (SnackBar, 화면 이동, 다이얼로그 등)
      // BlocBuilder는 리빌드 때마다 여러 번 불릴 수 있어서 이런 데 쓰면 안 됩니다.
      body: BlocListener<ArticleBloc, ArticleState>(
        listenWhen: (prev, curr) => curr is ArticleFailure,
        listener: (context, state) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('불러오기에 실패했어요')));
        },
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            // ⭐ when() — 4가지를 하나도 빠짐없이 처리해야 컴파일됨
            //    나중에 상태를 하나 추가하면 여기서 즉시 컴파일 에러 → 누락 방지
            return state.when(
              initial: () => const Center(child: Text('시작 전')),

              loading: () => const Center(child: CircularProgressIndicator()),

              success: (articles) => RefreshIndicator(
                onRefresh: () async {
                  final bloc = context.read<ArticleBloc>();
                  bloc.add(const ArticleEvent.load());
                  // add()는 즉시 반환하므로, 로딩이 끝날 때까지 기다려줘야
                  // 당김 스피너가 제때 사라집니다.
                  await bloc.stream.firstWhere((s) => s is! ArticleLoading);
                },
                child: articles.isEmpty
                    ? ListView(
                        // 비어 있어도 당길 수 있게 스크롤 가능 상태 유지
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 200),
                          Center(child: Text('전부 삭제했습니다. 당겨서 새로고침')),
                        ],
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return ListTile(
                            leading: CircleAvatar(child: Text('${article.id}')),
                            title: Text(article.title),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => context.read<ArticleBloc>().add(
                                ArticleEvent.deleted(article.id),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              failure: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(message, textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        final bloc = context.read<ArticleBloc>();
                        bloc.shouldFail = false; // 다시 성공하도록
                        bloc.add(const ArticleEvent.load());
                      },
                      child: const Text('다시 시도'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
