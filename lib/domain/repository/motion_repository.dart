/// 모션(가속도계) 접근 "계약". Domain 은 어떤 센서 플러그인을 쓰는지 모른다.
abstract interface class MotionRepository {
  /// 기기를 흔들 때마다 이벤트를 방출하는 스트림.
  Stream<void> shakes();
}
