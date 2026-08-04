// ============================================================
// Stream 기초 — bloc.stream.firstWhere(...) 를 이해하기 위한 예제
//
// 실행:  dart run lib/study/stream_basics.dart
// (Flutter 가 아니라 순수 Dart 라서 dart run 으로 바로 돌아갑니다)
// ============================================================

import 'dart:async';

Future<void> main() async {
  await _futureVsStream();
  await _listenExample();
  await _firstWhereExample();
  await _blocLikeExample();
}

// ------------------------------------------------------------
// 1) Future 는 값 1개, Stream 은 값 여러 개
// ------------------------------------------------------------
Future<void> _futureVsStream() async {
  print('\n===== ① Future = 값 하나 =====');

  // Future = "나중에 도착할 값 1개"  → 택배 1개
  Future<int> onePackage() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return 42;
  }

  final value = await onePackage(); // 도착할 때까지 기다렸다가 받음
  print('받은 값: $value  (한 번 받으면 끝)');

  print('\n===== ② Stream = 값 여러 개 =====');

  // Stream = "시간에 걸쳐 여러 번 도착하는 값들" → 컨베이어 벨트
  Stream<int> manyPackages() async* {
    for (var i = 1; i <= 3; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      yield i * 10; // yield = 하나 흘려보내기 (return 과 달리 함수가 안 끝남)
    }
  }

  // await for = 흘러오는 값을 하나씩 받아 처리
  await for (final v in manyPackages()) {
    print('흘러온 값: $v');
  }
  print('(스트림이 끝남)');
}

// ------------------------------------------------------------
// 2) listen = 구독. 값이 올 때마다 콜백 실행
// ------------------------------------------------------------
Future<void> _listenExample() async {
  print('\n===== ③ listen = 구독하기 =====');

  // StreamController = 내가 직접 값을 밀어넣을 수 있는 스트림
  // (Bloc 내부가 바로 이걸 쓴다)
  final controller = StreamController<String>.broadcast();

  // 구독 시작 — 이 시점 "이후"에 들어온 값만 받는다
  final sub = controller.stream.listen((value) {
    print('  구독자가 받음: $value');
  });

  controller.add('loading'); // emit 과 같은 역할
  controller.add('loaded');

  await Future<void>.delayed(Duration.zero); // 배달될 틈을 준다
  await sub.cancel(); // 구독 해지
  await controller.close();
}

// ------------------------------------------------------------
// 3) firstWhere = 조건에 맞는 첫 값이 올 때까지 기다리기
// ------------------------------------------------------------
Future<void> _firstWhereExample() async {
  print('\n===== ④ firstWhere = 조건 맞는 첫 값까지 대기 =====');

  final controller = StreamController<String>.broadcast();

  // 0.1초 뒤부터 값을 순서대로 흘려보낸다
  Future<void>(() async {
    for (final v in ['loading', 'loading', 'loaded']) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      print('  스트림에 흘림: $v');
      controller.add(v);
    }
  });

  print('  firstWhere 로 대기 시작...');
  // "loading 이 아닌" 첫 값이 올 때까지 여기서 멈춘다
  final result = await controller.stream.firstWhere((s) => s != 'loading');
  print('  ✅ 조건 만족! 받은 값: $result');
  //     ▲ 앞의 'loading' 두 개는 조건에 안 맞아서 그냥 지나갔다

  await controller.close();
}

// ------------------------------------------------------------
// 4) Bloc 이 실제로 하는 일과 같은 구조
// ------------------------------------------------------------

/// BoardListState 를 흉내낸 것
sealed class FakeState {
  const FakeState();
}

class FakeLoading extends FakeState {
  const FakeLoading();
  @override
  String toString() => 'Loading';
}

class FakeLoaded extends FakeState {
  const FakeLoaded(this.boards);
  final List<String> boards;
  @override
  String toString() => 'Loaded($boards)';
}

/// Bloc 을 아주 단순하게 흉내낸 것
class FakeBloc {
  final _controller = StreamController<FakeState>.broadcast();

  FakeState state = const FakeLoading();

  /// bloc.stream 과 같은 것
  Stream<FakeState> get stream => _controller.stream;

  /// emit 과 같은 것
  void _emit(FakeState next) {
    state = next; // ① 현재 상태 교체
    _controller.add(next); // ② 스트림으로 내보냄
  }

  /// 이벤트 하나를 처리하는 핸들러
  Future<void> refresh() async {
    _emit(const FakeLoading());
    await Future<void>.delayed(const Duration(milliseconds: 300)); // API 흉내
    _emit(const FakeLoaded(['자유게시판', '공지사항']));
  }

  Future<void> close() => _controller.close();
}

Future<void> _blocLikeExample() async {
  print('\n===== ⑤ 실제 코드와 같은 구조 =====');

  final bloc = FakeBloc();

  bloc.stream.listen((s) => print('  [BlocBuilder] 리빌드: $s'));

  print('  당겨서 새로고침 시작');
  bloc.refresh(); // ← add() 처럼 즉시 반환 (await 안 붙임)

  // 🎯 이 줄이 바로 우리가 쓴 코드
  await bloc.stream.firstWhere((s) => s is! FakeLoading);

  print('  ✅ 로딩 끝 → RefreshIndicator 스피너 사라짐');
  print('  최종 상태: ${bloc.state}');

  await bloc.close();
}
