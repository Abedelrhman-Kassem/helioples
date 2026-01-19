// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verfy_and_register_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerfAndRegisterStates {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerfAndRegisterStates);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerfAndRegisterStates()';
}


}

/// @nodoc
class $VerfAndRegisterStatesCopyWith<$Res>  {
$VerfAndRegisterStatesCopyWith(VerfAndRegisterStates _, $Res Function(VerfAndRegisterStates) __);
}


/// Adds pattern-matching-related methods to [VerfAndRegisterStates].
extension VerfAndRegisterStatesPatterns on VerfAndRegisterStates {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VerfAndRegisterInitial value)?  initial,TResult Function( VerfOtpLoading value)?  verfOtpLoading,TResult Function( RegisterLoading value)?  registerLoading,TResult Function( VerfOtpFailure value)?  verfOtpFailure,TResult Function( RegisterFailure value)?  registerFailure,TResult Function( VerfOtpSuccess value)?  verfOtpSuccess,TResult Function( RegisterSuccess value)?  registerSuccess,TResult Function( ClearText value)?  clearText,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VerfAndRegisterInitial() when initial != null:
return initial(_that);case VerfOtpLoading() when verfOtpLoading != null:
return verfOtpLoading(_that);case RegisterLoading() when registerLoading != null:
return registerLoading(_that);case VerfOtpFailure() when verfOtpFailure != null:
return verfOtpFailure(_that);case RegisterFailure() when registerFailure != null:
return registerFailure(_that);case VerfOtpSuccess() when verfOtpSuccess != null:
return verfOtpSuccess(_that);case RegisterSuccess() when registerSuccess != null:
return registerSuccess(_that);case ClearText() when clearText != null:
return clearText(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VerfAndRegisterInitial value)  initial,required TResult Function( VerfOtpLoading value)  verfOtpLoading,required TResult Function( RegisterLoading value)  registerLoading,required TResult Function( VerfOtpFailure value)  verfOtpFailure,required TResult Function( RegisterFailure value)  registerFailure,required TResult Function( VerfOtpSuccess value)  verfOtpSuccess,required TResult Function( RegisterSuccess value)  registerSuccess,required TResult Function( ClearText value)  clearText,}){
final _that = this;
switch (_that) {
case VerfAndRegisterInitial():
return initial(_that);case VerfOtpLoading():
return verfOtpLoading(_that);case RegisterLoading():
return registerLoading(_that);case VerfOtpFailure():
return verfOtpFailure(_that);case RegisterFailure():
return registerFailure(_that);case VerfOtpSuccess():
return verfOtpSuccess(_that);case RegisterSuccess():
return registerSuccess(_that);case ClearText():
return clearText(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VerfAndRegisterInitial value)?  initial,TResult? Function( VerfOtpLoading value)?  verfOtpLoading,TResult? Function( RegisterLoading value)?  registerLoading,TResult? Function( VerfOtpFailure value)?  verfOtpFailure,TResult? Function( RegisterFailure value)?  registerFailure,TResult? Function( VerfOtpSuccess value)?  verfOtpSuccess,TResult? Function( RegisterSuccess value)?  registerSuccess,TResult? Function( ClearText value)?  clearText,}){
final _that = this;
switch (_that) {
case VerfAndRegisterInitial() when initial != null:
return initial(_that);case VerfOtpLoading() when verfOtpLoading != null:
return verfOtpLoading(_that);case RegisterLoading() when registerLoading != null:
return registerLoading(_that);case VerfOtpFailure() when verfOtpFailure != null:
return verfOtpFailure(_that);case RegisterFailure() when registerFailure != null:
return registerFailure(_that);case VerfOtpSuccess() when verfOtpSuccess != null:
return verfOtpSuccess(_that);case RegisterSuccess() when registerSuccess != null:
return registerSuccess(_that);case ClearText() when clearText != null:
return clearText(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  verfOtpLoading,TResult Function()?  registerLoading,TResult Function( Failure errorMessage)?  verfOtpFailure,TResult Function( String errorMessage)?  registerFailure,TResult Function( bool result)?  verfOtpSuccess,TResult Function( ApiResponse result)?  registerSuccess,TResult Function()?  clearText,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VerfAndRegisterInitial() when initial != null:
return initial();case VerfOtpLoading() when verfOtpLoading != null:
return verfOtpLoading();case RegisterLoading() when registerLoading != null:
return registerLoading();case VerfOtpFailure() when verfOtpFailure != null:
return verfOtpFailure(_that.errorMessage);case RegisterFailure() when registerFailure != null:
return registerFailure(_that.errorMessage);case VerfOtpSuccess() when verfOtpSuccess != null:
return verfOtpSuccess(_that.result);case RegisterSuccess() when registerSuccess != null:
return registerSuccess(_that.result);case ClearText() when clearText != null:
return clearText();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  verfOtpLoading,required TResult Function()  registerLoading,required TResult Function( Failure errorMessage)  verfOtpFailure,required TResult Function( String errorMessage)  registerFailure,required TResult Function( bool result)  verfOtpSuccess,required TResult Function( ApiResponse result)  registerSuccess,required TResult Function()  clearText,}) {final _that = this;
switch (_that) {
case VerfAndRegisterInitial():
return initial();case VerfOtpLoading():
return verfOtpLoading();case RegisterLoading():
return registerLoading();case VerfOtpFailure():
return verfOtpFailure(_that.errorMessage);case RegisterFailure():
return registerFailure(_that.errorMessage);case VerfOtpSuccess():
return verfOtpSuccess(_that.result);case RegisterSuccess():
return registerSuccess(_that.result);case ClearText():
return clearText();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  verfOtpLoading,TResult? Function()?  registerLoading,TResult? Function( Failure errorMessage)?  verfOtpFailure,TResult? Function( String errorMessage)?  registerFailure,TResult? Function( bool result)?  verfOtpSuccess,TResult? Function( ApiResponse result)?  registerSuccess,TResult? Function()?  clearText,}) {final _that = this;
switch (_that) {
case VerfAndRegisterInitial() when initial != null:
return initial();case VerfOtpLoading() when verfOtpLoading != null:
return verfOtpLoading();case RegisterLoading() when registerLoading != null:
return registerLoading();case VerfOtpFailure() when verfOtpFailure != null:
return verfOtpFailure(_that.errorMessage);case RegisterFailure() when registerFailure != null:
return registerFailure(_that.errorMessage);case VerfOtpSuccess() when verfOtpSuccess != null:
return verfOtpSuccess(_that.result);case RegisterSuccess() when registerSuccess != null:
return registerSuccess(_that.result);case ClearText() when clearText != null:
return clearText();case _:
  return null;

}
}

}

