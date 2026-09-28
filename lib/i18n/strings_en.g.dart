///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$en app = _Translations$app$en._(_root);
	@override late final _Translations$common$en common = _Translations$common$en._(_root);
	@override late final _Translations$nav$en nav = _Translations$nav$en._(_root);
	@override late final _Translations$auth$en auth = _Translations$auth$en._(_root);
	@override late final _Translations$home$en home = _Translations$home$en._(_root);
	@override late final _Translations$board$en board = _Translations$board$en._(_root);
	@override late final _Translations$boardPost$en boardPost = _Translations$boardPost$en._(_root);
	@override late final _Translations$post$en post = _Translations$post$en._(_root);
	@override late final _Translations$tag$en tag = _Translations$tag$en._(_root);
	@override late final _Translations$search$en search = _Translations$search$en._(_root);
	@override late final _Translations$profile$en profile = _Translations$profile$en._(_root);
	@override late final _Translations$webview$en webview = _Translations$webview$en._(_root);
}

// Path: app
class _Translations$app$en extends Translations$app$ko {
	_Translations$app$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My Board App';
}

// Path: common
class _Translations$common$en extends Translations$common$ko {
	_Translations$common$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancel';
	@override String get complete => 'Done';
	@override String get next => 'Next';
	@override String get add => 'Add';
	@override String get retry => 'Retry';
}

// Path: nav
class _Translations$nav$en extends Translations$nav$ko {
	_Translations$nav$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get dashboard => 'Dashboard';
	@override String get profile => 'Profile';
}

// Path: auth
class _Translations$auth$en extends Translations$auth$ko {
	_Translations$auth$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get login => 'Log in';
	@override String get loginLoading => 'Logging in...';
	@override String get signup => 'Sign up';
	@override String get signupLoading => 'Signing up...';
	@override String get email => 'Email';
	@override String get password => 'Password';
	@override String get nickname => 'Nickname';
	@override String get noAccount => 'No account? Sign up';
	@override String get emptyFields => 'Please fill in all fields';
	@override String get loginEmptyFields => 'Please enter your email and password';
	@override String loginFailure({required Object error}) => 'Login failed: ${error}';
	@override String signupFailure({required Object error}) => 'Sign-up failed: ${error}';
	@override String get userNotFound => 'User not found';
	@override String get emailExists => 'Email already exists';
}

// Path: home
class _Translations$home$en extends Translations$home$ko {
	_Translations$home$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get searchHint => 'Search notices';
	@override String get empty => 'No posts yet';
	@override String loadFailure({required Object error}) => 'Failed to load posts: ${error}';
	@override String get writeSheetTitle => 'Which board do you want to post to?';
	@override String get createBoardFirst => 'Please create a board first';
	@override String get shakeRefreshed => 'Refreshed by shake';
}

// Path: board
class _Translations$board$en extends Translations$board$ko {
	_Translations$board$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get create => 'Create board';
	@override String get name => 'Board name';
	@override String get nameRequired => 'Please enter a board name';
	@override String get empty => 'No boards yet (pull to refresh)';
	@override String loadFailure({required Object error}) => 'Failed to load boards: ${error}';
	@override String createFailure({required Object error}) => 'Failed to create board: ${error}';
}

// Path: boardPost
class _Translations$boardPost$en extends Translations$boardPost$ko {
	_Translations$boardPost$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'No posts yet. (pull to refresh)';
	@override String loadFailure({required Object error}) => 'Failed to load posts: ${error}';
}

// Path: post
class _Translations$post$en extends Translations$post$ko {
	_Translations$post$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get create => 'Write a post';
	@override String get titleLabel => 'Title';
	@override String get titleHint => 'Enter a title';
	@override String get bodyHint => 'Enter content';
	@override String get photoAdd => 'Add photo';
	@override String get capture => 'Camera';
	@override String get registered => 'Your post has been created';
	@override String get titleRequired => 'Please enter a title';
	@override String createFailure({required Object error}) => 'Failed to create post: ${error}';
	@override String photoLoadFailure({required Object error}) => 'Failed to load photos: ${error}';
}

