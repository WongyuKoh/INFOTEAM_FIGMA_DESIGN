# 게시판 앱 (Flutter · Clean Architecture)

게시판·게시글·태그 기능을 갖춘 Flutter 앱입니다.
**Clean Architecture(Presentation / Domain / Data 3계층)** 로 구성하고,
상태 관리는 BLoC, 의존성 주입은 **get_it + injectable** 로 처리합니다.
JWT 기반 인증을 보안 저장소에 유지합니다.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
#   freezed / retrofit / auto_route / injectable 코드 생성
flutter run
```

---

## 아키텍처 (Clean Architecture)

의존성은 **항상 안쪽(Domain)을 향합니다.** Domain 은 Flutter/Dio/retrofit 을 모르는
순수 Dart 계층이고, Presentation 과 Data 가 Domain 에 의존합니다.

```
┌─────────────── Presentation ───────────────┐
│  Page(View)  ──►  Bloc(ViewModel)           │
│                       │ 호출                 │
└───────────────────────┼─────────────────────┘
                        ▼
┌─────────────────── Domain ──────────────────┐   ← 순수 Dart (의존성 없음)
│  UseCase  ──►  Repository(추상)  ◄──┐        │
│               Entity                │        │
└─────────────────────────────────────┼────────┘
                                      │ 구현
┌─────────────────── Data ────────────┼────────┐
│  RepositoryImpl  ──►  Service(retrofit) ──► Dio │
└─────────────────────────────────────────────┘
```

**핵심 규칙**
- **ViewModel(Bloc)** 은 Repository 가 아니라 **UseCase 에만** 의존합니다.
- **UseCase** 는 Domain 의 **Repository 인터페이스**에만 의존합니다.
- **Data 계층**이 그 인터페이스를 `RepositoryImpl` 로 구현합니다.
- 이 바인딩(인터페이스 → 구현)은 injectable 의 `@LazySingleton(as: ...)` 로 연결됩니다.

### 폴더 구조

```
lib/
├─ presentation/                 # ── Presentation 계층
│   ├─ auth/  auth_bloc.dart      #    앱 전역 인증 상태(ViewModel)
│   ├─ home/  board_list/  board_post/  search/
│   ├─ login/  signup/  profile/  splash/
│   └─ newboard/  create_post/  create_tag/
│                                 #    각 폴더 = View(*Page.dart) + ViewModel(*_bloc.dart)
├─ domain/                       # ── Domain 계층 (순수 Dart)
│   ├─ entity/                    #    Post, Board, AuthStatus
│   ├─ repository/                #    PostRepository … (추상 인터페이스 = 계약)
│   └─ usecase/                   #    GetPosts, Login, CreatePost … (행동 단위)
├─ data/                         # ── Data 계층
│   ├─ core/                      #    ApiClient(Dio+Interceptor), TokenStorage
│   ├─ service/                   #    retrofit Service (auth/post/board/tag)
│   └─ repository/                #    *RepositoryImpl (인터페이스 구현)
└─ di/                           # ── 의존성 주입
    ├─ injection.dart             #    getIt + configureDependencies()
    ├─ register_module.dart       #    @module: Dio/Service/ImagePicker 공급
    └─ injection.config.dart      #    injectable 자동 생성 (등록 코드)
```

### 데이터 흐름 예 (홈 화면 게시글 목록)

```
HomePage
  └ getIt<HomeBloc>()..load()
       └ HomeBloc(GetPosts)                 ← UseCase 에만 의존
            └ GetPosts()                     ← PostRepository(추상) 호출
                 └ PostRepositoryImpl        ← @LazySingleton(as: PostRepository)
                      └ PostService(Dio)     ← retrofit
