// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryState()';
}


}

/// @nodoc
class $HistoryStateCopyWith<$Res>  {
$HistoryStateCopyWith(HistoryState _, $Res Function(HistoryState) __);
}


/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HistoryInitial value)?  initial,TResult Function( HistoryLoading value)?  loading,TResult Function( HistoryLoadingMore value)?  loadingMore,TResult Function( HistorySuccess value)?  success,TResult Function( HistoryFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial(_that);case HistoryLoading() when loading != null:
return loading(_that);case HistoryLoadingMore() when loadingMore != null:
return loadingMore(_that);case HistorySuccess() when success != null:
return success(_that);case HistoryFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HistoryInitial value)  initial,required TResult Function( HistoryLoading value)  loading,required TResult Function( HistoryLoadingMore value)  loadingMore,required TResult Function( HistorySuccess value)  success,required TResult Function( HistoryFailure value)  failure,}){
final _that = this;
switch (_that) {
case HistoryInitial():
return initial(_that);case HistoryLoading():
return loading(_that);case HistoryLoadingMore():
return loadingMore(_that);case HistorySuccess():
return success(_that);case HistoryFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HistoryInitial value)?  initial,TResult? Function( HistoryLoading value)?  loading,TResult? Function( HistoryLoadingMore value)?  loadingMore,TResult? Function( HistorySuccess value)?  success,TResult? Function( HistoryFailure value)?  failure,}){
final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial(_that);case HistoryLoading() when loading != null:
return loading(_that);case HistoryLoadingMore() when loadingMore != null:
return loadingMore(_that);case HistorySuccess() when success != null:
return success(_that);case HistoryFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ItemHistory> history)?  loadingMore,TResult Function( List<ItemHistory> history)?  success,TResult Function( String msg)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial();case HistoryLoading() when loading != null:
return loading();case HistoryLoadingMore() when loadingMore != null:
return loadingMore(_that.history);case HistorySuccess() when success != null:
return success(_that.history);case HistoryFailure() when failure != null:
return failure(_that.msg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ItemHistory> history)  loadingMore,required TResult Function( List<ItemHistory> history)  success,required TResult Function( String msg)  failure,}) {final _that = this;
switch (_that) {
case HistoryInitial():
return initial();case HistoryLoading():
return loading();case HistoryLoadingMore():
return loadingMore(_that.history);case HistorySuccess():
return success(_that.history);case HistoryFailure():
return failure(_that.msg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ItemHistory> history)?  loadingMore,TResult? Function( List<ItemHistory> history)?  success,TResult? Function( String msg)?  failure,}) {final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial();case HistoryLoading() when loading != null:
return loading();case HistoryLoadingMore() when loadingMore != null:
return loadingMore(_that.history);case HistorySuccess() when success != null:
return success(_that.history);case HistoryFailure() when failure != null:
return failure(_that.msg);case _:
  return null;

}
}

}

/// @nodoc


class HistoryInitial implements HistoryState {
  const HistoryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryState.initial()';
}


}




/// @nodoc


class HistoryLoading implements HistoryState {
  const HistoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryState.loading()';
}


}




/// @nodoc


class HistoryLoadingMore implements HistoryState {
  const HistoryLoadingMore(final  List<ItemHistory> history): _history = history;
  

 final  List<ItemHistory> _history;
 List<ItemHistory> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryLoadingMoreCopyWith<HistoryLoadingMore> get copyWith => _$HistoryLoadingMoreCopyWithImpl<HistoryLoadingMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryLoadingMore&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'HistoryState.loadingMore(history: $history)';
}


}

/// @nodoc
abstract mixin class $HistoryLoadingMoreCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory $HistoryLoadingMoreCopyWith(HistoryLoadingMore value, $Res Function(HistoryLoadingMore) _then) = _$HistoryLoadingMoreCopyWithImpl;
@useResult
$Res call({
 List<ItemHistory> history
});




}
/// @nodoc
class _$HistoryLoadingMoreCopyWithImpl<$Res>
    implements $HistoryLoadingMoreCopyWith<$Res> {
  _$HistoryLoadingMoreCopyWithImpl(this._self, this._then);

  final HistoryLoadingMore _self;
  final $Res Function(HistoryLoadingMore) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(HistoryLoadingMore(
null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<ItemHistory>,
  ));
}


}

/// @nodoc


class HistorySuccess implements HistoryState {
  const HistorySuccess(final  List<ItemHistory> history): _history = history;
  

 final  List<ItemHistory> _history;
 List<ItemHistory> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistorySuccessCopyWith<HistorySuccess> get copyWith => _$HistorySuccessCopyWithImpl<HistorySuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistorySuccess&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'HistoryState.success(history: $history)';
}


}

/// @nodoc
abstract mixin class $HistorySuccessCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory $HistorySuccessCopyWith(HistorySuccess value, $Res Function(HistorySuccess) _then) = _$HistorySuccessCopyWithImpl;
@useResult
$Res call({
 List<ItemHistory> history
});




}
/// @nodoc
class _$HistorySuccessCopyWithImpl<$Res>
    implements $HistorySuccessCopyWith<$Res> {
  _$HistorySuccessCopyWithImpl(this._self, this._then);

  final HistorySuccess _self;
  final $Res Function(HistorySuccess) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(HistorySuccess(
null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<ItemHistory>,
  ));
}


}

/// @nodoc


class HistoryFailure implements HistoryState {
  const HistoryFailure(this.msg);
  

 final  String msg;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryFailureCopyWith<HistoryFailure> get copyWith => _$HistoryFailureCopyWithImpl<HistoryFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryFailure&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'HistoryState.failure(msg: $msg)';
}


}

