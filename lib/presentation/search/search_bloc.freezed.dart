// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchEvent {

 String get keyword;
/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchEventCopyWith<SearchEvent> get copyWith => _$SearchEventCopyWithImpl<SearchEvent>(this as SearchEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchEvent&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,keyword);

@override
String toString() {
  return 'SearchEvent(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class $SearchEventCopyWith<$Res>  {
  factory $SearchEventCopyWith(SearchEvent value, $Res Function(SearchEvent) _then) = _$SearchEventCopyWithImpl;
@useResult
$Res call({
 String keyword
});




}
/// @nodoc
class _$SearchEventCopyWithImpl<$Res>
    implements $SearchEventCopyWith<$Res> {
  _$SearchEventCopyWithImpl(this._self, this._then);

  final SearchEvent _self;
  final $Res Function(SearchEvent) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyword = null,}) {
  return _then(_self.copyWith(
keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchEvent].
extension SearchEventPatterns on SearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchKeywordChanged value)?  keywordChanged,TResult Function( SearchSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchKeywordChanged() when keywordChanged != null:
return keywordChanged(_that);case SearchSubmitted() when submitted != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchKeywordChanged value)  keywordChanged,required TResult Function( SearchSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case SearchKeywordChanged():
return keywordChanged(_that);case SearchSubmitted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchKeywordChanged value)?  keywordChanged,TResult? Function( SearchSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case SearchKeywordChanged() when keywordChanged != null:
return keywordChanged(_that);case SearchSubmitted() when submitted != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String keyword)?  keywordChanged,TResult Function( String keyword)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchKeywordChanged() when keywordChanged != null:
return keywordChanged(_that.keyword);case SearchSubmitted() when submitted != null:
return submitted(_that.keyword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String keyword)  keywordChanged,required TResult Function( String keyword)  submitted,}) {final _that = this;
switch (_that) {
case SearchKeywordChanged():
return keywordChanged(_that.keyword);case SearchSubmitted():
return submitted(_that.keyword);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String keyword)?  keywordChanged,TResult? Function( String keyword)?  submitted,}) {final _that = this;
switch (_that) {
case SearchKeywordChanged() when keywordChanged != null:
return keywordChanged(_that.keyword);case SearchSubmitted() when submitted != null:
return submitted(_that.keyword);case _:
  return null;

}
}

}

/// @nodoc


class SearchKeywordChanged implements SearchEvent {
  const SearchKeywordChanged(this.keyword);
  

@override final  String keyword;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchKeywordChangedCopyWith<SearchKeywordChanged> get copyWith => _$SearchKeywordChangedCopyWithImpl<SearchKeywordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchKeywordChanged&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,keyword);

