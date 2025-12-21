// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verfy_login_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerfyLoginStates {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is VerfyLoginStates);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'VerfyLoginStates()';
  }
}

/// @nodoc
class $VerfyLoginStatesCopyWith<$Res> {
  $VerfyLoginStatesCopyWith(
      VerfyLoginStates _, $Res Function(VerfyLoginStates) __);
}

/// Adds pattern-matching-related methods to [VerfyLoginStates].
extension VerfyLoginStatesPatterns on VerfyLoginStates {
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
    TResult Function(VerfyLoginInitial value)? initial,
    TResult Function(VerfyLoginLoading value)? loading,
    TResult Function(VerfyLoginFailure value)? failure,
    TResult Function(VerfyLoginSuccess value)? success,
    TResult Function(ClearText value)? clearText,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case VerfyLoginInitial() when initial != null:
        return initial(_that);
      case VerfyLoginLoading() when loading != null:
        return loading(_that);
      case VerfyLoginFailure() when failure != null:
        return failure(_that);
      case VerfyLoginSuccess() when success != null:
        return success(_that);
      case ClearText() when clearText != null:
        return clearText(_that);
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
    required TResult Function(VerfyLoginInitial value) initial,
    required TResult Function(VerfyLoginLoading value) loading,
    required TResult Function(VerfyLoginFailure value) failure,
    required TResult Function(VerfyLoginSuccess value) success,
    required TResult Function(ClearText value) clearText,
  }) {
    final _that = this;
    switch (_that) {
      case VerfyLoginInitial():
        return initial(_that);
      case VerfyLoginLoading():
        return loading(_that);
      case VerfyLoginFailure():
        return failure(_that);
      case VerfyLoginSuccess():
        return success(_that);
      case ClearText():
        return clearText(_that);
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
    TResult? Function(VerfyLoginInitial value)? initial,
    TResult? Function(VerfyLoginLoading value)? loading,
    TResult? Function(VerfyLoginFailure value)? failure,
    TResult? Function(VerfyLoginSuccess value)? success,
    TResult? Function(ClearText value)? clearText,
  }) {
    final _that = this;
    switch (_that) {
      case VerfyLoginInitial() when initial != null:
        return initial(_that);
      case VerfyLoginLoading() when loading != null:
        return loading(_that);
      case VerfyLoginFailure() when failure != null:
        return failure(_that);
      case VerfyLoginSuccess() when success != null:
        return success(_that);
      case ClearText() when clearText != null:
        return clearText(_that);
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
    TResult Function(String errorMessage)? failure,
    TResult Function(bool result)? success,
    TResult Function()? clearText,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case VerfyLoginInitial() when initial != null:
        return initial();
      case VerfyLoginLoading() when loading != null:
        return loading();
      case VerfyLoginFailure() when failure != null:
        return failure(_that.errorMessage);
      case VerfyLoginSuccess() when success != null:
        return success(_that.result);
      case ClearText() when clearText != null:
        return clearText();
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
    required TResult Function(String errorMessage) failure,
    required TResult Function(bool result) success,
    required TResult Function() clearText,
  }) {
    final _that = this;
    switch (_that) {
      case VerfyLoginInitial():
        return initial();
      case VerfyLoginLoading():
        return loading();
      case VerfyLoginFailure():
        return failure(_that.errorMessage);
      case VerfyLoginSuccess():
        return success(_that.result);
      case ClearText():
        return clearText();
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
    TResult? Function(String errorMessage)? failure,
    TResult? Function(bool result)? success,
    TResult? Function()? clearText,
  }) {
    final _that = this;
    switch (_that) {
      case VerfyLoginInitial() when initial != null:
        return initial();
      case VerfyLoginLoading() when loading != null:
        return loading();
      case VerfyLoginFailure() when failure != null:
        return failure(_that.errorMessage);
      case VerfyLoginSuccess() when success != null:
        return success(_that.result);
      case ClearText() when clearText != null:
        return clearText();
      case _:
        return null;
    }
  }
}

/// @nodoc

class VerfyLoginInitial implements VerfyLoginStates {
  const VerfyLoginInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is VerfyLoginInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'VerfyLoginStates.initial()';
  }
}

/// @nodoc

class VerfyLoginLoading implements VerfyLoginStates {
  const VerfyLoginLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is VerfyLoginLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'VerfyLoginStates.loading()';
  }
}

/// @nodoc

class VerfyLoginFailure implements VerfyLoginStates {
  const VerfyLoginFailure(this.errorMessage);

  final String errorMessage;

  /// Create a copy of VerfyLoginStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VerfyLoginFailureCopyWith<VerfyLoginFailure> get copyWith =>
      _$VerfyLoginFailureCopyWithImpl<VerfyLoginFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VerfyLoginFailure &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'VerfyLoginStates.failure(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $VerfyLoginFailureCopyWith<$Res>
    implements $VerfyLoginStatesCopyWith<$Res> {
  factory $VerfyLoginFailureCopyWith(
          VerfyLoginFailure value, $Res Function(VerfyLoginFailure) _then) =
      _$VerfyLoginFailureCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$VerfyLoginFailureCopyWithImpl<$Res>
    implements $VerfyLoginFailureCopyWith<$Res> {
  _$VerfyLoginFailureCopyWithImpl(this._self, this._then);

  final VerfyLoginFailure _self;
  final $Res Function(VerfyLoginFailure) _then;

  /// Create a copy of VerfyLoginStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(VerfyLoginFailure(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class VerfyLoginSuccess implements VerfyLoginStates {
  const VerfyLoginSuccess(this.result);

  final bool result;

  /// Create a copy of VerfyLoginStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VerfyLoginSuccessCopyWith<VerfyLoginSuccess> get copyWith =>
      _$VerfyLoginSuccessCopyWithImpl<VerfyLoginSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VerfyLoginSuccess &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @override
  String toString() {
    return 'VerfyLoginStates.success(result: $result)';
  }
}

/// @nodoc
abstract mixin class $VerfyLoginSuccessCopyWith<$Res>
    implements $VerfyLoginStatesCopyWith<$Res> {
  factory $VerfyLoginSuccessCopyWith(
          VerfyLoginSuccess value, $Res Function(VerfyLoginSuccess) _then) =
      _$VerfyLoginSuccessCopyWithImpl;
  @useResult
  $Res call({bool result});
}

/// @nodoc
class _$VerfyLoginSuccessCopyWithImpl<$Res>
    implements $VerfyLoginSuccessCopyWith<$Res> {
  _$VerfyLoginSuccessCopyWithImpl(this._self, this._then);

  final VerfyLoginSuccess _self;
  final $Res Function(VerfyLoginSuccess) _then;

  /// Create a copy of VerfyLoginStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? result = null,
  }) {
    return _then(VerfyLoginSuccess(
      null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class ClearText implements VerfyLoginStates {
  const ClearText();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ClearText);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'VerfyLoginStates.clearText()';
  }
}

// dart format on