/// @nodoc


class VerfAndRegisterInitial implements VerfAndRegisterStates {
  const VerfAndRegisterInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerfAndRegisterInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerfAndRegisterStates.initial()';
}


}




/// @nodoc


class VerfOtpLoading implements VerfAndRegisterStates {
  const VerfOtpLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerfOtpLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerfAndRegisterStates.verfOtpLoading()';
}


}




/// @nodoc


class RegisterLoading implements VerfAndRegisterStates {
  const RegisterLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerfAndRegisterStates.registerLoading()';
}


}




/// @nodoc


class VerfOtpFailure implements VerfAndRegisterStates {
  const VerfOtpFailure(this.errorMessage);
  

 final  Failure errorMessage;

/// Create a copy of VerfAndRegisterStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerfOtpFailureCopyWith<VerfOtpFailure> get copyWith => _$VerfOtpFailureCopyWithImpl<VerfOtpFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerfOtpFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'VerfAndRegisterStates.verfOtpFailure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $VerfOtpFailureCopyWith<$Res> implements $VerfAndRegisterStatesCopyWith<$Res> {
  factory $VerfOtpFailureCopyWith(VerfOtpFailure value, $Res Function(VerfOtpFailure) _then) = _$VerfOtpFailureCopyWithImpl;
@useResult
$Res call({
 Failure errorMessage
});




}
/// @nodoc
class _$VerfOtpFailureCopyWithImpl<$Res>
    implements $VerfOtpFailureCopyWith<$Res> {
  _$VerfOtpFailureCopyWithImpl(this._self, this._then);

  final VerfOtpFailure _self;
  final $Res Function(VerfOtpFailure) _then;

/// Create a copy of VerfAndRegisterStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(VerfOtpFailure(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class RegisterFailure implements VerfAndRegisterStates {
  const RegisterFailure(this.errorMessage);
  

 final  String errorMessage;

/// Create a copy of VerfAndRegisterStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterFailureCopyWith<RegisterFailure> get copyWith => _$RegisterFailureCopyWithImpl<RegisterFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'VerfAndRegisterStates.registerFailure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $RegisterFailureCopyWith<$Res> implements $VerfAndRegisterStatesCopyWith<$Res> {
  factory $RegisterFailureCopyWith(RegisterFailure value, $Res Function(RegisterFailure) _then) = _$RegisterFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class _$RegisterFailureCopyWithImpl<$Res>
    implements $RegisterFailureCopyWith<$Res> {
  _$RegisterFailureCopyWithImpl(this._self, this._then);

  final RegisterFailure _self;
  final $Res Function(RegisterFailure) _then;

/// Create a copy of VerfAndRegisterStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(RegisterFailure(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerfOtpSuccess implements VerfAndRegisterStates {
  const VerfOtpSuccess(this.result);
  

 final  bool result;

/// Create a copy of VerfAndRegisterStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerfOtpSuccessCopyWith<VerfOtpSuccess> get copyWith => _$VerfOtpSuccessCopyWithImpl<VerfOtpSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerfOtpSuccess&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'VerfAndRegisterStates.verfOtpSuccess(result: $result)';
}


}