@override
String toString() {
  return 'SearchEvent.keywordChanged(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class $SearchKeywordChangedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchKeywordChangedCopyWith(SearchKeywordChanged value, $Res Function(SearchKeywordChanged) _then) = _$SearchKeywordChangedCopyWithImpl;
@override @useResult
$Res call({
 String keyword
});




}
/// @nodoc
class _$SearchKeywordChangedCopyWithImpl<$Res>
    implements $SearchKeywordChangedCopyWith<$Res> {
  _$SearchKeywordChangedCopyWithImpl(this._self, this._then);

  final SearchKeywordChanged _self;
  final $Res Function(SearchKeywordChanged) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = null,}) {
  return _then(SearchKeywordChanged(
null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchSubmitted implements SearchEvent {
  const SearchSubmitted(this.keyword);
  

@override final  String keyword;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSubmittedCopyWith<SearchSubmitted> get copyWith => _$SearchSubmittedCopyWithImpl<SearchSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSubmitted&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,keyword);

@override
String toString() {
  return 'SearchEvent.submitted(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class $SearchSubmittedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchSubmittedCopyWith(SearchSubmitted value, $Res Function(SearchSubmitted) _then) = _$SearchSubmittedCopyWithImpl;
@override @useResult
$Res call({
 String keyword
});




}
/// @nodoc
class _$SearchSubmittedCopyWithImpl<$Res>
    implements $SearchSubmittedCopyWith<$Res> {
  _$SearchSubmittedCopyWithImpl(this._self, this._then);

  final SearchSubmitted _self;
  final $Res Function(SearchSubmitted) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = null,}) {
  return _then(SearchSubmitted(
null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState()';
}


}

/// @nodoc
class $SearchStateCopyWith<$Res>  {
$SearchStateCopyWith(SearchState _, $Res Function(SearchState) __);
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchInitial value)?  initial,TResult Function( SearchLoading value)?  loading,TResult Function( SearchLoaded value)?  loaded,TResult Function( SearchFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial(_that);case SearchLoading() when loading != null:
return loading(_that);case SearchLoaded() when loaded != null:
return loaded(_that);case SearchFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchInitial value)  initial,required TResult Function( SearchLoading value)  loading,required TResult Function( SearchLoaded value)  loaded,required TResult Function( SearchFailure value)  failure,}){
final _that = this;
switch (_that) {
case SearchInitial():
return initial(_that);case SearchLoading():
return loading(_that);case SearchLoaded():
return loaded(_that);case SearchFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchInitial value)?  initial,TResult? Function( SearchLoading value)?  loading,TResult? Function( SearchLoaded value)?  loaded,TResult? Function( SearchFailure value)?  failure,}){
final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial(_that);case SearchLoading() when loading != null:
return loading(_that);case SearchLoaded() when loaded != null:
return loaded(_that);case SearchFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String keyword,  List<Post> results)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial();case SearchLoading() when loading != null:
return loading();case SearchLoaded() when loaded != null:
return loaded(_that.keyword,_that.results);case SearchFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String keyword,  List<Post> results)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case SearchInitial():
return initial();case SearchLoading():
return loading();case SearchLoaded():
return loaded(_that.keyword,_that.results);case SearchFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String keyword,  List<Post> results)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial();case SearchLoading() when loading != null:
return loading();case SearchLoaded() when loaded != null:
return loaded(_that.keyword,_that.results);case SearchFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SearchInitial implements SearchState {
  const SearchInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.initial()';
}


}




/// @nodoc


class SearchLoading implements SearchState {
  const SearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.loading()';
}


}




/// @nodoc


class SearchLoaded implements SearchState {
  const SearchLoaded(this.keyword, final  List<Post> results): _results = results;
  

 final  String keyword;
 final  List<Post> _results;
 List<Post> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchLoadedCopyWith<SearchLoaded> get copyWith => _$SearchLoadedCopyWithImpl<SearchLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoaded&&(identical(other.keyword, keyword) || other.keyword == keyword)&&const DeepCollectionEquality().equals(other._results, _results));
}


@override
int get hashCode => Object.hash(runtimeType,keyword,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'SearchState.loaded(keyword: $keyword, results: $results)';
}


}

/// @nodoc
abstract mixin class $SearchLoadedCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchLoadedCopyWith(SearchLoaded value, $Res Function(SearchLoaded) _then) = _$SearchLoadedCopyWithImpl;
@useResult
$Res call({
 String keyword, List<Post> results
});




}
/// @nodoc
class _$SearchLoadedCopyWithImpl<$Res>
    implements $SearchLoadedCopyWith<$Res> {
  _$SearchLoadedCopyWithImpl(this._self, this._then);

  final SearchLoaded _self;
  final $Res Function(SearchLoaded) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = null,Object? results = null,}) {
  return _then(SearchLoaded(
null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}


}

/// @nodoc


class SearchFailure implements SearchState {
  const SearchFailure(this.message);
  

 final  String message;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFailureCopyWith<SearchFailure> get copyWith => _$SearchFailureCopyWithImpl<SearchFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SearchState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $SearchFailureCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchFailureCopyWith(SearchFailure value, $Res Function(SearchFailure) _then) = _$SearchFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SearchFailureCopyWithImpl<$Res>
    implements $SearchFailureCopyWith<$Res> {
  _$SearchFailureCopyWithImpl(this._self, this._then);

  final SearchFailure _self;
  final $Res Function(SearchFailure) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SearchFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
