///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsKo = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ko,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ko>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$ko app = Translations$app$ko.internal(_root);
	late final Translations$common$ko common = Translations$common$ko.internal(_root);
	late final Translations$nav$ko nav = Translations$nav$ko.internal(_root);
	late final Translations$auth$ko auth = Translations$auth$ko.internal(_root);
	late final Translations$home$ko home = Translations$home$ko.internal(_root);
	late final Translations$board$ko board = Translations$board$ko.internal(_root);
	late final Translations$boardPost$ko boardPost = Translations$boardPost$ko.internal(_root);
	late final Translations$post$ko post = Translations$post$ko.internal(_root);
	late final Translations$tag$ko tag = Translations$tag$ko.internal(_root);
	late final Translations$search$ko search = Translations$search$ko.internal(_root);
	late final Translations$profile$ko profile = Translations$profile$ko.internal(_root);
	late final Translations$webview$ko webview = Translations$webview$ko.internal(_root);
}

// Path: app
class Translations$app$ko {
	Translations$app$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '나의 게시판 앱'
	String get title => '나의 게시판 앱';
}

// Path: common
class Translations$common$ko {
	Translations$common$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '취소'
	String get cancel => '취소';

	/// ko: '완료'
	String get complete => '완료';

	/// ko: '다음'
	String get next => '다음';

	/// ko: '추가'
	String get add => '추가';

	/// ko: '다시 시도'
	String get retry => '다시 시도';
}

// Path: nav
class Translations$nav$ko {
	Translations$nav$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '홈'
	String get home => '홈';

	/// ko: '대시보드'
	String get dashboard => '대시보드';

	/// ko: '프로필'
	String get profile => '프로필';
}

// Path: auth
class Translations$auth$ko {
	Translations$auth$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '로그인'
	String get login => '로그인';

	/// ko: '로그인 중...'
	String get loginLoading => '로그인 중...';

	/// ko: '회원가입'
	String get signup => '회원가입';

	/// ko: '등록 중...'
	String get signupLoading => '등록 중...';

	/// ko: '이메일'
	String get email => '이메일';

	/// ko: '비밀번호'
	String get password => '비밀번호';

	/// ko: '닉네임'
	String get nickname => '닉네임';

	/// ko: '계정이 없으신가요? 회원가입'
	String get noAccount => '계정이 없으신가요? 회원가입';

	/// ko: '모든 항목을 입력해주세요'
	String get emptyFields => '모든 항목을 입력해주세요';

	/// ko: '이메일과 비밀번호를 입력해주세요'
	String get loginEmptyFields => '이메일과 비밀번호를 입력해주세요';

	/// ko: '로그인 실패: $error'
	String loginFailure({required Object error}) => '로그인 실패: ${error}';

	/// ko: '회원가입 실패: $error'
	String signupFailure({required Object error}) => '회원가입 실패: ${error}';

	/// ko: '사용자를 찾을 수 없음'
	String get userNotFound => '사용자를 찾을 수 없음';

	/// ko: '이미 존재하는 이메일'
	String get emailExists => '이미 존재하는 이메일';
}

// Path: home
class Translations$home$ko {
	Translations$home$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '공지 검색'
	String get searchHint => '공지 검색';

	/// ko: '게시글이 없습니다'
	String get empty => '게시글이 없습니다';

	/// ko: '게시글을 불러오지 못했습니다: $error'
	String loadFailure({required Object error}) => '게시글을 불러오지 못했습니다: ${error}';

	/// ko: '어떤 게시판에 글을 쓸까요?'
	String get writeSheetTitle => '어떤 게시판에 글을 쓸까요?';

	/// ko: '먼저 게시판을 만들어주세요'
	String get createBoardFirst => '먼저 게시판을 만들어주세요';

	/// ko: '흔들어서 새로고침했어요'
	String get shakeRefreshed => '흔들어서 새로고침했어요';
}

// Path: board
class Translations$board$ko {
	Translations$board$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '게시판 만들기'
	String get create => '게시판 만들기';

	/// ko: '게시판 이름'
	String get name => '게시판 이름';

	/// ko: '게시판 이름을 입력해주세요'
	String get nameRequired => '게시판 이름을 입력해주세요';

	/// ko: '게시판이 없습니다 (당겨서 새로고침)'
	String get empty => '게시판이 없습니다 (당겨서 새로고침)';

	/// ko: '게시판을 불러오지 못했습니다: $error'
	String loadFailure({required Object error}) => '게시판을 불러오지 못했습니다: ${error}';

	/// ko: '게시판 생성 실패: $error'
	String createFailure({required Object error}) => '게시판 생성 실패: ${error}';
}

// Path: boardPost
class Translations$boardPost$ko {
	Translations$boardPost$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '게시글이 없습니다. (당겨서 새로고침)'
	String get empty => '게시글이 없습니다. (당겨서 새로고침)';

	/// ko: '게시글을 불러오지 못했습니다 : $error'
	String loadFailure({required Object error}) => '게시글을 불러오지 못했습니다 : ${error}';
}

// Path: post
class Translations$post$ko {
	Translations$post$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '게시글 작성'
	String get create => '게시글 작성';

	/// ko: '제목'
	String get titleLabel => '제목';

	/// ko: '제목 입력'
	String get titleHint => '제목 입력';

	/// ko: '내용을 입력해주세요'
	String get bodyHint => '내용을 입력해주세요';

	/// ko: '사진 추가'
	String get photoAdd => '사진 추가';

	/// ko: '촬영'
	String get capture => '촬영';

	/// ko: '게시글이 등록되었습니다'
	String get registered => '게시글이 등록되었습니다';

