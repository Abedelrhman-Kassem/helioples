// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignInStates {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignInStates);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignInStates()';
  }
}

/// @nodoc
class $SignInStatesCopyWith<$Res> {
  $SignInStatesCopyWith(SignInStates _, $Res Function(SignInStates) __);
}

/// Adds pattern-matching-related methods to [SignInStates].
extension SignInStatesPatterns on SignInStates {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignInInitial value)? initial,
    TResult Function(SignInLoading value)? loading,
    TResult Function(SignInOtpLoading value)? otpLoading,
    TResult Function(SignInOtpFailure value)? otpFailure,
    TResult Function(SignInOtpSuccess value)? otpSuccess,
    TResult Function(SignInSuccess value)? success,
    TResult Function(SignInFailure value)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SignInInitial() when initial != null:
        return initial(_that);
      case SignInLoading() when loading != null:
        return loading(_that);
      case SignInOtpLoading() when otpLoading != null:
        return otpLoading(_that);
      case SignInOtpFailure() when otpFailure != null:
        return otpFailure(_that);
      case SignInOtpSuccess() when otpSuccess != null:
        return otpSuccess(_that);
      case SignInSuccess() when success != null:
        return success(_that);
      case SignInFailure() when failure != null:
        return failure(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignInInitial value) initial,
    required TResult Function(SignInLoading value) loading,
    required TResult Function(SignInOtpLoading value) otpLoading,
    required TResult Function(SignInOtpFailure value) otpFailure,
    required TResult Function(SignInOtpSuccess value) otpSuccess,
    required TResult Function(SignInSuccess value) success,
    required TResult Function(SignInFailure value) failure,
  }) {
    final _that = this;
    switch (_that) {
      case SignInInitial():
        return initial(_that);
      case SignInLoading():
        return loading(_that);
      case SignInOtpLoading():
        return otpLoading(_that);
      case SignInOtpFailure():
        return otpFailure(_that);
      case SignInOtpSuccess():
        return otpSuccess(_that);
      case SignInSuccess():
        return success(_that);
      case SignInFailure():
        return failure(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignInInitial value)? initial,
    TResult? Function(SignInLoading value)? loading,
    TResult? Function(SignInOtpLoading value)? otpLoading,
    TResult? Function(SignInOtpFailure value)? otpFailure,
    TResult? Function(SignInOtpSuccess value)? otpSuccess,
    TResult? Function(SignInSuccess value)? success,
    TResult? Function(SignInFailure value)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case SignInInitial() when initial != null:
        return initial(_that);
      case SignInLoading() when loading != null:
        return loading(_that);
      case SignInOtpLoading() when otpLoading != null:
        return otpLoading(_that);
      case SignInOtpFailure() when otpFailure != null:
        return otpFailure(_that);
      case SignInOtpSuccess() when otpSuccess != null:
        return otpSuccess(_that);
      case SignInSuccess() when success != null:
        return success(_that);
      case SignInFailure() when failure != null:
        return failure(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? otpLoading,
    TResult Function(String errorMessage)? otpFailure,
    TResult Function(bool result)? otpSuccess,
    TResult Function(LoginModel result)? success,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SignInInitial() when initial != null:
        return initial();
      case SignInLoading() when loading != null:
        return loading();
      case SignInOtpLoading() when otpLoading != null:
        return otpLoading();
      case SignInOtpFailure() when otpFailure != null:
        return otpFailure(_that.errorMessage);
      case SignInOtpSuccess() when otpSuccess != null:
        return otpSuccess(_that.result);
      case SignInSuccess() when success != null:
        return success(_that.result);
      case SignInFailure() when failure != null:
        return failure(_that.errorMessage);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() otpLoading,
    required TResult Function(String errorMessage) otpFailure,
    required TResult Function(bool result) otpSuccess,
    required TResult Function(LoginModel result) success,
    required TResult Function(String errorMessage) failure,
  }) {
    final _that = this;
    switch (_that) {
      case SignInInitial():
        return initial();
      case SignInLoading():
        return loading();
      case SignInOtpLoading():
        return otpLoading();
      case SignInOtpFailure():
        return otpFailure(_that.errorMessage);
      case SignInOtpSuccess():
        return otpSuccess(_that.result);
      case SignInSuccess():
        return success(_that.result);
      case SignInFailure():
        return failure(_that.errorMessage);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? otpLoading,
    TResult? Function(String errorMessage)? otpFailure,
    TResult? Function(bool result)? otpSuccess,
    TResult? Function(LoginModel result)? success,
    TResult? Function(String errorMessage)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case SignInInitial() when initial != null:
        return initial();
      case SignInLoading() when loading != null:
        return loading();
      case SignInOtpLoading() when otpLoading != null:
        return otpLoading();
      case SignInOtpFailure() when otpFailure != null:
        return otpFailure(_that.errorMessage);
      case SignInOtpSuccess() when otpSuccess != null:
        return otpSuccess(_that.result);
      case SignInSuccess() when success != null:
        return success(_that.result);
      case SignInFailure() when failure != null:
        return failure(_that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SignInInitial implements SignInStates {
  const SignInInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignInInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignInStates.initial()';
  }
}

/// @nodoc

class SignInLoading implements SignInStates {
  const SignInLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignInLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignInStates.loading()';
  }
}

/// @nodoc

class SignInOtpLoading implements SignInStates {
  const SignInOtpLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignInOtpLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignInStates.otpLoading()';
  }
}

/// @nodoc

class SignInOtpFailure implements SignInStates {
  const SignInOtpFailure(this.errorMessage);

  final String errorMessage;

  /// Create a copy of SignInStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignInOtpFailureCopyWith<SignInOtpFailure> get copyWith =>
      _$SignInOtpFailureCopyWithImpl<SignInOtpFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignInOtpFailure &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'SignInStates.otpFailure(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $SignInOtpFailureCopyWith<$Res>
    implements $SignInStatesCopyWith<$Res> {
  factory $SignInOtpFailureCopyWith(
          SignInOtpFailure value, $Res Function(SignInOtpFailure) _then) =
      _$SignInOtpFailureCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$SignInOtpFailureCopyWithImpl<$Res>
    implements $SignInOtpFailureCopyWith<$Res> {
  _$SignInOtpFailureCopyWithImpl(this._self, this._then);

  final SignInOtpFailure _self;
  final $Res Function(SignInOtpFailure) _then;

  /// Create a copy of SignInStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(SignInOtpFailure(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SignInOtpSuccess implements SignInStates {
  const SignInOtpSuccess(this.result);

  final bool result;

  /// Create a copy of SignInStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignInOtpSuccessCopyWith<SignInOtpSuccess> get copyWith =>
      _$SignInOtpSuccessCopyWithImpl<SignInOtpSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignInOtpSuccess &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @override
  String toString() {
    return 'SignInStates.otpSuccess(result: $result)';
  }
}

/// @nodoc
abstract mixin class $SignInOtpSuccessCopyWith<$Res>
    implements $SignInStatesCopyWith<$Res> {
  factory $SignInOtpSuccessCopyWith(
          SignInOtpSuccess value, $Res Function(SignInOtpSuccess) _then) =
      _$SignInOtpSuccessCopyWithImpl;
  @useResult
  $Res call({bool result});
}

/// @nodoc
class _$SignInOtpSuccessCopyWithImpl<$Res>
    implements $SignInOtpSuccessCopyWith<$Res> {
  _$SignInOtpSuccessCopyWithImpl(this._self, this._then);

  final SignInOtpSuccess _self;
  final $Res Function(SignInOtpSuccess) _then;

  /// Create a copy of SignInStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? result = null,
  }) {
    return _then(SignInOtpSuccess(
      null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class SignInSuccess implements SignInStates {
  const SignInSuccess(this.result);

  final LoginModel result;

  /// Create a copy of SignInStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignInSuccessCopyWith<SignInSuccess> get copyWith =>
      _$SignInSuccessCopyWithImpl<SignInSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignInSuccess &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @override
  String toString() {
    return 'SignInStates.success(result: $result)';
  }
}

/// @nodoc
abstract mixin class $SignInSuccessCopyWith<$Res>
    implements $SignInStatesCopyWith<$Res> {
  factory $SignInSuccessCopyWith(
          SignInSuccess value, $Res Function(SignInSuccess) _then) =
      _$SignInSuccessCopyWithImpl;
  @useResult
  $Res call({LoginModel result});
}

/// @nodoc
class _$SignInSuccessCopyWithImpl<$Res>
    implements $SignInSuccessCopyWith<$Res> {
  _$SignInSuccessCopyWithImpl(this._self, this._then);

  final SignInSuccess _self;
  final $Res Function(SignInSuccess) _then;

  /// Create a copy of SignInStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? result = null,
  }) {
    return _then(SignInSuccess(
      null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as LoginModel,
    ));
  }
}

/// @nodoc

class SignInFailure implements SignInStates {
  const SignInFailure(this.errorMessage);

  final String errorMessage;

  /// Create a copy of SignInStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignInFailureCopyWith<SignInFailure> get copyWith =>
      _$SignInFailureCopyWithImpl<SignInFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignInFailure &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'SignInStates.failure(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $SignInFailureCopyWith<$Res>
    implements $SignInStatesCopyWith<$Res> {
  factory $SignInFailureCopyWith(
          SignInFailure value, $Res Function(SignInFailure) _then) =
      _$SignInFailureCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$SignInFailureCopyWithImpl<$Res>
    implements $SignInFailureCopyWith<$Res> {
  _$SignInFailureCopyWithImpl(this._self, this._then);

  final SignInFailure _self;
  final $Res Function(SignInFailure) _then;

  /// Create a copy of SignInStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(SignInFailure(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
