// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step4_async_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Article {

 int get id; String get title;
/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleCopyWith<Article> get copyWith => _$ArticleCopyWithImpl<Article>(this as Article, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Article&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'Article(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $ArticleCopyWith<$Res>  {
  factory $ArticleCopyWith(Article value, $Res Function(Article) _then) = _$ArticleCopyWithImpl;
@useResult
$Res call({
 int id, String title
});




}
/// @nodoc
class _$ArticleCopyWithImpl<$Res>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._self, this._then);

  final Article _self;
  final $Res Function(Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Article].
extension ArticlePatterns on Article {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Article value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Article value)  $default,){
final _that = this;
switch (_that) {
case _Article():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Article value)?  $default,){
final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title)  $default,) {final _that = this;
switch (_that) {
case _Article():
return $default(_that.id,_that.title);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title)?  $default,) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc


class _Article implements Article {
  const _Article({required this.id, required this.title});
  

@override final  int id;
@override final  String title;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleCopyWith<_Article> get copyWith => __$ArticleCopyWithImpl<_Article>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Article&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'Article(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) _then) = __$ArticleCopyWithImpl;
@override @useResult
$Res call({
 int id, String title
});




}
/// @nodoc
class __$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(this._self, this._then);

  final _Article _self;
  final $Res Function(_Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ArticleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArticleEvent()';
}


}

/// @nodoc
class $ArticleEventCopyWith<$Res>  {
$ArticleEventCopyWith(ArticleEvent _, $Res Function(ArticleEvent) __);
}


/// Adds pattern-matching-related methods to [ArticleEvent].
extension ArticleEventPatterns on ArticleEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ArticleLoadRequested value)?  load,TResult Function( ArticleDeleted value)?  deleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ArticleLoadRequested() when load != null:
return load(_that);case ArticleDeleted() when deleted != null:
return deleted(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ArticleLoadRequested value)  load,required TResult Function( ArticleDeleted value)  deleted,}){
final _that = this;
switch (_that) {
case ArticleLoadRequested():
return load(_that);case ArticleDeleted():
return deleted(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ArticleLoadRequested value)?  load,TResult? Function( ArticleDeleted value)?  deleted,}){
final _that = this;
switch (_that) {
case ArticleLoadRequested() when load != null:
return load(_that);case ArticleDeleted() when deleted != null:
return deleted(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( int id)?  deleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ArticleLoadRequested() when load != null:
return load();case ArticleDeleted() when deleted != null:
return deleted(_that.id);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( int id)  deleted,}) {final _that = this;
switch (_that) {
case ArticleLoadRequested():
return load();case ArticleDeleted():
return deleted(_that.id);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( int id)?  deleted,}) {final _that = this;
switch (_that) {
case ArticleLoadRequested() when load != null:
return load();case ArticleDeleted() when deleted != null:
return deleted(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class ArticleLoadRequested implements ArticleEvent {
  const ArticleLoadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleLoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArticleEvent.load()';
}


}




/// @nodoc


class ArticleDeleted implements ArticleEvent {
  const ArticleDeleted(this.id);
  

 final  int id;

/// Create a copy of ArticleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleDeletedCopyWith<ArticleDeleted> get copyWith => _$ArticleDeletedCopyWithImpl<ArticleDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleDeleted&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ArticleEvent.deleted(id: $id)';
}


}

/// @nodoc
abstract mixin class $ArticleDeletedCopyWith<$Res> implements $ArticleEventCopyWith<$Res> {
  factory $ArticleDeletedCopyWith(ArticleDeleted value, $Res Function(ArticleDeleted) _then) = _$ArticleDeletedCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$ArticleDeletedCopyWithImpl<$Res>
    implements $ArticleDeletedCopyWith<$Res> {
  _$ArticleDeletedCopyWithImpl(this._self, this._then);

  final ArticleDeleted _self;
  final $Res Function(ArticleDeleted) _then;

/// Create a copy of ArticleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ArticleDeleted(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ArticleState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArticleState()';
}


}

/// @nodoc
class $ArticleStateCopyWith<$Res>  {
$ArticleStateCopyWith(ArticleState _, $Res Function(ArticleState) __);
}


/// Adds pattern-matching-related methods to [ArticleState].
extension ArticleStatePatterns on ArticleState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ArticleInitial value)?  initial,TResult Function( ArticleLoading value)?  loading,TResult Function( ArticleSuccess value)?  success,TResult Function( ArticleFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ArticleInitial() when initial != null:
return initial(_that);case ArticleLoading() when loading != null:
return loading(_that);case ArticleSuccess() when success != null:
return success(_that);case ArticleFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ArticleInitial value)  initial,required TResult Function( ArticleLoading value)  loading,required TResult Function( ArticleSuccess value)  success,required TResult Function( ArticleFailure value)  failure,}){
final _that = this;
switch (_that) {
case ArticleInitial():
return initial(_that);case ArticleLoading():
return loading(_that);case ArticleSuccess():
return success(_that);case ArticleFailure():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ArticleInitial value)?  initial,TResult? Function( ArticleLoading value)?  loading,TResult? Function( ArticleSuccess value)?  success,TResult? Function( ArticleFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ArticleInitial() when initial != null:
return initial(_that);case ArticleLoading() when loading != null:
return loading(_that);case ArticleSuccess() when success != null:
return success(_that);case ArticleFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Article> articles)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ArticleInitial() when initial != null:
return initial();case ArticleLoading() when loading != null:
return loading();case ArticleSuccess() when success != null:
return success(_that.articles);case ArticleFailure() when failure != null:
return failure(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Article> articles)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ArticleInitial():
return initial();case ArticleLoading():
return loading();case ArticleSuccess():
return success(_that.articles);case ArticleFailure():
return failure(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Article> articles)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ArticleInitial() when initial != null:
return initial();case ArticleLoading() when loading != null:
return loading();case ArticleSuccess() when success != null:
return success(_that.articles);case ArticleFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ArticleInitial implements ArticleState {
  const ArticleInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArticleState.initial()';
}


}