	/// ko: '제목을 입력해주세요'
	String get titleRequired => '제목을 입력해주세요';

	/// ko: '게시글 등록 실패: $error'
	String createFailure({required Object error}) => '게시글 등록 실패: ${error}';

	/// ko: '사진을 불러오지 못했습니다: $error'
	String photoLoadFailure({required Object error}) => '사진을 불러오지 못했습니다: ${error}';
}

// Path: tag
class Translations$tag$ko {
	Translations$tag$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '태그 추가'
	String get add => '태그 추가';

	/// ko: '태그 입력'
	String get inputHint => '태그 입력';
}

// Path: search
class Translations$search$ko {
	Translations$search$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '검색 키워드를 입력해보세요'
	String get hint => '검색 키워드를 입력해보세요';

	/// ko: '검색 결과가 없습니다'
	String get noResults => '검색 결과가 없습니다';

	/// ko: '검색에 실패했습니다: $error'
	String failure({required Object error}) => '검색에 실패했습니다: ${error}';

	/// ko: '(one) {검색 결과 $n개} (other) {검색 결과 $n개}'
	String resultCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(n,
		one: '검색 결과 ${n}개',
		other: '검색 결과 ${n}개',
	);
}

// Path: profile
class Translations$profile$ko {
	Translations$profile$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '프로필'
	String get title => '프로필';

	/// ko: '로그아웃'
	String get logout => '로그아웃';

	/// ko: '$nickname 님, 환영합니다!'
	String welcome({required Object nickname}) => '${nickname} 님, 환영합니다!';

	/// ko: '언어'
	String get language => '언어';

	/// ko: '한국어'
	String get korean => '한국어';

	/// ko: 'English'
	String get english => 'English';

	/// ko: '도움말 (인앱 웹뷰)'
	String get help => '도움말 (인앱 웹뷰)';
}

// Path: webview
class Translations$webview$ko {
	Translations$webview$ko.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ko: '도움말'
	String get title => '도움말';
}

/// The flat map containing all translations for locale <ko>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => '나의 게시판 앱',
			'common.cancel' => '취소',
			'common.complete' => '완료',
			'common.next' => '다음',
			'common.add' => '추가',
			'common.retry' => '다시 시도',
			'nav.home' => '홈',
			'nav.dashboard' => '대시보드',
			'nav.profile' => '프로필',
			'auth.login' => '로그인',
			'auth.loginLoading' => '로그인 중...',
			'auth.signup' => '회원가입',
			'auth.signupLoading' => '등록 중...',
			'auth.email' => '이메일',
			'auth.password' => '비밀번호',
			'auth.nickname' => '닉네임',
			'auth.noAccount' => '계정이 없으신가요? 회원가입',
			'auth.emptyFields' => '모든 항목을 입력해주세요',
			'auth.loginEmptyFields' => '이메일과 비밀번호를 입력해주세요',
			'auth.loginFailure' => ({required Object error}) => '로그인 실패: ${error}',
			'auth.signupFailure' => ({required Object error}) => '회원가입 실패: ${error}',
			'auth.userNotFound' => '사용자를 찾을 수 없음',
			'auth.emailExists' => '이미 존재하는 이메일',
			'home.searchHint' => '공지 검색',
			'home.empty' => '게시글이 없습니다',
			'home.loadFailure' => ({required Object error}) => '게시글을 불러오지 못했습니다: ${error}',
			'home.writeSheetTitle' => '어떤 게시판에 글을 쓸까요?',
			'home.createBoardFirst' => '먼저 게시판을 만들어주세요',
			'home.shakeRefreshed' => '흔들어서 새로고침했어요',
			'board.create' => '게시판 만들기',
			'board.name' => '게시판 이름',
			'board.nameRequired' => '게시판 이름을 입력해주세요',
			'board.empty' => '게시판이 없습니다 (당겨서 새로고침)',
			'board.loadFailure' => ({required Object error}) => '게시판을 불러오지 못했습니다: ${error}',
			'board.createFailure' => ({required Object error}) => '게시판 생성 실패: ${error}',
			'boardPost.empty' => '게시글이 없습니다. (당겨서 새로고침)',
			'boardPost.loadFailure' => ({required Object error}) => '게시글을 불러오지 못했습니다 : ${error}',
			'post.create' => '게시글 작성',
			'post.titleLabel' => '제목',
			'post.titleHint' => '제목 입력',
			'post.bodyHint' => '내용을 입력해주세요',
			'post.photoAdd' => '사진 추가',
			'post.capture' => '촬영',
			'post.registered' => '게시글이 등록되었습니다',
			'post.titleRequired' => '제목을 입력해주세요',
			'post.createFailure' => ({required Object error}) => '게시글 등록 실패: ${error}',
			'post.photoLoadFailure' => ({required Object error}) => '사진을 불러오지 못했습니다: ${error}',
			'tag.add' => '태그 추가',
			'tag.inputHint' => '태그 입력',
			'search.hint' => '검색 키워드를 입력해보세요',
			'search.noResults' => '검색 결과가 없습니다',
			'search.failure' => ({required Object error}) => '검색에 실패했습니다: ${error}',
			'search.resultCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(n, one: '검색 결과 ${n}개', other: '검색 결과 ${n}개', ), 
			'profile.title' => '프로필',
			'profile.logout' => '로그아웃',
			'profile.welcome' => ({required Object nickname}) => '${nickname} 님, 환영합니다!',
			'profile.language' => '언어',
			'profile.korean' => '한국어',
			'profile.english' => 'English',
			'profile.help' => '도움말 (인앱 웹뷰)',
			'webview.title' => '도움말',
			_ => null,
		};
	}
}
