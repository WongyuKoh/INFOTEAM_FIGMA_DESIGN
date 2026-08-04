// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatePostEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostEvent()';
}


}

/// @nodoc
class $CreatePostEventCopyWith<$Res>  {
$CreatePostEventCopyWith(CreatePostEvent _, $Res Function(CreatePostEvent) __);
}


/// Adds pattern-matching-related methods to [CreatePostEvent].
extension CreatePostEventPatterns on CreatePostEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreatePostPhotosRequested value)?  photosRequested,TResult Function( CreatePostPhotoRemoved value)?  photoRemoved,TResult Function( CreatePostErrorShown value)?  errorShown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreatePostPhotosRequested() when photosRequested != null:
return photosRequested(_that);case CreatePostPhotoRemoved() when photoRemoved != null:
return photoRemoved(_that);case CreatePostErrorShown() when errorShown != null:
return errorShown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreatePostPhotosRequested value)  photosRequested,required TResult Function( CreatePostPhotoRemoved value)  photoRemoved,required TResult Function( CreatePostErrorShown value)  errorShown,}){
final _that = this;
switch (_that) {
case CreatePostPhotosRequested():
return photosRequested(_that);case CreatePostPhotoRemoved():
return photoRemoved(_that);case CreatePostErrorShown():
return errorShown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreatePostPhotosRequested value)?  photosRequested,TResult? Function( CreatePostPhotoRemoved value)?  photoRemoved,TResult? Function( CreatePostErrorShown value)?  errorShown,}){
final _that = this;
switch (_that) {
case CreatePostPhotosRequested() when photosRequested != null:
return photosRequested(_that);case CreatePostPhotoRemoved() when photoRemoved != null:
return photoRemoved(_that);case CreatePostErrorShown() when errorShown != null:
return errorShown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  photosRequested,TResult Function( int index)?  photoRemoved,TResult Function()?  errorShown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreatePostPhotosRequested() when photosRequested != null:
return photosRequested();case CreatePostPhotoRemoved() when photoRemoved != null:
return photoRemoved(_that.index);case CreatePostErrorShown() when errorShown != null:
return errorShown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  photosRequested,required TResult Function( int index)  photoRemoved,required TResult Function()  errorShown,}) {final _that = this;
switch (_that) {
case CreatePostPhotosRequested():
return photosRequested();case CreatePostPhotoRemoved():
return photoRemoved(_that.index);case CreatePostErrorShown():
return errorShown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  photosRequested,TResult? Function( int index)?  photoRemoved,TResult? Function()?  errorShown,}) {final _that = this;
switch (_that) {
case CreatePostPhotosRequested() when photosRequested != null:
return photosRequested();case CreatePostPhotoRemoved() when photoRemoved != null:
return photoRemoved(_that.index);case CreatePostErrorShown() when errorShown != null:
return errorShown();case _:
  return null;

}
}

}

/// @nodoc


class CreatePostPhotosRequested implements CreatePostEvent {
  const CreatePostPhotosRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostPhotosRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostEvent.photosRequested()';
}


}




/// @nodoc


class CreatePostPhotoRemoved implements CreatePostEvent {
  const CreatePostPhotoRemoved(this.index);
  

 final  int index;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePostPhotoRemovedCopyWith<CreatePostPhotoRemoved> get copyWith => _$CreatePostPhotoRemovedCopyWithImpl<CreatePostPhotoRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostPhotoRemoved&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'CreatePostEvent.photoRemoved(index: $index)';
}


}

/// @nodoc
abstract mixin class $CreatePostPhotoRemovedCopyWith<$Res> implements $CreatePostEventCopyWith<$Res> {
  factory $CreatePostPhotoRemovedCopyWith(CreatePostPhotoRemoved value, $Res Function(CreatePostPhotoRemoved) _then) = _$CreatePostPhotoRemovedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$CreatePostPhotoRemovedCopyWithImpl<$Res>
    implements $CreatePostPhotoRemovedCopyWith<$Res> {
  _$CreatePostPhotoRemovedCopyWithImpl(this._self, this._then);

  final CreatePostPhotoRemoved _self;
  final $Res Function(CreatePostPhotoRemoved) _then;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(CreatePostPhotoRemoved(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CreatePostErrorShown implements CreatePostEvent {
  const CreatePostErrorShown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostErrorShown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostEvent.errorShown()';
}


}




/// @nodoc
mixin _$CreatePostState {

/// base64 로 인코딩된 사진들. 서버가 이미지를 base64 로 주고받는다.
 List<String> get images; String get errorMessage;
/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePostStateCopyWith<CreatePostState> get copyWith => _$CreatePostStateCopyWithImpl<CreatePostState>(this as CreatePostState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostState&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(images),errorMessage);

@override
String toString() {
  return 'CreatePostState(images: $images, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CreatePostStateCopyWith<$Res>  {
  factory $CreatePostStateCopyWith(CreatePostState value, $Res Function(CreatePostState) _then) = _$CreatePostStateCopyWithImpl;
@useResult
$Res call({
 List<String> images, String errorMessage
});




}
/// @nodoc
class _$CreatePostStateCopyWithImpl<$Res>
    implements $CreatePostStateCopyWith<$Res> {
  _$CreatePostStateCopyWithImpl(this._self, this._then);

  final CreatePostState _self;
  final $Res Function(CreatePostState) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? images = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePostState].
extension CreatePostStatePatterns on CreatePostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePostState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePostState value)  $default,){
final _that = this;
switch (_that) {
case _CreatePostState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePostState value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> images,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
return $default(_that.images,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> images,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CreatePostState():
return $default(_that.images,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> images,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
return $default(_that.images,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CreatePostState implements CreatePostState {
  const _CreatePostState({final  List<String> images = const <String>[], this.errorMessage = ''}): _images = images;
  

/// base64 로 인코딩된 사진들. 서버가 이미지를 base64 로 주고받는다.
 final  List<String> _images;
/// base64 로 인코딩된 사진들. 서버가 이미지를 base64 로 주고받는다.
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  String errorMessage;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePostStateCopyWith<_CreatePostState> get copyWith => __$CreatePostStateCopyWithImpl<_CreatePostState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePostState&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_images),errorMessage);

@override
String toString() {
  return 'CreatePostState(images: $images, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CreatePostStateCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$CreatePostStateCopyWith(_CreatePostState value, $Res Function(_CreatePostState) _then) = __$CreatePostStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> images, String errorMessage
});




}
/// @nodoc
class __$CreatePostStateCopyWithImpl<$Res>
    implements _$CreatePostStateCopyWith<$Res> {
  __$CreatePostStateCopyWithImpl(this._self, this._then);

  final _CreatePostState _self;
  final $Res Function(_CreatePostState) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? images = null,Object? errorMessage = null,}) {
  return _then(_CreatePostState(
images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