// Path: tag
class _Translations$tag$en extends Translations$tag$ko {
	_Translations$tag$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get add => 'Add tag';
	@override String get inputHint => 'Enter a tag';
}

// Path: search
class _Translations$search$en extends Translations$search$ko {
	_Translations$search$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Try entering a search keyword';
	@override String get noResults => 'No search results';
	@override String failure({required Object error}) => 'Search failed: ${error}';
	@override String resultCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} result',
		other: '${n} results',
	);
}

// Path: profile
class _Translations$profile$en extends Translations$profile$ko {
	_Translations$profile$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profile';
	@override String get logout => 'Log out';
	@override String welcome({required Object nickname}) => 'Welcome, ${nickname}!';
	@override String get language => 'Language';
	@override String get korean => '한국어';
	@override String get english => 'English';
	@override String get help => 'Help (in-app WebView)';
}

// Path: webview
class _Translations$webview$en extends Translations$webview$ko {
	_Translations$webview$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Help';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'My Board App',
			'common.cancel' => 'Cancel',
			'common.complete' => 'Done',
			'common.next' => 'Next',
			'common.add' => 'Add',
			'common.retry' => 'Retry',
			'nav.home' => 'Home',
			'nav.dashboard' => 'Dashboard',
			'nav.profile' => 'Profile',
			'auth.login' => 'Log in',
			'auth.loginLoading' => 'Logging in...',
			'auth.signup' => 'Sign up',
			'auth.signupLoading' => 'Signing up...',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.nickname' => 'Nickname',
			'auth.noAccount' => 'No account? Sign up',
			'auth.emptyFields' => 'Please fill in all fields',
			'auth.loginEmptyFields' => 'Please enter your email and password',
			'auth.loginFailure' => ({required Object error}) => 'Login failed: ${error}',
			'auth.signupFailure' => ({required Object error}) => 'Sign-up failed: ${error}',
			'auth.userNotFound' => 'User not found',
			'auth.emailExists' => 'Email already exists',
			'home.searchHint' => 'Search notices',
			'home.empty' => 'No posts yet',
			'home.loadFailure' => ({required Object error}) => 'Failed to load posts: ${error}',
			'home.writeSheetTitle' => 'Which board do you want to post to?',
			'home.createBoardFirst' => 'Please create a board first',
			'home.shakeRefreshed' => 'Refreshed by shake',
			'board.create' => 'Create board',
			'board.name' => 'Board name',
			'board.nameRequired' => 'Please enter a board name',
			'board.empty' => 'No boards yet (pull to refresh)',
			'board.loadFailure' => ({required Object error}) => 'Failed to load boards: ${error}',
			'board.createFailure' => ({required Object error}) => 'Failed to create board: ${error}',
			'boardPost.empty' => 'No posts yet. (pull to refresh)',
			'boardPost.loadFailure' => ({required Object error}) => 'Failed to load posts: ${error}',
			'post.create' => 'Write a post',
			'post.titleLabel' => 'Title',
			'post.titleHint' => 'Enter a title',
			'post.bodyHint' => 'Enter content',
			'post.photoAdd' => 'Add photo',
			'post.capture' => 'Camera',
			'post.registered' => 'Your post has been created',
			'post.titleRequired' => 'Please enter a title',
			'post.createFailure' => ({required Object error}) => 'Failed to create post: ${error}',
			'post.photoLoadFailure' => ({required Object error}) => 'Failed to load photos: ${error}',
			'tag.add' => 'Add tag',
			'tag.inputHint' => 'Enter a tag',
			'search.hint' => 'Try entering a search keyword',
			'search.noResults' => 'No search results',
			'search.failure' => ({required Object error}) => 'Search failed: ${error}',
			'search.resultCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} result', other: '${n} results', ), 
			'profile.title' => 'Profile',
			'profile.logout' => 'Log out',
			'profile.welcome' => ({required Object nickname}) => 'Welcome, ${nickname}!',
			'profile.language' => 'Language',
			'profile.korean' => '한국어',
			'profile.english' => 'English',
			'profile.help' => 'Help (in-app WebView)',
			'webview.title' => 'Help',
			_ => null,
		};
	}
}