```

---

## 의존성 주입 (get_it + injectable)

`main()` 에서 `configureDependencies()` 한 줄로 전체 그래프를 등록합니다.

| 계층 | 어노테이션 | 예 |
|---|---|---|
| Service / ImagePicker / Dio | `@module` (register_module) | `PostService`, `ImagePicker` |
| RepositoryImpl | `@LazySingleton(as: 인터페이스)` | `PostRepositoryImpl` → `PostRepository` |
| UseCase | `@injectable` | `GetPosts`, `Login` |
| Bloc(ViewModel) | `@injectable` / `@lazySingleton`(Auth) | `HomeBloc`, `AuthBloc` |

- 런타임 인자가 필요한 Bloc(`BoardPostBloc` 의 `boardUuid`)은 `@factoryParam` →
  `getIt<BoardPostBloc>(param1: boardUuid)`.
- 인자가 많은 `CreateTagBloc` 은 페이지에서 직접 생성하되 UseCase 는 `getIt()` 이 주입.

---

## 다국어 (slang + BLoC)

한국어 ↔ 영어를 지원합니다. 모든 UI 정적 텍스트는 slang 이 생성한 `t` 객체로 대체돼 있습니다.

### 구성

```
i18n/                         # 번역 원본 (프로젝트 루트)
├─ strings_ko.i18n.json        # 한국어 (base locale)
└─ strings_en.i18n.json        # 영어
build.yaml                    # slang 설정 (입력/출력 경로)
lib/i18n/strings.g.dart       # 생성물: t / AppLocale / LocaleSettings / TranslationProvider
lib/presentation/locale/locale_bloc.dart   # 언어 상태 관리 Bloc
lib/data/core/locale_storage.dart          # 선택 언어 저장(보안 저장소)
```

번역 코드 생성 (i18n 폴더가 lib 밖이라 standalone 명령을 쓴다):

```bash
dart run slang
```

### 사용

```dart
Text(t.home.empty)                       // 단순 키
Text(t.home.loadFailure(error: e))       // 변수 삽입
Text(t.profile.welcome(nickname: name))  // "OOO 님, 환영합니다!"
Text(t.search.resultCount(n: count))     // 복수형(pluralization)
```

### 언어 변경 (LocaleBloc)

- **State** = 현재 `AppLocale`, **Event** = `LocaleChanged` / `LocaleToggled`.
- `main.dart` 에서 `TranslationProvider` 로 감싸고 `BlocProvider(LocaleBloc)` 주입.
- `MyApp` 이 `BlocBuilder<LocaleBloc, AppLocale>` 로 상태를 구독 → `MaterialApp` 을 다시 그려
  전역 `t` 가 새 언어를 가리키게 한다.
- **프로필 화면**에 한국어/English 선택 UI 가 있어 사용자가 즉시 전환할 수 있다.
- 선택한 언어는 `LocaleStorage` 로 보안 저장소에 저장돼 **앱 재시작 후에도 유지**된다.

```
사용자가 언어 칩 탭
  └ context.read<LocaleBloc>().change(AppLocale.en)
       └ LocaleBloc: LocaleSettings.setLocale(en) + emit(en) + LocaleStorage.save(en)
            └ BlocBuilder 가 MaterialApp 을 rebuild → 모든 t.* 가 영어로 갱신
```

---

## 네이티브 기능 (카메라 · 인앱 웹뷰 · 모션 센서)

세 가지 네이티브 기능을 Clean Architecture 계층에 맞춰 구현했습니다.

| 기능 | 패키지 | 시나리오 | 네이티브 권한 |
|------|--------|----------|---------------|
| **카메라** | `image_picker` | 글쓰기 화면 "촬영" 버튼 → 촬영한 사진 첨부 | iOS `NSCameraUsageDescription` |
| **인앱 웹뷰** | `webview_flutter` | 프로필 "도움말" → 앱 내부에서 웹페이지 표시 | Android `INTERNET` |
| **모션 센서** | `sensors_plus` | 홈에서 기기를 흔들면 목록 새로고침 | iOS `NSMotionUsageDescription` |

### 계층 배치

```
카메라   CreatePostBloc.capturePhoto() → ImagePicker(source: camera)   (data 도구)
웹뷰     WebViewPage(@RoutePage, url 인자) — presentation 전용
모션     _ShakeToRefresh → WatchShake(UseCase) → MotionRepository(추상)
                                              → MotionRepositoryImpl(sensors_plus)
