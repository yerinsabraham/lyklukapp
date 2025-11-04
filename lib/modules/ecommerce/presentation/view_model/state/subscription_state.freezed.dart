// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SubscriptionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() updatingSubscription,
    required TResult Function(Map<String, dynamic> subscription, String message)
    updatedSubscription,
    required TResult Function(String message) updatingSubscriptionFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? updatingSubscription,
    TResult? Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult? Function(String message)? updatingSubscriptionFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? updatingSubscription,
    TResult Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult Function(String message)? updatingSubscriptionFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionInitial value) initial,
    required TResult Function(SubscriptionUpdating value) updatingSubscription,
    required TResult Function(SubscriptionUpdated value) updatedSubscription,
    required TResult Function(SubscriptionUpdatingFailed value)
    updatingSubscriptionFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionInitial value)? initial,
    TResult? Function(SubscriptionUpdating value)? updatingSubscription,
    TResult? Function(SubscriptionUpdated value)? updatedSubscription,
    TResult? Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionInitial value)? initial,
    TResult Function(SubscriptionUpdating value)? updatingSubscription,
    TResult Function(SubscriptionUpdated value)? updatedSubscription,
    TResult Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateCopyWith(
    SubscriptionState value,
    $Res Function(SubscriptionState) then,
  ) = _$SubscriptionStateCopyWithImpl<$Res, SubscriptionState>;
}

/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res, $Val extends SubscriptionState>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SubscriptionInitialImplCopyWith<$Res> {
  factory _$$SubscriptionInitialImplCopyWith(
    _$SubscriptionInitialImpl value,
    $Res Function(_$SubscriptionInitialImpl) then,
  ) = __$$SubscriptionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubscriptionInitialImplCopyWithImpl<$Res>
    extends _$SubscriptionStateCopyWithImpl<$Res, _$SubscriptionInitialImpl>
    implements _$$SubscriptionInitialImplCopyWith<$Res> {
  __$$SubscriptionInitialImplCopyWithImpl(
    _$SubscriptionInitialImpl _value,
    $Res Function(_$SubscriptionInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubscriptionInitialImpl implements SubscriptionInitial {
  const _$SubscriptionInitialImpl();

  @override
  String toString() {
    return 'SubscriptionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() updatingSubscription,
    required TResult Function(Map<String, dynamic> subscription, String message)
    updatedSubscription,
    required TResult Function(String message) updatingSubscriptionFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? updatingSubscription,
    TResult? Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult? Function(String message)? updatingSubscriptionFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? updatingSubscription,
    TResult Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult Function(String message)? updatingSubscriptionFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionInitial value) initial,
    required TResult Function(SubscriptionUpdating value) updatingSubscription,
    required TResult Function(SubscriptionUpdated value) updatedSubscription,
    required TResult Function(SubscriptionUpdatingFailed value)
    updatingSubscriptionFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionInitial value)? initial,
    TResult? Function(SubscriptionUpdating value)? updatingSubscription,
    TResult? Function(SubscriptionUpdated value)? updatedSubscription,
    TResult? Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionInitial value)? initial,
    TResult Function(SubscriptionUpdating value)? updatingSubscription,
    TResult Function(SubscriptionUpdated value)? updatedSubscription,
    TResult Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SubscriptionInitial implements SubscriptionState {
  const factory SubscriptionInitial() = _$SubscriptionInitialImpl;
}

/// @nodoc
abstract class _$$SubscriptionUpdatingImplCopyWith<$Res> {
  factory _$$SubscriptionUpdatingImplCopyWith(
    _$SubscriptionUpdatingImpl value,
    $Res Function(_$SubscriptionUpdatingImpl) then,
  ) = __$$SubscriptionUpdatingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubscriptionUpdatingImplCopyWithImpl<$Res>
    extends _$SubscriptionStateCopyWithImpl<$Res, _$SubscriptionUpdatingImpl>
    implements _$$SubscriptionUpdatingImplCopyWith<$Res> {
  __$$SubscriptionUpdatingImplCopyWithImpl(
    _$SubscriptionUpdatingImpl _value,
    $Res Function(_$SubscriptionUpdatingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubscriptionUpdatingImpl implements SubscriptionUpdating {
  const _$SubscriptionUpdatingImpl();

  @override
  String toString() {
    return 'SubscriptionState.updatingSubscription()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionUpdatingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() updatingSubscription,
    required TResult Function(Map<String, dynamic> subscription, String message)
    updatedSubscription,
    required TResult Function(String message) updatingSubscriptionFailed,
  }) {
    return updatingSubscription();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? updatingSubscription,
    TResult? Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult? Function(String message)? updatingSubscriptionFailed,
  }) {
    return updatingSubscription?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? updatingSubscription,
    TResult Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult Function(String message)? updatingSubscriptionFailed,
    required TResult orElse(),
  }) {
    if (updatingSubscription != null) {
      return updatingSubscription();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionInitial value) initial,
    required TResult Function(SubscriptionUpdating value) updatingSubscription,
    required TResult Function(SubscriptionUpdated value) updatedSubscription,
    required TResult Function(SubscriptionUpdatingFailed value)
    updatingSubscriptionFailed,
  }) {
    return updatingSubscription(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionInitial value)? initial,
    TResult? Function(SubscriptionUpdating value)? updatingSubscription,
    TResult? Function(SubscriptionUpdated value)? updatedSubscription,
    TResult? Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
  }) {
    return updatingSubscription?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionInitial value)? initial,
    TResult Function(SubscriptionUpdating value)? updatingSubscription,
    TResult Function(SubscriptionUpdated value)? updatedSubscription,
    TResult Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
    required TResult orElse(),
  }) {
    if (updatingSubscription != null) {
      return updatingSubscription(this);
    }
    return orElse();
  }
}

