// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CommentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentStateCopyWith<$Res> {
  factory $CommentStateCopyWith(
    CommentState value,
    $Res Function(CommentState) then,
  ) = _$CommentStateCopyWithImpl<$Res, CommentState>;
}

/// @nodoc
class _$CommentStateCopyWithImpl<$Res, $Val extends CommentState>
    implements $CommentStateCopyWith<$Res> {
  _$CommentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CommentStateInitialImplCopyWith<$Res> {
  factory _$$CommentStateInitialImplCopyWith(
    _$CommentStateInitialImpl value,
    $Res Function(_$CommentStateInitialImpl) then,
  ) = __$$CommentStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CommentStateInitialImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$CommentStateInitialImpl>
    implements _$$CommentStateInitialImplCopyWith<$Res> {
  __$$CommentStateInitialImplCopyWithImpl(
    _$CommentStateInitialImpl _value,
    $Res Function(_$CommentStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CommentStateInitialImpl implements CommentStateInitial {
  const _$CommentStateInitialImpl();

  @override
  String toString() {
    return 'CommentState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
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
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CommentStateInitial implements CommentState {
  const factory CommentStateInitial() = _$CommentStateInitialImpl;
}

/// @nodoc
abstract class _$$SendingCommentImplCopyWith<$Res> {
  factory _$$SendingCommentImplCopyWith(
    _$SendingCommentImpl value,
    $Res Function(_$SendingCommentImpl) then,
  ) = __$$SendingCommentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SendingCommentImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$SendingCommentImpl>
    implements _$$SendingCommentImplCopyWith<$Res> {
  __$$SendingCommentImplCopyWithImpl(
    _$SendingCommentImpl _value,
    $Res Function(_$SendingCommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SendingCommentImpl implements SendingComment {
  const _$SendingCommentImpl();

  @override
  String toString() {
    return 'CommentState.sending()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SendingCommentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return sending();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return sending?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return sending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class SendingComment implements CommentState {
  const factory SendingComment() = _$SendingCommentImpl;
}

/// @nodoc
abstract class _$$SentCommentImplCopyWith<$Res> {
  factory _$$SentCommentImplCopyWith(
    _$SentCommentImpl value,
    $Res Function(_$SentCommentImpl) then,
  ) = __$$SentCommentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, CommentModel comment});
}

/// @nodoc
class __$$SentCommentImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$SentCommentImpl>
    implements _$$SentCommentImplCopyWith<$Res> {
  __$$SentCommentImplCopyWithImpl(
    _$SentCommentImpl _value,
    $Res Function(_$SentCommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? comment = null}) {
    return _then(
      _$SentCommentImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        comment:
            null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                    as CommentModel,
      ),
    );
  }
}

/// @nodoc

class _$SentCommentImpl implements SentComment {
  const _$SentCommentImpl({required this.message, required this.comment});

  @override
  final String message;
  @override
  final CommentModel comment;

  @override
  String toString() {
    return 'CommentState.sent(message: $message, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentCommentImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, comment);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentCommentImplCopyWith<_$SentCommentImpl> get copyWith =>
      __$$SentCommentImplCopyWithImpl<_$SentCommentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return sent(message, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return sent?.call(message, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(message, comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return sent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }
}

abstract class SentComment implements CommentState {
  const factory SentComment({
    required final String message,
    required final CommentModel comment,
  }) = _$SentCommentImpl;

  String get message;
  CommentModel get comment;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentCommentImplCopyWith<_$SentCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendingCommentFailedImplCopyWith<$Res> {
  factory _$$SendingCommentFailedImplCopyWith(
    _$SendingCommentFailedImpl value,
    $Res Function(_$SendingCommentFailedImpl) then,
  ) = __$$SendingCommentFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SendingCommentFailedImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$SendingCommentFailedImpl>
    implements _$$SendingCommentFailedImplCopyWith<$Res> {
  __$$SendingCommentFailedImplCopyWithImpl(
    _$SendingCommentFailedImpl _value,
    $Res Function(_$SendingCommentFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$SendingCommentFailedImpl(
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

class _$SendingCommentFailedImpl implements SendingCommentFailed {
  const _$SendingCommentFailedImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CommentState.sendingFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendingCommentFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendingCommentFailedImplCopyWith<_$SendingCommentFailedImpl>
  get copyWith =>
      __$$SendingCommentFailedImplCopyWithImpl<_$SendingCommentFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return sendingFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return sendingFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (sendingFailed != null) {
      return sendingFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return sendingFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return sendingFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (sendingFailed != null) {
      return sendingFailed(this);
    }
    return orElse();
  }
}

abstract class SendingCommentFailed implements CommentState {
  const factory SendingCommentFailed({required final String message}) =
      _$SendingCommentFailedImpl;

  String get message;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendingCommentFailedImplCopyWith<_$SendingCommentFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LikeSucessImplCopyWith<$Res> {
  factory _$$LikeSucessImplCopyWith(
    _$LikeSucessImpl value,
    $Res Function(_$LikeSucessImpl) then,
  ) = __$$LikeSucessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, CommentModel comment});
}

/// @nodoc
class __$$LikeSucessImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$LikeSucessImpl>
    implements _$$LikeSucessImplCopyWith<$Res> {
  __$$LikeSucessImplCopyWithImpl(
    _$LikeSucessImpl _value,
    $Res Function(_$LikeSucessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? comment = null}) {
    return _then(
      _$LikeSucessImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        comment:
            null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                    as CommentModel,
      ),
    );
  }
}

/// @nodoc

class _$LikeSucessImpl implements LikeSucess {
  const _$LikeSucessImpl({required this.message, required this.comment});

  @override
  final String message;
  @override
  final CommentModel comment;

  @override
  String toString() {
    return 'CommentState.likeSucess(message: $message, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikeSucessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, comment);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LikeSucessImplCopyWith<_$LikeSucessImpl> get copyWith =>
      __$$LikeSucessImplCopyWithImpl<_$LikeSucessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return likeSucess(message, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return likeSucess?.call(message, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (likeSucess != null) {
      return likeSucess(message, comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return likeSucess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return likeSucess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (likeSucess != null) {
      return likeSucess(this);
    }
    return orElse();
  }
}

abstract class LikeSucess implements CommentState {
  const factory LikeSucess({
    required final String message,
    required final CommentModel comment,
  }) = _$LikeSucessImpl;

  String get message;
  CommentModel get comment;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LikeSucessImplCopyWith<_$LikeSucessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LikeFailedImplCopyWith<$Res> {
  factory _$$LikeFailedImplCopyWith(
    _$LikeFailedImpl value,
    $Res Function(_$LikeFailedImpl) then,
  ) = __$$LikeFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, CommentModel comment});
}

/// @nodoc
class __$$LikeFailedImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$LikeFailedImpl>
    implements _$$LikeFailedImplCopyWith<$Res> {
  __$$LikeFailedImplCopyWithImpl(
    _$LikeFailedImpl _value,
    $Res Function(_$LikeFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? comment = null}) {
    return _then(
      _$LikeFailedImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        comment:
            null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                    as CommentModel,
      ),
    );
  }
}

/// @nodoc

class _$LikeFailedImpl implements LikeFailed {
  const _$LikeFailedImpl({required this.message, required this.comment});

  @override
  final String message;
  @override
  final CommentModel comment;

  @override
  String toString() {
    return 'CommentState.likeFailed(message: $message, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikeFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, comment);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LikeFailedImplCopyWith<_$LikeFailedImpl> get copyWith =>
      __$$LikeFailedImplCopyWithImpl<_$LikeFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return likeFailed(message, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return likeFailed?.call(message, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (likeFailed != null) {
      return likeFailed(message, comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return likeFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return likeFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (likeFailed != null) {
      return likeFailed(this);
    }
    return orElse();
  }
}

abstract class LikeFailed implements CommentState {
  const factory LikeFailed({
    required final String message,
    required final CommentModel comment,
  }) = _$LikeFailedImpl;

  String get message;
  CommentModel get comment;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LikeFailedImplCopyWith<_$LikeFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReplyingCommentImplCopyWith<$Res> {
  factory _$$ReplyingCommentImplCopyWith(
    _$ReplyingCommentImpl value,
    $Res Function(_$ReplyingCommentImpl) then,
  ) = __$$ReplyingCommentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReplyingCommentImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$ReplyingCommentImpl>
    implements _$$ReplyingCommentImplCopyWith<$Res> {
  __$$ReplyingCommentImplCopyWithImpl(
    _$ReplyingCommentImpl _value,
    $Res Function(_$ReplyingCommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReplyingCommentImpl implements ReplyingComment {
  const _$ReplyingCommentImpl();

  @override
  String toString() {
    return 'CommentState.replying()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReplyingCommentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return replying();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return replying?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (replying != null) {
      return replying();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return replying(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return replying?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (replying != null) {
      return replying(this);
    }
    return orElse();
  }
}

abstract class ReplyingComment implements CommentState {
  const factory ReplyingComment() = _$ReplyingCommentImpl;
}

/// @nodoc
abstract class _$$RepliedCommentImplCopyWith<$Res> {
  factory _$$RepliedCommentImplCopyWith(
    _$RepliedCommentImpl value,
    $Res Function(_$RepliedCommentImpl) then,
  ) = __$$RepliedCommentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, CommentModel comment, String replyToId});
}

/// @nodoc
class __$$RepliedCommentImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$RepliedCommentImpl>
    implements _$$RepliedCommentImplCopyWith<$Res> {
  __$$RepliedCommentImplCopyWithImpl(
    _$RepliedCommentImpl _value,
    $Res Function(_$RepliedCommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? comment = null,
    Object? replyToId = null,
  }) {
    return _then(
      _$RepliedCommentImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        comment:
            null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                    as CommentModel,
        replyToId:
            null == replyToId
                ? _value.replyToId
                : replyToId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$RepliedCommentImpl implements RepliedComment {
  const _$RepliedCommentImpl({
    required this.message,
    required this.comment,
    required this.replyToId,
  });

  @override
  final String message;
  @override
  final CommentModel comment;
  @override
  final String replyToId;

  @override
  String toString() {
    return 'CommentState.replied(message: $message, comment: $comment, replyToId: $replyToId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepliedCommentImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.replyToId, replyToId) ||
                other.replyToId == replyToId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, comment, replyToId);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepliedCommentImplCopyWith<_$RepliedCommentImpl> get copyWith =>
      __$$RepliedCommentImplCopyWithImpl<_$RepliedCommentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return replied(message, comment, replyToId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return replied?.call(message, comment, replyToId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (replied != null) {
      return replied(message, comment, replyToId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return replied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return replied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (replied != null) {
      return replied(this);
    }
    return orElse();
  }
}

abstract class RepliedComment implements CommentState {
  const factory RepliedComment({
    required final String message,
    required final CommentModel comment,
    required final String replyToId,
  }) = _$RepliedCommentImpl;

  String get message;
  CommentModel get comment;
  String get replyToId;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepliedCommentImplCopyWith<_$RepliedCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReplyingCommentFailedImplCopyWith<$Res> {
  factory _$$ReplyingCommentFailedImplCopyWith(
    _$ReplyingCommentFailedImpl value,
    $Res Function(_$ReplyingCommentFailedImpl) then,
  ) = __$$ReplyingCommentFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ReplyingCommentFailedImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$ReplyingCommentFailedImpl>
    implements _$$ReplyingCommentFailedImplCopyWith<$Res> {
  __$$ReplyingCommentFailedImplCopyWithImpl(
    _$ReplyingCommentFailedImpl _value,
    $Res Function(_$ReplyingCommentFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ReplyingCommentFailedImpl(
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

class _$ReplyingCommentFailedImpl implements ReplyingCommentFailed {
  const _$ReplyingCommentFailedImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CommentState.replyingCommentFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyingCommentFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyingCommentFailedImplCopyWith<_$ReplyingCommentFailedImpl>
  get copyWith =>
      __$$ReplyingCommentFailedImplCopyWithImpl<_$ReplyingCommentFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sending,
    required TResult Function(String message, CommentModel comment) sent,
    required TResult Function(String message) sendingFailed,
    required TResult Function(String message, CommentModel comment) likeSucess,
    required TResult Function(String message, CommentModel comment) likeFailed,
    required TResult Function() replying,
    required TResult Function(
      String message,
      CommentModel comment,
      String replyToId,
    )
    replied,
    required TResult Function(String message) replyingCommentFailed,
  }) {
    return replyingCommentFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sending,
    TResult? Function(String message, CommentModel comment)? sent,
    TResult? Function(String message)? sendingFailed,
    TResult? Function(String message, CommentModel comment)? likeSucess,
    TResult? Function(String message, CommentModel comment)? likeFailed,
    TResult? Function()? replying,
    TResult? Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult? Function(String message)? replyingCommentFailed,
  }) {
    return replyingCommentFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sending,
    TResult Function(String message, CommentModel comment)? sent,
    TResult Function(String message)? sendingFailed,
    TResult Function(String message, CommentModel comment)? likeSucess,
    TResult Function(String message, CommentModel comment)? likeFailed,
    TResult Function()? replying,
    TResult Function(String message, CommentModel comment, String replyToId)?
    replied,
    TResult Function(String message)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (replyingCommentFailed != null) {
      return replyingCommentFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentStateInitial value) initial,
    required TResult Function(SendingComment value) sending,
    required TResult Function(SentComment value) sent,
    required TResult Function(SendingCommentFailed value) sendingFailed,
    required TResult Function(LikeSucess value) likeSucess,
    required TResult Function(LikeFailed value) likeFailed,
    required TResult Function(ReplyingComment value) replying,
    required TResult Function(RepliedComment value) replied,
    required TResult Function(ReplyingCommentFailed value)
    replyingCommentFailed,
  }) {
    return replyingCommentFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentStateInitial value)? initial,
    TResult? Function(SendingComment value)? sending,
    TResult? Function(SentComment value)? sent,
    TResult? Function(SendingCommentFailed value)? sendingFailed,
    TResult? Function(LikeSucess value)? likeSucess,
    TResult? Function(LikeFailed value)? likeFailed,
    TResult? Function(ReplyingComment value)? replying,
    TResult? Function(RepliedComment value)? replied,
    TResult? Function(ReplyingCommentFailed value)? replyingCommentFailed,
  }) {
    return replyingCommentFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentStateInitial value)? initial,
    TResult Function(SendingComment value)? sending,
    TResult Function(SentComment value)? sent,
    TResult Function(SendingCommentFailed value)? sendingFailed,
    TResult Function(LikeSucess value)? likeSucess,
    TResult Function(LikeFailed value)? likeFailed,
    TResult Function(ReplyingComment value)? replying,
    TResult Function(RepliedComment value)? replied,
    TResult Function(ReplyingCommentFailed value)? replyingCommentFailed,
    required TResult orElse(),
  }) {
    if (replyingCommentFailed != null) {
      return replyingCommentFailed(this);
    }
    return orElse();
  }
}

abstract class ReplyingCommentFailed implements CommentState {
  const factory ReplyingCommentFailed({required final String message}) =
      _$ReplyingCommentFailedImpl;

  String get message;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReplyingCommentFailedImplCopyWith<_$ReplyingCommentFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
