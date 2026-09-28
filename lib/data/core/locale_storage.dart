import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:figma_design/i18n/strings.g.dart';

/// 사용자가 선택한 언어를 보안 저장소에 저장/복원한다. (심화: 언어 설정 유지)
class LocaleStorage {
  static const _key = 'app_locale';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// 저장된 언어를 읽는다. 없거나 실패하면 null.
  static Future<AppLocale?> load() async {
    try {
      final code = await _storage.read(key: _key);
      if (code == null) return null;
      return AppLocaleUtils.parse(code);
    } catch (_) {
      return null;
    }
  }

  static Future<void> save(AppLocale locale) async {
    try {
      await _storage.write(key: _key, value: locale.languageCode);
    } catch (_) {
      // 저장 실패는 조용히 무시 (앱 동작에는 영향 없음)
    }
  }
}