abstract class SubscriptionUpdating implements SubscriptionState {
  const factory SubscriptionUpdating() = _$SubscriptionUpdatingImpl;
}

/// @nodoc
abstract class _$$SubscriptionUpdatedImplCopyWith<$Res> {
  factory _$$SubscriptionUpdatedImplCopyWith(
    _$SubscriptionUpdatedImpl value,
    $Res Function(_$SubscriptionUpdatedImpl) then,
  ) = __$$SubscriptionUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> subscription, String message});
}

/// @nodoc
class __$$SubscriptionUpdatedImplCopyWithImpl<$Res>
    extends _$SubscriptionStateCopyWithImpl<$Res, _$SubscriptionUpdatedImpl>
    implements _$$SubscriptionUpdatedImplCopyWith<$Res> {
  __$$SubscriptionUpdatedImplCopyWithImpl(
    _$SubscriptionUpdatedImpl _value,
    $Res Function(_$SubscriptionUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? subscription = null, Object? message = null}) {
    return _then(
      _$SubscriptionUpdatedImpl(
        subscription:
            null == subscription
                ? _value._subscription
                : subscription // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SubscriptionUpdatedImpl implements SubscriptionUpdated {
  const _$SubscriptionUpdatedImpl({
    required final Map<String, dynamic> subscription,
    required this.message,
  }) : _subscription = subscription;

  final Map<String, dynamic> _subscription;
  @override
  Map<String, dynamic> get subscription {
    if (_subscription is EqualUnmodifiableMapView) return _subscription;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_subscription);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'SubscriptionState.updatedSubscription(subscription: $subscription, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._subscription,
              _subscription,
            ) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_subscription),
    message,
  );

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionUpdatedImplCopyWith<_$SubscriptionUpdatedImpl> get copyWith =>
      __$$SubscriptionUpdatedImplCopyWithImpl<_$SubscriptionUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() updatingSubscription,
    required TResult Function(Map<String, dynamic> subscription, String message)
    updatedSubscription,
    required TResult Function(String message) updatingSubscriptionFailed,
  }) {
    return updatedSubscription(subscription, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? updatingSubscription,
    TResult? Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult? Function(String message)? updatingSubscriptionFailed,
  }) {
    return updatedSubscription?.call(subscription, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? updatingSubscription,
    TResult Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult Function(String message)? updatingSubscriptionFailed,
    required TResult orElse(),
  }) {
    if (updatedSubscription != null) {
      return updatedSubscription(subscription, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionInitial value) initial,
    required TResult Function(SubscriptionUpdating value) updatingSubscription,
    required TResult Function(SubscriptionUpdated value) updatedSubscription,
    required TResult Function(SubscriptionUpdatingFailed value)
    updatingSubscriptionFailed,
  }) {
    return updatedSubscription(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionInitial value)? initial,
    TResult? Function(SubscriptionUpdating value)? updatingSubscription,
    TResult? Function(SubscriptionUpdated value)? updatedSubscription,
    TResult? Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
  }) {
    return updatedSubscription?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionInitial value)? initial,
    TResult Function(SubscriptionUpdating value)? updatingSubscription,
    TResult Function(SubscriptionUpdated value)? updatedSubscription,
    TResult Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
    required TResult orElse(),
  }) {
    if (updatedSubscription != null) {
      return updatedSubscription(this);
    }
    return orElse();
  }
}

