import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:figma_design/domain/repository/motion_repository.dart';

/// [MotionRepository] 의 실제 구현. sensors_plus 가속도계로 흔들기를 감지한다.
@LazySingleton(as: MotionRepository)
class MotionRepositoryImpl implements MotionRepository {
  /// 흔들기로 볼 가속도 크기(중력 9.8 포함). 값이 클수록 세게 흔들어야 반응.
  static const double _shakeThreshold = 20.0;

  /// 한 번 흔든 뒤 이 시간 안의 연속 흔들림은 무시한다.
  static const Duration _cooldown = Duration(milliseconds: 800);

  @override
  Stream<void> shakes() {
    DateTime? last;
    return accelerometerEventStream()
        // 3축 벡터의 크기(√(x²+y²+z²))가 임계값을 넘으면 흔든 것으로 본다.
        .where(
          (e) => sqrt(e.x * e.x + e.y * e.y + e.z * e.z) > _shakeThreshold,
        )
        // 연속 흔들림을 한 번으로 묶는 디바운스.
        .where((_) {
          final now = DateTime.now();
          if (last != null && now.difference(last!) < _cooldown) return false;
          last = now;
          return true;
        })
        .map((_) {});
  }
}
