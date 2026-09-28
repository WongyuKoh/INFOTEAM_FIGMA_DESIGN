import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/repository/motion_repository.dart';

/// 흔들기 제스처를 구독한다. 화면은 이 스트림만 알면 된다.
@injectable
class WatchShake {
  const WatchShake(this._repository);

  final MotionRepository _repository;

  Stream<void> call() => _repository.shakes();
}
