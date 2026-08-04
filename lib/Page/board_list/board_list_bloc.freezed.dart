// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardListEvent()';
}


}

/// @nodoc
class $BoardListEventCopyWith<$Res>  {
$BoardListEventCopyWith(BoardListEvent _, $Res Function(BoardListEvent) __);
}


/// Adds pattern-matching-related methods to [BoardListEvent].
extension BoardListEventPatterns on BoardListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BoardListStarted value)?  started,TResult Function( BoardListRefreshed value)?  refreshed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BoardListStarted() when started != null:
return started(_that);case BoardListRefreshed() when refreshed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BoardListStarted value)  started,required TResult Function( BoardListRefreshed value)  refreshed,}){
final _that = this;
switch (_that) {
case BoardListStarted():
return started(_that);case BoardListRefreshed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BoardListStarted value)?  started,TResult? Function( BoardListRefreshed value)?  refreshed,}){
final _that = this;
switch (_that) {
case BoardListStarted() when started != null:
return started(_that);case BoardListRefreshed() when refreshed != null:
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
case BoardListStarted() when started != null:
return started();case BoardListRefreshed() when refreshed != null:
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
case BoardListStarted():
return started();case BoardListRefreshed():
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
case BoardListStarted() when started != null:
return started();case BoardListRefreshed() when refreshed != null:
return refreshed();case _:
  return null;

}
}

}

/// @nodoc


class BoardListStarted implements BoardListEvent {
  const BoardListStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardListStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardListEvent.started()';
}


}




/// @nodoc


class BoardListRefreshed implements BoardListEvent {
  const BoardListRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardListRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardListEvent.refreshed()';
}


}




/// @nodoc
mixin _$BoardListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardListState()';
}


}

/// @nodoc
class $BoardListStateCopyWith<$Res>  {
$BoardListStateCopyWith(BoardListState _, $Res Function(BoardListState) __);
}


/// Adds pattern-matching-related methods to [BoardListState].
extension BoardListStatePatterns on BoardListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BoardListInit value)?  init,TResult Function( BoardListLoading value)?  loading,TResult Function( BoardListLoaded value)?  loaded,TResult Function( BoardListFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BoardListInit() when init != null:
return init(_that);case BoardListLoading() when loading != null:
return loading(_that);case BoardListLoaded() when loaded != null:
return loaded(_that);case BoardListFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BoardListInit value)  init,required TResult Function( BoardListLoading value)  loading,required TResult Function( BoardListLoaded value)  loaded,required TResult Function( BoardListFailure value)  failure,}){
final _that = this;
switch (_that) {
case BoardListInit():
return init(_that);case BoardListLoading():
return loading(_that);case BoardListLoaded():
return loaded(_that);case BoardListFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BoardListInit value)?  init,TResult? Function( BoardListLoading value)?  loading,TResult? Function( BoardListLoaded value)?  loaded,TResult? Function( BoardListFailure value)?  failure,}){
final _that = this;
switch (_that) {
case BoardListInit() when init != null:
return init(_that);case BoardListLoading() when loading != null:
return loading(_that);case BoardListLoaded() when loaded != null:
return loaded(_that);case BoardListFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  loading,TResult Function( List<Board> boards)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BoardListInit() when init != null:
return init();case BoardListLoading() when loading != null:
return loading();case BoardListLoaded() when loaded != null:
return loaded(_that.boards);case BoardListFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  loading,required TResult Function( List<Board> boards)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case BoardListInit():
return init();case BoardListLoading():
return loading();case BoardListLoaded():
return loaded(_that.boards);case BoardListFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  loading,TResult? Function( List<Board> boards)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case BoardListInit() when init != null:
return init();case BoardListLoading() when loading != null:
return loading();case BoardListLoaded() when loaded != null:
return loaded(_that.boards);case BoardListFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BoardListInit implements BoardListState {
  const BoardListInit();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardListInit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardListState.init()';
}


}




/// @nodoc


class BoardListLoading implements BoardListState {
  const BoardListLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardListLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BoardListState.loading()';
}


}




/// @nodoc


class BoardListLoaded implements BoardListState {
  const BoardListLoaded(final  List<Board> boards): _boards = boards;
  

 final  List<Board> _boards;
 List<Board> get boards {
  if (_boards is EqualUnmodifiableListView) return _boards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_boards);
}


/// Create a copy of BoardListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardListLoadedCopyWith<BoardListLoaded> get copyWith => _$BoardListLoadedCopyWithImpl<BoardListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardListLoaded&&const DeepCollectionEquality().equals(other._boards, _boards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_boards));

@override
String toString() {
  return 'BoardListState.loaded(boards: $boards)';
}


}

/// @nodoc
abstract mixin class $BoardListLoadedCopyWith<$Res> implements $BoardListStateCopyWith<$Res> {
  factory $BoardListLoadedCopyWith(BoardListLoaded value, $Res Function(BoardListLoaded) _then) = _$BoardListLoadedCopyWithImpl;
@useResult
$Res call({
 List<Board> boards
});




}
/// @nodoc
class _$BoardListLoadedCopyWithImpl<$Res>
    implements $BoardListLoadedCopyWith<$Res> {
  _$BoardListLoadedCopyWithImpl(this._self, this._then);

  final BoardListLoaded _self;
  final $Res Function(BoardListLoaded) _then;

/// Create a copy of BoardListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? boards = null,}) {
  return _then(BoardListLoaded(
null == boards ? _self._boards : boards // ignore: cast_nullable_to_non_nullable
as List<Board>,
  ));
}


}

/// @nodoc


class BoardListFailure implements BoardListState {
  const BoardListFailure(this.message);
  

 final  String message;

/// Create a copy of BoardListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardListFailureCopyWith<BoardListFailure> get copyWith => _$BoardListFailureCopyWithImpl<BoardListFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardListFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BoardListState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $BoardListFailureCopyWith<$Res> implements $BoardListStateCopyWith<$Res> {
  factory $BoardListFailureCopyWith(BoardListFailure value, $Res Function(BoardListFailure) _then) = _$BoardListFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BoardListFailureCopyWithImpl<$Res>
    implements $BoardListFailureCopyWith<$Res> {
  _$BoardListFailureCopyWithImpl(this._self, this._then);

  final BoardListFailure _self;
  final $Res Function(BoardListFailure) _then;

/// Create a copy of BoardListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BoardListFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
