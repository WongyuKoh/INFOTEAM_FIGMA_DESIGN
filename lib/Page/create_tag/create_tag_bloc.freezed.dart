// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_tag_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateTagEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTagEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateTagEvent()';
}


}

/// @nodoc
class $CreateTagEventCopyWith<$Res>  {
$CreateTagEventCopyWith(CreateTagEvent _, $Res Function(CreateTagEvent) __);
}


/// Adds pattern-matching-related methods to [CreateTagEvent].
extension CreateTagEventPatterns on CreateTagEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreateTagInputChanged value)?  inputChanged,TResult Function( CreateTagAdded value)?  tagAdded,TResult Function( CreateTagSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreateTagInputChanged() when inputChanged != null:
return inputChanged(_that);case CreateTagAdded() when tagAdded != null:
return tagAdded(_that);case CreateTagSubmitted() when submitted != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreateTagInputChanged value)  inputChanged,required TResult Function( CreateTagAdded value)  tagAdded,required TResult Function( CreateTagSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case CreateTagInputChanged():
return inputChanged(_that);case CreateTagAdded():
return tagAdded(_that);case CreateTagSubmitted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreateTagInputChanged value)?  inputChanged,TResult? Function( CreateTagAdded value)?  tagAdded,TResult? Function( CreateTagSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case CreateTagInputChanged() when inputChanged != null:
return inputChanged(_that);case CreateTagAdded() when tagAdded != null:
return tagAdded(_that);case CreateTagSubmitted() when submitted != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String value)?  inputChanged,TResult Function()?  tagAdded,TResult Function()?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreateTagInputChanged() when inputChanged != null:
return inputChanged(_that.value);case CreateTagAdded() when tagAdded != null:
return tagAdded();case CreateTagSubmitted() when submitted != null:
return submitted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String value)  inputChanged,required TResult Function()  tagAdded,required TResult Function()  submitted,}) {final _that = this;
switch (_that) {
case CreateTagInputChanged():
return inputChanged(_that.value);case CreateTagAdded():
return tagAdded();case CreateTagSubmitted():
return submitted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String value)?  inputChanged,TResult? Function()?  tagAdded,TResult? Function()?  submitted,}) {final _that = this;
switch (_that) {
case CreateTagInputChanged() when inputChanged != null:
return inputChanged(_that.value);case CreateTagAdded() when tagAdded != null:
return tagAdded();case CreateTagSubmitted() when submitted != null:
return submitted();case _:
  return null;

}
}

}

/// @nodoc


class CreateTagInputChanged implements CreateTagEvent {
  const CreateTagInputChanged(this.value);
  

 final  String value;

/// Create a copy of CreateTagEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTagInputChangedCopyWith<CreateTagInputChanged> get copyWith => _$CreateTagInputChangedCopyWithImpl<CreateTagInputChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTagInputChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'CreateTagEvent.inputChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $CreateTagInputChangedCopyWith<$Res> implements $CreateTagEventCopyWith<$Res> {
  factory $CreateTagInputChangedCopyWith(CreateTagInputChanged value, $Res Function(CreateTagInputChanged) _then) = _$CreateTagInputChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$CreateTagInputChangedCopyWithImpl<$Res>
    implements $CreateTagInputChangedCopyWith<$Res> {
  _$CreateTagInputChangedCopyWithImpl(this._self, this._then);

  final CreateTagInputChanged _self;
  final $Res Function(CreateTagInputChanged) _then;

/// Create a copy of CreateTagEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(CreateTagInputChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateTagAdded implements CreateTagEvent {
  const CreateTagAdded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTagAdded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateTagEvent.tagAdded()';
}


}




/// @nodoc


class CreateTagSubmitted implements CreateTagEvent {
  const CreateTagSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTagSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreateTagEvent.submitted()';
}


}




/// @nodoc
mixin _$CreateTagState {

 String get input; List<String> get tags; CreateTagStatus get status; String get errorMessage;
/// Create a copy of CreateTagState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTagStateCopyWith<CreateTagState> get copyWith => _$CreateTagStateCopyWithImpl<CreateTagState>(this as CreateTagState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTagState&&(identical(other.input, input) || other.input == input)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,input,const DeepCollectionEquality().hash(tags),status,errorMessage);

@override
String toString() {
  return 'CreateTagState(input: $input, tags: $tags, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CreateTagStateCopyWith<$Res>  {
  factory $CreateTagStateCopyWith(CreateTagState value, $Res Function(CreateTagState) _then) = _$CreateTagStateCopyWithImpl;
@useResult
$Res call({
 String input, List<String> tags, CreateTagStatus status, String errorMessage
});




}
/// @nodoc
class _$CreateTagStateCopyWithImpl<$Res>
    implements $CreateTagStateCopyWith<$Res> {
  _$CreateTagStateCopyWithImpl(this._self, this._then);

  final CreateTagState _self;
  final $Res Function(CreateTagState) _then;

/// Create a copy of CreateTagState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? input = null,Object? tags = null,Object? status = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateTagStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTagState].
extension CreateTagStatePatterns on CreateTagState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTagState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTagState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTagState value)  $default,){
final _that = this;
switch (_that) {
case _CreateTagState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTagState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTagState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String input,  List<String> tags,  CreateTagStatus status,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTagState() when $default != null:
return $default(_that.input,_that.tags,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String input,  List<String> tags,  CreateTagStatus status,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CreateTagState():
return $default(_that.input,_that.tags,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String input,  List<String> tags,  CreateTagStatus status,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CreateTagState() when $default != null:
return $default(_that.input,_that.tags,_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CreateTagState extends CreateTagState {
  const _CreateTagState({this.input = '', final  List<String> tags = const <String>[], this.status = CreateTagStatus.editing, this.errorMessage = ''}): _tags = tags,super._();
  

@override@JsonKey() final  String input;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  CreateTagStatus status;
@override@JsonKey() final  String errorMessage;

/// Create a copy of CreateTagState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTagStateCopyWith<_CreateTagState> get copyWith => __$CreateTagStateCopyWithImpl<_CreateTagState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTagState&&(identical(other.input, input) || other.input == input)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,input,const DeepCollectionEquality().hash(_tags),status,errorMessage);

@override
String toString() {
  return 'CreateTagState(input: $input, tags: $tags, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CreateTagStateCopyWith<$Res> implements $CreateTagStateCopyWith<$Res> {
  factory _$CreateTagStateCopyWith(_CreateTagState value, $Res Function(_CreateTagState) _then) = __$CreateTagStateCopyWithImpl;
@override @useResult
$Res call({
 String input, List<String> tags, CreateTagStatus status, String errorMessage
});




}
/// @nodoc
class __$CreateTagStateCopyWithImpl<$Res>
    implements _$CreateTagStateCopyWith<$Res> {
  __$CreateTagStateCopyWithImpl(this._self, this._then);

  final _CreateTagState _self;
  final $Res Function(_CreateTagState) _then;

/// Create a copy of CreateTagState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? input = null,Object? tags = null,Object? status = null,Object? errorMessage = null,}) {
  return _then(_CreateTagState(
input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateTagStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