```

- 모션은 `domain/repository/motion_repository.dart`(인터페이스) + `domain/usecase/watch_shake.dart`
  + `data/repository/motion_repository_impl.dart`(가속도 크기 임계값 + 디바운스)로 3계층을 지킵니다.
- 권한 문구는 `ios/Runner/Info.plist`, `android/app/src/main/AndroidManifest.xml`에 선언돼 있습니다.

---

## 1. JWT (JSON Web Token)

서버는 로그인 성공 시 **access token** 과 **refresh token** 을 내려줍니다.
access token 은 `헤더.페이로드.서명` 세 부분이 `.` 으로 이어진 문자열이고,
가운데 페이로드에 사용자 정보와 만료 시각(`exp`)이 base64url 로 담겨 있습니다.

`TokenStorage` 가 이 페이로드를 직접 디코딩해 두 가지에 씁니다.

**① 만료 여부 판단** — `lib/data/core/token_storage.dart`

```dart
static bool get isAccessTokenValid {
  final token = accessToken;
  if (token == null || token.isEmpty) return false;
  final exp = decodeJwtPayload(token)?['exp'];
  if (exp is! int) return true;
  return DateTime.now().millisecondsSinceEpoch < exp * 1000;
}
```

앱 시작 시 이 값으로 "저장된 토큰이 아직 쓸 만한가"를 서버에 묻지 않고 판정합니다.

**② 사용자 정보 확보** — 이 서버에는 `/auth/me` 같은 엔드포인트가 없어서,
닉네임을 아래 순서로 찾습니다 (`lib/data/service/auth_api.dart`).

1. 로그인 응답 본문
2. access token 의 JWT 페이로드
3. `/posts` 응답에서 내 이메일과 일치하는 작성자

---

## 2. 상태 유지 (flutter_secure_storage)

토큰은 **두 겹**으로 보관합니다.

| 계층 | 용도 |
|---|---|
| 메모리 (`static` 필드) | Interceptor 가 **동기로** 읽어야 하므로 필요 |
| `flutter_secure_storage` | 앱을 껐다 켜도 유지 (iOS Keychain / Android Keystore) |

- **쓰기**: 로그인·회원가입·토큰 재발급 후 `TokenStorage.persist()` 로 디스크에 기록
- **읽기**: 앱 시작 시 `TokenStorage.load()` 로 디스크 → 메모리 복원
- **삭제**: 로그아웃·세션 만료 시 `TokenStorage.clear()` 로 양쪽 모두 제거

`SharedPreferences` 와 달리 OS 수준에서 암호화되므로 토큰 저장에 적합합니다.

### 앱 시작 흐름

```
앱 실행
  └ AuthBloc.started
      ├ TokenStorage.load()          보안 저장소 → 메모리
      ├ isAccessTokenValid 확인       JWT exp 검사
      │
      ├ 유효   → AuthState.authenticated  → 홈 화면
      └ 없음/만료 → AuthState.unauthenticated → 로그인 화면
                    (만료 토큰은 정리)
