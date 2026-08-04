# 게시판 앱 (Flutter)

게시판·게시글·태그 기능을 갖춘 Flutter 앱입니다.
BLoC 패턴으로 상태를 관리하고, JWT 기반 인증을 보안 저장소에 유지합니다.

```bash
flutter pub get
dart run build_runner build     # freezed / retrofit / auto_route 코드 생성
flutter run
```

---

## 아키텍처

```
[Page]        화면 — 그리기만 담당
   ↕  add(Event) / BlocBuilder
[Bloc]        상태 + 로직
   ↓
[Repository]  데이터 접근 (여러 화면이 공유)
   ↓
[Service]     Retrofit 선언
   ↓
[Dio]         HTTP + Interceptor
```

기능 단위로 폴더를 묶고, 각 폴더 안에 그 화면의 Bloc 을 함께 둡니다.

```
lib/
├─ bloc/auth_bloc.dart          # 앱 전역 인증 상태
├─ repository/                  # 데이터 계층
├─ api/
│   ├─ core/                    # ApiClient(Dio+Interceptor), TokenStorage
│   ├─ auth/  post/  board/  tag/
└─ Page/
    ├─ splash/                  # 시작 시 인증 상태 판정
    ├─ login/  signup/  profile/
    ├─ home/  board_list/  board_post/  search/
    └─ newboard/  create_post/  create_tag/
```

---

## 1. JWT (JSON Web Token)

서버는 로그인 성공 시 **access token** 과 **refresh token** 을 내려줍니다.
access token 은 `헤더.페이로드.서명` 세 부분이 `.` 으로 이어진 문자열이고,
가운데 페이로드에 사용자 정보와 만료 시각(`exp`)이 base64url 로 담겨 있습니다.

`TokenStorage` 가 이 페이로드를 직접 디코딩해 두 가지에 씁니다.

**① 만료 여부 판단** — `lib/api/core/token_storage.dart`

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
닉네임을 아래 순서로 찾습니다 (`lib/api/auth/auth_api.dart`).

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

`lib/api/core/api_client.dart`

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

`lib/bloc/auth_bloc.dart` — 라우터보다 위(`main.dart`)에 한 번만 생성되어
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
