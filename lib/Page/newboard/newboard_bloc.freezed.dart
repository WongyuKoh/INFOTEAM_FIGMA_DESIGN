// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'newboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewboardEvent {

 String get title;
/// Create a copy of NewboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewboardEventCopyWith<NewboardEvent> get copyWith => _$NewboardEventCopyWithImpl<NewboardEvent>(this as NewboardEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewboardEvent&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'NewboardEvent(title: $title)';
}


}

/// @nodoc
abstract mixin class $NewboardEventCopyWith<$Res>  {
  factory $NewboardEventCopyWith(NewboardEvent value, $Res Function(NewboardEvent) _then) = _$NewboardEventCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class _$NewboardEventCopyWithImpl<$Res>
    implements $NewboardEventCopyWith<$Res> {
  _$NewboardEventCopyWithImpl(this._self, this._then);

  final NewboardEvent _self;
  final $Res Function(NewboardEvent) _then;

/// Create a copy of NewboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NewboardEvent].
extension NewboardEventPatterns on NewboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewboardSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewboardSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewboardSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case NewboardSubmitted():
return submitted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewboardSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case NewboardSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String title)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewboardSubmitted() when submitted != null:
return submitted(_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String title)  submitted,}) {final _that = this;
switch (_that) {
case NewboardSubmitted():
return submitted(_that.title);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String title)?  submitted,}) {final _that = this;
switch (_that) {
case NewboardSubmitted() when submitted != null:
return submitted(_that.title);case _:
  return null;

}
}

}

/// @nodoc


class NewboardSubmitted implements NewboardEvent {
  const NewboardSubmitted(this.title);
  

@override final  String title;

/// Create a copy of NewboardEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewboardSubmittedCopyWith<NewboardSubmitted> get copyWith => _$NewboardSubmittedCopyWithImpl<NewboardSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewboardSubmitted&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'NewboardEvent.submitted(title: $title)';
}


}

/// @nodoc
abstract mixin class $NewboardSubmittedCopyWith<$Res> implements $NewboardEventCopyWith<$Res> {
  factory $NewboardSubmittedCopyWith(NewboardSubmitted value, $Res Function(NewboardSubmitted) _then) = _$NewboardSubmittedCopyWithImpl;
@override @useResult
$Res call({
 String title
});




}
/// @nodoc
class _$NewboardSubmittedCopyWithImpl<$Res>
    implements $NewboardSubmittedCopyWith<$Res> {
  _$NewboardSubmittedCopyWithImpl(this._self, this._then);

  final NewboardSubmitted _self;
  final $Res Function(NewboardSubmitted) _then;

/// Create a copy of NewboardEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(NewboardSubmitted(
null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$NewboardState {

 NewboardStatus get status; String get errorMessage;
/// Create a copy of NewboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewboardStateCopyWith<NewboardState> get copyWith => _$NewboardStateCopyWithImpl<NewboardState>(this as NewboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewboardState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'NewboardState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $NewboardStateCopyWith<$Res>  {
  factory $NewboardStateCopyWith(NewboardState value, $Res Function(NewboardState) _then) = _$NewboardStateCopyWithImpl;
@useResult
$Res call({
 NewboardStatus status, String errorMessage
});




}
/// @nodoc
class _$NewboardStateCopyWithImpl<$Res>
    implements $NewboardStateCopyWith<$Res> {
  _$NewboardStateCopyWithImpl(this._self, this._then);

  final NewboardState _self;
  final $Res Function(NewboardState) _then;

/// Create a copy of NewboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NewboardStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NewboardState].
extension NewboardStatePatterns on NewboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewboardState value)  $default,){
final _that = this;
switch (_that) {
case _NewboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewboardState value)?  $default,){
final _that = this;
switch (_that) {
case _NewboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NewboardStatus status,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewboardState() when $default != null:
return $default(_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NewboardStatus status,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _NewboardState():
return $default(_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NewboardStatus status,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _NewboardState() when $default != null:
return $default(_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _NewboardState extends NewboardState {
  const _NewboardState({this.status = NewboardStatus.initial, this.errorMessage = ''}): super._();
  

@override@JsonKey() final  NewboardStatus status;
@override@JsonKey() final  String errorMessage;

/// Create a copy of NewboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewboardStateCopyWith<_NewboardState> get copyWith => __$NewboardStateCopyWithImpl<_NewboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewboardState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'NewboardState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$NewboardStateCopyWith<$Res> implements $NewboardStateCopyWith<$Res> {
  factory _$NewboardStateCopyWith(_NewboardState value, $Res Function(_NewboardState) _then) = __$NewboardStateCopyWithImpl;
@override @useResult
$Res call({
 NewboardStatus status, String errorMessage
});




}
/// @nodoc
class __$NewboardStateCopyWithImpl<$Res>
    implements _$NewboardStateCopyWith<$Res> {
  __$NewboardStateCopyWithImpl(this._self, this._then);

  final _NewboardState _self;
  final $Res Function(_NewboardState) _then;

/// Create a copy of NewboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,}) {
  return _then(_NewboardState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NewboardStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
