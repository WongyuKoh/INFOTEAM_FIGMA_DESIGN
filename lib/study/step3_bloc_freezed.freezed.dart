// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step3_bloc_freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CounterEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CounterEvent()';
}


}

/// @nodoc
class $CounterEventCopyWith<$Res>  {
$CounterEventCopyWith(CounterEvent _, $Res Function(CounterEvent) __);
}


/// Adds pattern-matching-related methods to [CounterEvent].
extension CounterEventPatterns on CounterEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IncrementPressed value)?  increment,TResult Function( DecrementPressed value)?  decrement,TResult Function( AmountAdded value)?  addAmount,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IncrementPressed() when increment != null:
return increment(_that);case DecrementPressed() when decrement != null:
return decrement(_that);case AmountAdded() when addAmount != null:
return addAmount(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IncrementPressed value)  increment,required TResult Function( DecrementPressed value)  decrement,required TResult Function( AmountAdded value)  addAmount,}){
final _that = this;
switch (_that) {
case IncrementPressed():
return increment(_that);case DecrementPressed():
return decrement(_that);case AmountAdded():
return addAmount(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IncrementPressed value)?  increment,TResult? Function( DecrementPressed value)?  decrement,TResult? Function( AmountAdded value)?  addAmount,}){
final _that = this;
switch (_that) {
case IncrementPressed() when increment != null:
return increment(_that);case DecrementPressed() when decrement != null:
return decrement(_that);case AmountAdded() when addAmount != null:
return addAmount(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  increment,TResult Function()?  decrement,TResult Function( int amount)?  addAmount,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IncrementPressed() when increment != null:
return increment();case DecrementPressed() when decrement != null:
return decrement();case AmountAdded() when addAmount != null:
return addAmount(_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  increment,required TResult Function()  decrement,required TResult Function( int amount)  addAmount,}) {final _that = this;
switch (_that) {
case IncrementPressed():
return increment();case DecrementPressed():
return decrement();case AmountAdded():
return addAmount(_that.amount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  increment,TResult? Function()?  decrement,TResult? Function( int amount)?  addAmount,}) {final _that = this;
switch (_that) {
case IncrementPressed() when increment != null:
return increment();case DecrementPressed() when decrement != null:
return decrement();case AmountAdded() when addAmount != null:
return addAmount(_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class IncrementPressed implements CounterEvent {
  const IncrementPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncrementPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CounterEvent.increment()';
}


}




/// @nodoc


class DecrementPressed implements CounterEvent {
  const DecrementPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecrementPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CounterEvent.decrement()';
}


}




/// @nodoc


class AmountAdded implements CounterEvent {
  const AmountAdded(this.amount);
  

 final  int amount;

/// Create a copy of CounterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmountAddedCopyWith<AmountAdded> get copyWith => _$AmountAddedCopyWithImpl<AmountAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmountAdded&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'CounterEvent.addAmount(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $AmountAddedCopyWith<$Res> implements $CounterEventCopyWith<$Res> {
  factory $AmountAddedCopyWith(AmountAdded value, $Res Function(AmountAdded) _then) = _$AmountAddedCopyWithImpl;
@useResult
$Res call({
 int amount
});




}
/// @nodoc
class _$AmountAddedCopyWithImpl<$Res>
    implements $AmountAddedCopyWith<$Res> {
  _$AmountAddedCopyWithImpl(this._self, this._then);

  final AmountAdded _self;
  final $Res Function(AmountAdded) _then;

/// Create a copy of CounterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(AmountAdded(
null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CounterState {

 int get count;// @Default = 기본값 지정
 int get tapCount;
/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CounterStateCopyWith<CounterState> get copyWith => _$CounterStateCopyWithImpl<CounterState>(this as CounterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterState&&(identical(other.count, count) || other.count == count)&&(identical(other.tapCount, tapCount) || other.tapCount == tapCount));
}


@override
int get hashCode => Object.hash(runtimeType,count,tapCount);

@override
String toString() {
  return 'CounterState(count: $count, tapCount: $tapCount)';
}


}

/// @nodoc
abstract mixin class $CounterStateCopyWith<$Res>  {
  factory $CounterStateCopyWith(CounterState value, $Res Function(CounterState) _then) = _$CounterStateCopyWithImpl;
@useResult
$Res call({
 int count, int tapCount
});




}
/// @nodoc
class _$CounterStateCopyWithImpl<$Res>
    implements $CounterStateCopyWith<$Res> {
  _$CounterStateCopyWithImpl(this._self, this._then);

  final CounterState _self;
  final $Res Function(CounterState) _then;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? tapCount = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,tapCount: null == tapCount ? _self.tapCount : tapCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CounterState].
extension CounterStatePatterns on CounterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CounterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CounterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CounterState value)  $default,){
final _that = this;
switch (_that) {
case _CounterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CounterState value)?  $default,){
final _that = this;
switch (_that) {
case _CounterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  int tapCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CounterState() when $default != null:
return $default(_that.count,_that.tapCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  int tapCount)  $default,) {final _that = this;
switch (_that) {
case _CounterState():
return $default(_that.count,_that.tapCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  int tapCount)?  $default,) {final _that = this;
switch (_that) {
case _CounterState() when $default != null:
return $default(_that.count,_that.tapCount);case _:
  return null;

}
}

}

/// @nodoc


class _CounterState implements CounterState {
  const _CounterState({this.count = 0, this.tapCount = 0});
  

@override@JsonKey() final  int count;
// @Default = 기본값 지정
@override@JsonKey() final  int tapCount;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CounterStateCopyWith<_CounterState> get copyWith => __$CounterStateCopyWithImpl<_CounterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CounterState&&(identical(other.count, count) || other.count == count)&&(identical(other.tapCount, tapCount) || other.tapCount == tapCount));
}


@override
int get hashCode => Object.hash(runtimeType,count,tapCount);

@override
String toString() {
  return 'CounterState(count: $count, tapCount: $tapCount)';
}


}

/// @nodoc
abstract mixin class _$CounterStateCopyWith<$Res> implements $CounterStateCopyWith<$Res> {
  factory _$CounterStateCopyWith(_CounterState value, $Res Function(_CounterState) _then) = __$CounterStateCopyWithImpl;
@override @useResult
$Res call({
 int count, int tapCount
});




}
/// @nodoc
class __$CounterStateCopyWithImpl<$Res>
    implements _$CounterStateCopyWith<$Res> {
  __$CounterStateCopyWithImpl(this._self, this._then);

  final _CounterState _self;
  final $Res Function(_CounterState) _then;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? tapCount = null,}) {
  return _then(_CounterState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,tapCount: null == tapCount ? _self.tapCount : tapCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