/// @nodoc
abstract mixin class $HistoryFailureCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory $HistoryFailureCopyWith(HistoryFailure value, $Res Function(HistoryFailure) _then) = _$HistoryFailureCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class _$HistoryFailureCopyWithImpl<$Res>
    implements $HistoryFailureCopyWith<$Res> {
  _$HistoryFailureCopyWithImpl(this._self, this._then);

  final HistoryFailure _self;
  final $Res Function(HistoryFailure) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(HistoryFailure(
null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OrderDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState()';
}


}

/// @nodoc
class $OrderDetailsStateCopyWith<$Res>  {
$OrderDetailsStateCopyWith(OrderDetailsState _, $Res Function(OrderDetailsState) __);
}


/// Adds pattern-matching-related methods to [OrderDetailsState].
extension OrderDetailsStatePatterns on OrderDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderDetailsInitial value)?  initial,TResult Function( OrderDetailsLoading value)?  loading,TResult Function( OrderDetailsSuccess value)?  success,TResult Function( OrderDetailsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderDetailsInitial() when initial != null:
return initial(_that);case OrderDetailsLoading() when loading != null:
return loading(_that);case OrderDetailsSuccess() when success != null:
return success(_that);case OrderDetailsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderDetailsInitial value)  initial,required TResult Function( OrderDetailsLoading value)  loading,required TResult Function( OrderDetailsSuccess value)  success,required TResult Function( OrderDetailsFailure value)  failure,}){
final _that = this;
switch (_that) {
case OrderDetailsInitial():
return initial(_that);case OrderDetailsLoading():
return loading(_that);case OrderDetailsSuccess():
return success(_that);case OrderDetailsFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderDetailsInitial value)?  initial,TResult? Function( OrderDetailsLoading value)?  loading,TResult? Function( OrderDetailsSuccess value)?  success,TResult? Function( OrderDetailsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case OrderDetailsInitial() when initial != null:
return initial(_that);case OrderDetailsLoading() when loading != null:
return loading(_that);case OrderDetailsSuccess() when success != null:
return success(_that);case OrderDetailsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( OrderDetails orderDetails)?  success,TResult Function( String msg)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderDetailsInitial() when initial != null:
return initial();case OrderDetailsLoading() when loading != null:
return loading();case OrderDetailsSuccess() when success != null:
return success(_that.orderDetails);case OrderDetailsFailure() when failure != null:
return failure(_that.msg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( OrderDetails orderDetails)  success,required TResult Function( String msg)  failure,}) {final _that = this;
switch (_that) {
case OrderDetailsInitial():
return initial();case OrderDetailsLoading():
return loading();case OrderDetailsSuccess():
return success(_that.orderDetails);case OrderDetailsFailure():
return failure(_that.msg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( OrderDetails orderDetails)?  success,TResult? Function( String msg)?  failure,}) {final _that = this;
switch (_that) {
case OrderDetailsInitial() when initial != null:
return initial();case OrderDetailsLoading() when loading != null:
return loading();case OrderDetailsSuccess() when success != null:
return success(_that.orderDetails);case OrderDetailsFailure() when failure != null:
return failure(_that.msg);case _:
  return null;

}
}

}

/// @nodoc


class OrderDetailsInitial implements OrderDetailsState {
  const OrderDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState.initial()';
}


}




/// @nodoc


class OrderDetailsLoading implements OrderDetailsState {
  const OrderDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState.loading()';
}


}




/// @nodoc


class OrderDetailsSuccess implements OrderDetailsState {
  const OrderDetailsSuccess(this.orderDetails);
  

 final  OrderDetails orderDetails;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsSuccessCopyWith<OrderDetailsSuccess> get copyWith => _$OrderDetailsSuccessCopyWithImpl<OrderDetailsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsSuccess&&(identical(other.orderDetails, orderDetails) || other.orderDetails == orderDetails));
}


@override
int get hashCode => Object.hash(runtimeType,orderDetails);

@override
String toString() {
  return 'OrderDetailsState.success(orderDetails: $orderDetails)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsSuccessCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsSuccessCopyWith(OrderDetailsSuccess value, $Res Function(OrderDetailsSuccess) _then) = _$OrderDetailsSuccessCopyWithImpl;
@useResult
$Res call({
 OrderDetails orderDetails
});




}
/// @nodoc
class _$OrderDetailsSuccessCopyWithImpl<$Res>
    implements $OrderDetailsSuccessCopyWith<$Res> {
  _$OrderDetailsSuccessCopyWithImpl(this._self, this._then);

  final OrderDetailsSuccess _self;
  final $Res Function(OrderDetailsSuccess) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderDetails = null,}) {
  return _then(OrderDetailsSuccess(
null == orderDetails ? _self.orderDetails : orderDetails // ignore: cast_nullable_to_non_nullable
as OrderDetails,
  ));
}


}

/// @nodoc


class OrderDetailsFailure implements OrderDetailsState {
  const OrderDetailsFailure(this.msg);
  

 final  String msg;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsFailureCopyWith<OrderDetailsFailure> get copyWith => _$OrderDetailsFailureCopyWithImpl<OrderDetailsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsFailure&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'OrderDetailsState.failure(msg: $msg)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsFailureCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsFailureCopyWith(OrderDetailsFailure value, $Res Function(OrderDetailsFailure) _then) = _$OrderDetailsFailureCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class _$OrderDetailsFailureCopyWithImpl<$Res>
    implements $OrderDetailsFailureCopyWith<$Res> {
  _$OrderDetailsFailureCopyWithImpl(this._self, this._then);

  final OrderDetailsFailure _self;
  final $Res Function(OrderDetailsFailure) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(OrderDetailsFailure(
null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