abstract class SubscriptionUpdated implements SubscriptionState {
  const factory SubscriptionUpdated({
    required final Map<String, dynamic> subscription,
    required final String message,
  }) = _$SubscriptionUpdatedImpl;

  Map<String, dynamic> get subscription;
  String get message;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionUpdatedImplCopyWith<_$SubscriptionUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubscriptionUpdatingFailedImplCopyWith<$Res> {
  factory _$$SubscriptionUpdatingFailedImplCopyWith(
    _$SubscriptionUpdatingFailedImpl value,
    $Res Function(_$SubscriptionUpdatingFailedImpl) then,
  ) = __$$SubscriptionUpdatingFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SubscriptionUpdatingFailedImplCopyWithImpl<$Res>
    extends
        _$SubscriptionStateCopyWithImpl<$Res, _$SubscriptionUpdatingFailedImpl>
    implements _$$SubscriptionUpdatingFailedImplCopyWith<$Res> {
  __$$SubscriptionUpdatingFailedImplCopyWithImpl(
    _$SubscriptionUpdatingFailedImpl _value,
    $Res Function(_$SubscriptionUpdatingFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$SubscriptionUpdatingFailedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$SubscriptionUpdatingFailedImpl implements SubscriptionUpdatingFailed {
  const _$SubscriptionUpdatingFailedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SubscriptionState.updatingSubscriptionFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionUpdatingFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionUpdatingFailedImplCopyWith<_$SubscriptionUpdatingFailedImpl>
  get copyWith => __$$SubscriptionUpdatingFailedImplCopyWithImpl<
    _$SubscriptionUpdatingFailedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() updatingSubscription,
    required TResult Function(Map<String, dynamic> subscription, String message)
    updatedSubscription,
    required TResult Function(String message) updatingSubscriptionFailed,
  }) {
    return updatingSubscriptionFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? updatingSubscription,
    TResult? Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult? Function(String message)? updatingSubscriptionFailed,
  }) {
    return updatingSubscriptionFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? updatingSubscription,
    TResult Function(Map<String, dynamic> subscription, String message)?
    updatedSubscription,
    TResult Function(String message)? updatingSubscriptionFailed,
    required TResult orElse(),
  }) {
    if (updatingSubscriptionFailed != null) {
      return updatingSubscriptionFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionInitial value) initial,
    required TResult Function(SubscriptionUpdating value) updatingSubscription,
    required TResult Function(SubscriptionUpdated value) updatedSubscription,
    required TResult Function(SubscriptionUpdatingFailed value)
    updatingSubscriptionFailed,
  }) {
    return updatingSubscriptionFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionInitial value)? initial,
    TResult? Function(SubscriptionUpdating value)? updatingSubscription,
    TResult? Function(SubscriptionUpdated value)? updatedSubscription,
    TResult? Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
  }) {
    return updatingSubscriptionFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionInitial value)? initial,
    TResult Function(SubscriptionUpdating value)? updatingSubscription,
    TResult Function(SubscriptionUpdated value)? updatedSubscription,
    TResult Function(SubscriptionUpdatingFailed value)?
    updatingSubscriptionFailed,
    required TResult orElse(),
  }) {
    if (updatingSubscriptionFailed != null) {
      return updatingSubscriptionFailed(this);
    }
    return orElse();
  }
}

abstract class SubscriptionUpdatingFailed implements SubscriptionState {
  const factory SubscriptionUpdatingFailed(final String message) =
      _$SubscriptionUpdatingFailedImpl;

  String get message;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionUpdatingFailedImplCopyWith<_$SubscriptionUpdatingFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