/// @nodoc
abstract mixin class $VerfOtpSuccessCopyWith<$Res> implements $VerfAndRegisterStatesCopyWith<$Res> {
  factory $VerfOtpSuccessCopyWith(VerfOtpSuccess value, $Res Function(VerfOtpSuccess) _then) = _$VerfOtpSuccessCopyWithImpl;
@useResult
$Res call({
 bool result
});




}
/// @nodoc
class _$VerfOtpSuccessCopyWithImpl<$Res>
    implements $VerfOtpSuccessCopyWith<$Res> {
  _$VerfOtpSuccessCopyWithImpl(this._self, this._then);

  final VerfOtpSuccess _self;
  final $Res Function(VerfOtpSuccess) _then;

/// Create a copy of VerfAndRegisterStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(VerfOtpSuccess(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class RegisterSuccess implements VerfAndRegisterStates {
  const RegisterSuccess(this.result);
  

 final  ApiResponse result;

/// Create a copy of VerfAndRegisterStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterSuccessCopyWith<RegisterSuccess> get copyWith => _$RegisterSuccessCopyWithImpl<RegisterSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSuccess&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'VerfAndRegisterStates.registerSuccess(result: $result)';
}


}

/// @nodoc
abstract mixin class $RegisterSuccessCopyWith<$Res> implements $VerfAndRegisterStatesCopyWith<$Res> {
  factory $RegisterSuccessCopyWith(RegisterSuccess value, $Res Function(RegisterSuccess) _then) = _$RegisterSuccessCopyWithImpl;
@useResult
$Res call({
 ApiResponse result
});




}
/// @nodoc
class _$RegisterSuccessCopyWithImpl<$Res>
    implements $RegisterSuccessCopyWith<$Res> {
  _$RegisterSuccessCopyWithImpl(this._self, this._then);

  final RegisterSuccess _self;
  final $Res Function(RegisterSuccess) _then;

/// Create a copy of VerfAndRegisterStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(RegisterSuccess(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ApiResponse,
  ));
}


}

/// @nodoc


class ClearText implements VerfAndRegisterStates {
  const ClearText();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearText);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerfAndRegisterStates.clearText()';
}


}




// dart format on
