// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardPostEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardPostEvent()';
}


}

/// @nodoc
class $BoardPostEventCopyWith<$Res>  {
$BoardPostEventCopyWith(BoardPostEvent _, $Res Function(BoardPostEvent) __);
}


/// Adds pattern-matching-related methods to [BoardPostEvent].
extension BoardPostEventPatterns on BoardPostEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BoardPostStarted value)?  started,TResult Function( BoardPostRefreshed value)?  refreshed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BoardPostStarted() when started != null:
return started(_that);case BoardPostRefreshed() when refreshed != null:
return refreshed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BoardPostStarted value)  started,required TResult Function( BoardPostRefreshed value)  refreshed,}){
final _that = this;
switch (_that) {
case BoardPostStarted():
return started(_that);case BoardPostRefreshed():
return refreshed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BoardPostStarted value)?  started,TResult? Function( BoardPostRefreshed value)?  refreshed,}){
final _that = this;
switch (_that) {
case BoardPostStarted() when started != null:
return started(_that);case BoardPostRefreshed() when refreshed != null:
return refreshed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BoardPostStarted() when started != null:
return started();case BoardPostRefreshed() when refreshed != null:
return refreshed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,}) {final _that = this;
switch (_that) {
case BoardPostStarted():
return started();case BoardPostRefreshed():
return refreshed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,}) {final _that = this;
switch (_that) {
case BoardPostStarted() when started != null:
return started();case BoardPostRefreshed() when refreshed != null:
return refreshed();case _:
  return null;

}
}

}

/// @nodoc


class BoardPostStarted implements BoardPostEvent {
  const BoardPostStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardPostEvent.started()';
}


}




/// @nodoc


class BoardPostRefreshed implements BoardPostEvent {
  const BoardPostRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardPostEvent.refreshed()';
}


}




/// @nodoc
mixin _$BoardPostState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardPostState()';
}


}

/// @nodoc
class $BoardPostStateCopyWith<$Res>  {
$BoardPostStateCopyWith(BoardPostState _, $Res Function(BoardPostState) __);
}


/// Adds pattern-matching-related methods to [BoardPostState].
extension BoardPostStatePatterns on BoardPostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BoardPostInit value)?  init,TResult Function( BoardPostLoading value)?  loading,TResult Function( BoardPostLoaded value)?  loaded,TResult Function( BoardPostFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BoardPostInit() when init != null:
return init(_that);case BoardPostLoading() when loading != null:
return loading(_that);case BoardPostLoaded() when loaded != null:
return loaded(_that);case BoardPostFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BoardPostInit value)  init,required TResult Function( BoardPostLoading value)  loading,required TResult Function( BoardPostLoaded value)  loaded,required TResult Function( BoardPostFailure value)  failure,}){
final _that = this;
switch (_that) {
case BoardPostInit():
return init(_that);case BoardPostLoading():
return loading(_that);case BoardPostLoaded():
return loaded(_that);case BoardPostFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BoardPostInit value)?  init,TResult? Function( BoardPostLoading value)?  loading,TResult? Function( BoardPostLoaded value)?  loaded,TResult? Function( BoardPostFailure value)?  failure,}){
final _that = this;
switch (_that) {
case BoardPostInit() when init != null:
return init(_that);case BoardPostLoading() when loading != null:
return loading(_that);case BoardPostLoaded() when loaded != null:
return loaded(_that);case BoardPostFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  loading,TResult Function( List<Post> posts)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BoardPostInit() when init != null:
return init();case BoardPostLoading() when loading != null:
return loading();case BoardPostLoaded() when loaded != null:
return loaded(_that.posts);case BoardPostFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  loading,required TResult Function( List<Post> posts)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case BoardPostInit():
return init();case BoardPostLoading():
return loading();case BoardPostLoaded():
return loaded(_that.posts);case BoardPostFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  loading,TResult? Function( List<Post> posts)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case BoardPostInit() when init != null:
return init();case BoardPostLoading() when loading != null:
return loading();case BoardPostLoaded() when loaded != null:
return loaded(_that.posts);case BoardPostFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BoardPostInit implements BoardPostState {
  const BoardPostInit();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostInit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardPostState.init()';
}


}




/// @nodoc


class BoardPostLoading implements BoardPostState {
  const BoardPostLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardPostState.loading()';
}


}




/// @nodoc


class BoardPostLoaded implements BoardPostState {
  const BoardPostLoaded(final  List<Post> posts): _posts = posts;
  

 final  List<Post> _posts;
 List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of BoardPostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardPostLoadedCopyWith<BoardPostLoaded> get copyWith => _$BoardPostLoadedCopyWithImpl<BoardPostLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostLoaded&&const DeepCollectionEquality().equals(other._posts, _posts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts));

@override
String toString() {
  return 'BoardPostState.loaded(posts: $posts)';
}


}

/// @nodoc
abstract mixin class $BoardPostLoadedCopyWith<$Res> implements $BoardPostStateCopyWith<$Res> {
  factory $BoardPostLoadedCopyWith(BoardPostLoaded value, $Res Function(BoardPostLoaded) _then) = _$BoardPostLoadedCopyWithImpl;
@useResult
$Res call({
 List<Post> posts
});




}
/// @nodoc
class _$BoardPostLoadedCopyWithImpl<$Res>
    implements $BoardPostLoadedCopyWith<$Res> {
  _$BoardPostLoadedCopyWithImpl(this._self, this._then);

  final BoardPostLoaded _self;
  final $Res Function(BoardPostLoaded) _then;

/// Create a copy of BoardPostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? posts = null,}) {
  return _then(BoardPostLoaded(
null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}


}

/// @nodoc


class BoardPostFailure implements BoardPostState {
  const BoardPostFailure(this.message);
  

 final  String message;

/// Create a copy of BoardPostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardPostFailureCopyWith<BoardPostFailure> get copyWith => _$BoardPostFailureCopyWithImpl<BoardPostFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPostFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BoardPostState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $BoardPostFailureCopyWith<$Res> implements $BoardPostStateCopyWith<$Res> {
  factory $BoardPostFailureCopyWith(BoardPostFailure value, $Res Function(BoardPostFailure) _then) = _$BoardPostFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BoardPostFailureCopyWithImpl<$Res>
    implements $BoardPostFailureCopyWith<$Res> {
  _$BoardPostFailureCopyWithImpl(this._self, this._then);

  final BoardPostFailure _self;
  final $Res Function(BoardPostFailure) _then;

/// Create a copy of BoardPostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BoardPostFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