```

판정이 끝날 때까지는 `SplashPage` 가 스피너를 보여주고,
결과가 나오면 `replaceAll` 로 스택을 통째로 교체합니다.

---

## 3. Dio Interceptor

`lib/data/core/api_client.dart`

### onRequest — 토큰 자동 첨부

모든 요청 헤더에 access token 을 붙입니다. 각 API 함수는 토큰을 신경 쓰지 않습니다.

```dart
onRequest: (options, handler) {
  final token = TokenStorage.accessToken;
  if (token != null) {
    options.headers['Authorization'] = 'Bearer $token';
  }
  handler.next(options);
},
```

### onError — 401 이면 재발급 후 재시도

access token 이 만료되어 401 이 오면, refresh token 으로 새 토큰을 받아
**실패했던 요청을 그대로 다시 보냅니다.** 사용자는 재로그인 없이 이어서 씁니다.

```
요청 → 401
  ├ 재발급 조건 확인 (401 / 첫 시도 / refresh 요청 아님 / refreshToken 존재)
  ├ POST /auth/refresh          ← 인터셉터가 없는 별도 Dio 사용
  ├ 새 토큰 저장 + persist()
  └ 원래 요청 재시도 → handler.resolve(응답)

재발급 실패 → TokenStorage.clear() → 에러 전파 (로그아웃 상태)
```

무한 루프와 중복 요청을 막는 장치가 세 개 있습니다.

| 장치 | 막는 상황 |
|---|---|
| `_refreshDio` (별도 인스턴스) | 재발급 요청이 401 → 또 재발급 → 무한 재귀 |
| `extra['__retried']` 플래그 | 재시도한 요청이 또 401 → 무한 재시도 |
| `_refreshing` 공유 Future | 여러 요청이 동시에 401 → 재발급 요청 폭주 |

---

## 4. 인증 상태 관리 (AuthBloc)

`lib/presentation/auth/auth_bloc.dart` — 라우터보다 위(`main.dart`)에 한 번만 생성되어
어느 화면에서나 `context.read<AuthBloc>()` 로 접근할 수 있습니다.

```dart
sealed class AuthState {
  unknown()                              // 토큰 확인 중
  authenticated({nickname, email})       // 로그인됨
  unauthenticated()                      // 로그인 안 됨
}
```

`sealed class` 로 두어 **"로그인 안 했는데 닉네임이 있는"** 같은 불가능한 상태를
타입 수준에서 만들 수 없게 했습니다. 화면에서는 `when` / `switch` 로 분기하며,
상태를 하나 추가하면 처리하지 않은 화면이 컴파일 에러로 드러납니다.

| 이벤트 | 하는 일 |
|---|---|
| `started` | 저장소 복원 + JWT 만료 검사 → 초기 상태 결정 |
| `loggedIn` | 로그인 성공 후 상태 갱신 (LoginPage 가 호출) |
| `loggedOut` | 토큰 삭제 → `unauthenticated` |

---

## 상태 관리 (BLoC + Freezed)

화면 성격에 따라 State 모양을 둘로 나눕니다.

| 성격 | 모양 | 예 |
|---|---|---|
| 목록·조회 — 상태가 **배타적** | `sealed class` + `when()` | `HomeBloc`, `BoardListBloc` |
| 폼 — **진행 단계**만 변함 | 데이터 클래스 + `status` | `LoginBloc`, `SignUpBloc` |

State 는 모두 불변이며 `copyWith` 으로 새 객체를 만들어 `emit` 합니다.
같은 객체를 수정해서 `emit` 하면 `state == _state` 비교에 걸려 **UI 가 갱신되지 않습니다.**

---

## 테스트

```bash
flutter test
```

| 파일 | 내용 |
|---|---|
| `auth_bloc_test.dart` | 앱 재시작 후 로그인 유지 / 만료 토큰 처리 / 로그아웃 |
| `widget_test.dart` | 앱 부팅 → 스플래시 → 로그인 화면 |
| `create_post_page_test.dart`, `create_tag_page_test.dart` | 글 작성 플로우 (요청 본문 검증) |
| `why_copywith_test.dart` | 불변 State 가 필요한 이유 |
| `emit_timing_test.dart` | `emit` 과 화면 갱신 타이밍 |
| `list_padding_test.dart` | `ListView` 자동 삽입 패딩 회귀 방지 |
| `*_models_test.dart`, `token_storage_test.dart` | 파싱·저장 로직 |