/// @nodoc


class ArticleLoading implements ArticleState {
  const ArticleLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ArticleState.loading()';
}


}




/// @nodoc


class ArticleSuccess implements ArticleState {
  const ArticleSuccess(final  List<Article> articles): _articles = articles;
  

 final  List<Article> _articles;
 List<Article> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}


/// Create a copy of ArticleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleSuccessCopyWith<ArticleSuccess> get copyWith => _$ArticleSuccessCopyWithImpl<ArticleSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleSuccess&&const DeepCollectionEquality().equals(other._articles, _articles));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'ArticleState.success(articles: $articles)';
}


}

/// @nodoc
abstract mixin class $ArticleSuccessCopyWith<$Res> implements $ArticleStateCopyWith<$Res> {
  factory $ArticleSuccessCopyWith(ArticleSuccess value, $Res Function(ArticleSuccess) _then) = _$ArticleSuccessCopyWithImpl;
@useResult
$Res call({
 List<Article> articles
});




}
/// @nodoc
class _$ArticleSuccessCopyWithImpl<$Res>
    implements $ArticleSuccessCopyWith<$Res> {
  _$ArticleSuccessCopyWithImpl(this._self, this._then);

  final ArticleSuccess _self;
  final $Res Function(ArticleSuccess) _then;

/// Create a copy of ArticleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? articles = null,}) {
  return _then(ArticleSuccess(
null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<Article>,
  ));
}


}

/// @nodoc


class ArticleFailure implements ArticleState {
  const ArticleFailure(this.message);
  

 final  String message;

/// Create a copy of ArticleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleFailureCopyWith<ArticleFailure> get copyWith => _$ArticleFailureCopyWithImpl<ArticleFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ArticleState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ArticleFailureCopyWith<$Res> implements $ArticleStateCopyWith<$Res> {
  factory $ArticleFailureCopyWith(ArticleFailure value, $Res Function(ArticleFailure) _then) = _$ArticleFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ArticleFailureCopyWithImpl<$Res>
    implements $ArticleFailureCopyWith<$Res> {
  _$ArticleFailureCopyWithImpl(this._self, this._then);

  final ArticleFailure _self;
  final $Res Function(ArticleFailure) _then;

/// Create a copy of ArticleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ArticleFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
