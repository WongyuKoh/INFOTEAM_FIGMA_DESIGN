import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:figma_design/data/core/locale_storage.dart';
import 'package:figma_design/i18n/strings.g.dart';

// ------------------------------------------------------------
// Event — 언어 변경 요청
// ------------------------------------------------------------
sealed class LocaleEvent {
  const LocaleEvent();
}

/// 특정 언어로 변경.
class LocaleChanged extends LocaleEvent {
  const LocaleChanged(this.locale);
  final AppLocale locale;
}

/// 한국어 ↔ 영어 토글.
class LocaleToggled extends LocaleEvent {
  const LocaleToggled();
}

// ------------------------------------------------------------
// Bloc — State 는 현재 AppLocale 하나
// ------------------------------------------------------------
/// 앱 전역 언어 상태를 관리한다. main.dart 에서 라우터 위에 한 번 생성한다.
///
/// 상태가 바뀌면 [LocaleSettings.setLocale] 로 slang 전역 `t` 를 갱신하고,
/// 선택을 보안 저장소에 저장한다. (BlocBuilder 가 이 상태를 구독해 MaterialApp 을 다시 그린다)
class LocaleBloc extends Bloc<LocaleEvent, AppLocale> {
  LocaleBloc() : super(LocaleSettings.currentLocale) {
    on<LocaleChanged>((event, emit) => _apply(event.locale, emit));
    on<LocaleToggled>(
      (event, emit) =>
          _apply(state == AppLocale.ko ? AppLocale.en : AppLocale.ko, emit),
    );
  }

  // ── ViewModel 스타일 공개 API ──
  void change(AppLocale locale) => add(LocaleChanged(locale));
  void toggle() => add(const LocaleToggled());

  void _apply(AppLocale locale, Emitter<AppLocale> emit) {
    if (locale == state) return;
    LocaleSettings.setLocale(locale); // slang 전역 t 갱신
    emit(locale);
    LocaleStorage.save(locale); // 선택 저장(심화)
  }
}
