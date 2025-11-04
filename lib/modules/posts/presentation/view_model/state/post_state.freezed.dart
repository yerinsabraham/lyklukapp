// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PostState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostStateCopyWith<$Res> {
  factory $PostStateCopyWith(PostState value, $Res Function(PostState) then) =
      _$PostStateCopyWithImpl<$Res, PostState>;
}

/// @nodoc
class _$PostStateCopyWithImpl<$Res, $Val extends PostState>
    implements $PostStateCopyWith<$Res> {
  _$PostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PostInitialImplCopyWith<$Res> {
  factory _$$PostInitialImplCopyWith(
    _$PostInitialImpl value,
    $Res Function(_$PostInitialImpl) then,
  ) = __$$PostInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostInitialImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostInitialImpl>
    implements _$$PostInitialImplCopyWith<$Res> {
  __$$PostInitialImplCopyWithImpl(
    _$PostInitialImpl _value,
    $Res Function(_$PostInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PostInitialImpl implements PostInitial {
  const _$PostInitialImpl();

  @override
  String toString() {
    return 'PostState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PostInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
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
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PostInitial implements PostState {
  const factory PostInitial() = _$PostInitialImpl;
}

/// @nodoc
abstract class _$$PostUploadingImplCopyWith<$Res> {
  factory _$$PostUploadingImplCopyWith(
    _$PostUploadingImpl value,
    $Res Function(_$PostUploadingImpl) then,
  ) = __$$PostUploadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double progress});
}

/// @nodoc
class __$$PostUploadingImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostUploadingImpl>
    implements _$$PostUploadingImplCopyWith<$Res> {
  __$$PostUploadingImplCopyWithImpl(
    _$PostUploadingImpl _value,
    $Res Function(_$PostUploadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? progress = null}) {
    return _then(
      _$PostUploadingImpl(
        progress:
            null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _$PostUploadingImpl implements PostUploading {
  const _$PostUploadingImpl({this.progress = 0.0});

  @override
  @JsonKey()
  final double progress;

  @override
  String toString() {
    return 'PostState.uploading(progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostUploadingImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostUploadingImplCopyWith<_$PostUploadingImpl> get copyWith =>
      __$$PostUploadingImplCopyWithImpl<_$PostUploadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return uploading(progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return uploading?.call(progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (uploading != null) {
      return uploading(progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return uploading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return uploading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (uploading != null) {
      return uploading(this);
    }
    return orElse();
  }
}

abstract class PostUploading implements PostState {
  const factory PostUploading({final double progress}) = _$PostUploadingImpl;

  double get progress;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostUploadingImplCopyWith<_$PostUploadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostUploadedImplCopyWith<$Res> {
  factory _$$PostUploadedImplCopyWith(
    _$PostUploadedImpl value,
    $Res Function(_$PostUploadedImpl) then,
  ) = __$$PostUploadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> post});
}

/// @nodoc
class __$$PostUploadedImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostUploadedImpl>
    implements _$$PostUploadedImplCopyWith<$Res> {
  __$$PostUploadedImplCopyWithImpl(
    _$PostUploadedImpl _value,
    $Res Function(_$PostUploadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = null}) {
    return _then(
      _$PostUploadedImpl(
        post:
            null == post
                ? _value._post
                : post // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$PostUploadedImpl implements PostUploaded {
  const _$PostUploadedImpl({required final Map<String, dynamic> post})
    : _post = post;

  final Map<String, dynamic> _post;
  @override
  Map<String, dynamic> get post {
    if (_post is EqualUnmodifiableMapView) return _post;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_post);
  }

  @override
  String toString() {
    return 'PostState.uploaded(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostUploadedImpl &&
            const DeepCollectionEquality().equals(other._post, _post));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_post));

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostUploadedImplCopyWith<_$PostUploadedImpl> get copyWith =>
      __$$PostUploadedImplCopyWithImpl<_$PostUploadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return uploaded(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return uploaded?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (uploaded != null) {
      return uploaded(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return uploaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return uploaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (uploaded != null) {
      return uploaded(this);
    }
    return orElse();
  }
}

abstract class PostUploaded implements PostState {
  const factory PostUploaded({required final Map<String, dynamic> post}) =
      _$PostUploadedImpl;

  Map<String, dynamic> get post;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostUploadedImplCopyWith<_$PostUploadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostUploadErrorImplCopyWith<$Res> {
  factory _$$PostUploadErrorImplCopyWith(
    _$PostUploadErrorImpl value,
    $Res Function(_$PostUploadErrorImpl) then,
  ) = __$$PostUploadErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PostUploadErrorImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostUploadErrorImpl>
    implements _$$PostUploadErrorImplCopyWith<$Res> {
  __$$PostUploadErrorImplCopyWithImpl(
    _$PostUploadErrorImpl _value,
    $Res Function(_$PostUploadErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$PostUploadErrorImpl(
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

class _$PostUploadErrorImpl implements PostUploadError {
  const _$PostUploadErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'PostState.uploadError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostUploadErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostUploadErrorImplCopyWith<_$PostUploadErrorImpl> get copyWith =>
      __$$PostUploadErrorImplCopyWithImpl<_$PostUploadErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return uploadError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return uploadError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (uploadError != null) {
      return uploadError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return uploadError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return uploadError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (uploadError != null) {
      return uploadError(this);
    }
    return orElse();
  }
}

abstract class PostUploadError implements PostState {
  const factory PostUploadError({required final String message}) =
      _$PostUploadErrorImpl;

  String get message;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostUploadErrorImplCopyWith<_$PostUploadErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostLikedImplCopyWith<$Res> {
  factory _$$PostLikedImplCopyWith(
    _$PostLikedImpl value,
    $Res Function(_$PostLikedImpl) then,
  ) = __$$PostLikedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostModel post});
}

/// @nodoc
class __$$PostLikedImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostLikedImpl>
    implements _$$PostLikedImplCopyWith<$Res> {
  __$$PostLikedImplCopyWithImpl(
    _$PostLikedImpl _value,
    $Res Function(_$PostLikedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = null}) {
    return _then(
      _$PostLikedImpl(
        post:
            null == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                    as PostModel,
      ),
    );
  }
}

/// @nodoc

class _$PostLikedImpl implements PostLiked {
  const _$PostLikedImpl({required this.post});

  @override
  final PostModel post;

  @override
  String toString() {
    return 'PostState.liked(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostLikedImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostLikedImplCopyWith<_$PostLikedImpl> get copyWith =>
      __$$PostLikedImplCopyWithImpl<_$PostLikedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return liked(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return liked?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (liked != null) {
      return liked(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return liked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return liked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (liked != null) {
      return liked(this);
    }
    return orElse();
  }
}

abstract class PostLiked implements PostState {
  const factory PostLiked({required final PostModel post}) = _$PostLikedImpl;

  PostModel get post;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostLikedImplCopyWith<_$PostLikedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostUnlikedImplCopyWith<$Res> {
  factory _$$PostUnlikedImplCopyWith(
    _$PostUnlikedImpl value,
    $Res Function(_$PostUnlikedImpl) then,
  ) = __$$PostUnlikedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostModel post});
}

/// @nodoc
class __$$PostUnlikedImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostUnlikedImpl>
    implements _$$PostUnlikedImplCopyWith<$Res> {
  __$$PostUnlikedImplCopyWithImpl(
    _$PostUnlikedImpl _value,
    $Res Function(_$PostUnlikedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = null}) {
    return _then(
      _$PostUnlikedImpl(
        post:
            null == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                    as PostModel,
      ),
    );
  }
}

/// @nodoc

class _$PostUnlikedImpl implements PostUnliked {
  const _$PostUnlikedImpl({required this.post});

  @override
  final PostModel post;

  @override
  String toString() {
    return 'PostState.unliked(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostUnlikedImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostUnlikedImplCopyWith<_$PostUnlikedImpl> get copyWith =>
      __$$PostUnlikedImplCopyWithImpl<_$PostUnlikedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return unliked(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return unliked?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (unliked != null) {
      return unliked(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return unliked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return unliked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (unliked != null) {
      return unliked(this);
    }
    return orElse();
  }
}

abstract class PostUnliked implements PostState {
  const factory PostUnliked({required final PostModel post}) =
      _$PostUnlikedImpl;

  PostModel get post;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostUnlikedImplCopyWith<_$PostUnlikedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostLikeFailedImplCopyWith<$Res> {
  factory _$$PostLikeFailedImplCopyWith(
    _$PostLikeFailedImpl value,
    $Res Function(_$PostLikeFailedImpl) then,
  ) = __$$PostLikeFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostModel post, String message});
}

/// @nodoc
class __$$PostLikeFailedImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostLikeFailedImpl>
    implements _$$PostLikeFailedImplCopyWith<$Res> {
  __$$PostLikeFailedImplCopyWithImpl(
    _$PostLikeFailedImpl _value,
    $Res Function(_$PostLikeFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = null, Object? message = null}) {
    return _then(
      _$PostLikeFailedImpl(
        post:
            null == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                    as PostModel,
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

class _$PostLikeFailedImpl implements PostLikeFailed {
  const _$PostLikeFailedImpl({required this.post, required this.message});

  @override
  final PostModel post;
  @override
  final String message;

  @override
  String toString() {
    return 'PostState.likeFailed(post: $post, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostLikeFailedImpl &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post, message);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostLikeFailedImplCopyWith<_$PostLikeFailedImpl> get copyWith =>
      __$$PostLikeFailedImplCopyWithImpl<_$PostLikeFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return likeFailed(post, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return likeFailed?.call(post, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (likeFailed != null) {
      return likeFailed(post, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return likeFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return likeFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (likeFailed != null) {
      return likeFailed(this);
    }
    return orElse();
  }
}

abstract class PostLikeFailed implements PostState {
  const factory PostLikeFailed({
    required final PostModel post,
    required final String message,
  }) = _$PostLikeFailedImpl;

  PostModel get post;
  String get message;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostLikeFailedImplCopyWith<_$PostLikeFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostSavedImplCopyWith<$Res> {
  factory _$$PostSavedImplCopyWith(
    _$PostSavedImpl value,
    $Res Function(_$PostSavedImpl) then,
  ) = __$$PostSavedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostModel post});
}

/// @nodoc
class __$$PostSavedImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostSavedImpl>
    implements _$$PostSavedImplCopyWith<$Res> {
  __$$PostSavedImplCopyWithImpl(
    _$PostSavedImpl _value,
    $Res Function(_$PostSavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = null}) {
    return _then(
      _$PostSavedImpl(
        post:
            null == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                    as PostModel,
      ),
    );
  }
}

/// @nodoc

class _$PostSavedImpl implements PostSaved {
  const _$PostSavedImpl({required this.post});

  @override
  final PostModel post;

  @override
  String toString() {
    return 'PostState.saved(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostSavedImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostSavedImplCopyWith<_$PostSavedImpl> get copyWith =>
      __$$PostSavedImplCopyWithImpl<_$PostSavedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return saved(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return saved?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return saved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class PostSaved implements PostState {
  const factory PostSaved({required final PostModel post}) = _$PostSavedImpl;

  PostModel get post;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostSavedImplCopyWith<_$PostSavedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostUnsavedImplCopyWith<$Res> {
  factory _$$PostUnsavedImplCopyWith(
    _$PostUnsavedImpl value,
    $Res Function(_$PostUnsavedImpl) then,
  ) = __$$PostUnsavedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostModel post});
}

/// @nodoc
class __$$PostUnsavedImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostUnsavedImpl>
    implements _$$PostUnsavedImplCopyWith<$Res> {
  __$$PostUnsavedImplCopyWithImpl(
    _$PostUnsavedImpl _value,
    $Res Function(_$PostUnsavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = null}) {
    return _then(
      _$PostUnsavedImpl(
        post:
            null == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                    as PostModel,
      ),
    );
  }
}

/// @nodoc

class _$PostUnsavedImpl implements PostUnsaved {
  const _$PostUnsavedImpl({required this.post});

  @override
  final PostModel post;

  @override
  String toString() {
    return 'PostState.unsaved(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostUnsavedImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostUnsavedImplCopyWith<_$PostUnsavedImpl> get copyWith =>
      __$$PostUnsavedImplCopyWithImpl<_$PostUnsavedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return unsaved(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return unsaved?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (unsaved != null) {
      return unsaved(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return unsaved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return unsaved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (unsaved != null) {
      return unsaved(this);
    }
    return orElse();
  }
}

abstract class PostUnsaved implements PostState {
  const factory PostUnsaved({required final PostModel post}) =
      _$PostUnsavedImpl;

  PostModel get post;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostUnsavedImplCopyWith<_$PostUnsavedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostSaveFailedImplCopyWith<$Res> {
  factory _$$PostSaveFailedImplCopyWith(
    _$PostSaveFailedImpl value,
    $Res Function(_$PostSaveFailedImpl) then,
  ) = __$$PostSaveFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostModel post, String message});
}

/// @nodoc
class __$$PostSaveFailedImplCopyWithImpl<$Res>
    extends _$PostStateCopyWithImpl<$Res, _$PostSaveFailedImpl>
    implements _$$PostSaveFailedImplCopyWith<$Res> {
  __$$PostSaveFailedImplCopyWithImpl(
    _$PostSaveFailedImpl _value,
    $Res Function(_$PostSaveFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = null, Object? message = null}) {
    return _then(
      _$PostSaveFailedImpl(
        post:
            null == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                    as PostModel,
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

class _$PostSaveFailedImpl implements PostSaveFailed {
  const _$PostSaveFailedImpl({required this.post, required this.message});

  @override
  final PostModel post;
  @override
  final String message;

  @override
  String toString() {
    return 'PostState.saveFailed(post: $post, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostSaveFailedImpl &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post, message);

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostSaveFailedImplCopyWith<_$PostSaveFailedImpl> get copyWith =>
      __$$PostSaveFailedImplCopyWithImpl<_$PostSaveFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(double progress) uploading,
    required TResult Function(Map<String, dynamic> post) uploaded,
    required TResult Function(String message) uploadError,
    required TResult Function(PostModel post) liked,
    required TResult Function(PostModel post) unliked,
    required TResult Function(PostModel post, String message) likeFailed,
    required TResult Function(PostModel post) saved,
    required TResult Function(PostModel post) unsaved,
    required TResult Function(PostModel post, String message) saveFailed,
  }) {
    return saveFailed(post, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(double progress)? uploading,
    TResult? Function(Map<String, dynamic> post)? uploaded,
    TResult? Function(String message)? uploadError,
    TResult? Function(PostModel post)? liked,
    TResult? Function(PostModel post)? unliked,
    TResult? Function(PostModel post, String message)? likeFailed,
    TResult? Function(PostModel post)? saved,
    TResult? Function(PostModel post)? unsaved,
    TResult? Function(PostModel post, String message)? saveFailed,
  }) {
    return saveFailed?.call(post, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(double progress)? uploading,
    TResult Function(Map<String, dynamic> post)? uploaded,
    TResult Function(String message)? uploadError,
    TResult Function(PostModel post)? liked,
    TResult Function(PostModel post)? unliked,
    TResult Function(PostModel post, String message)? likeFailed,
    TResult Function(PostModel post)? saved,
    TResult Function(PostModel post)? unsaved,
    TResult Function(PostModel post, String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (saveFailed != null) {
      return saveFailed(post, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostInitial value) initial,
    required TResult Function(PostUploading value) uploading,
    required TResult Function(PostUploaded value) uploaded,
    required TResult Function(PostUploadError value) uploadError,
    required TResult Function(PostLiked value) liked,
    required TResult Function(PostUnliked value) unliked,
    required TResult Function(PostLikeFailed value) likeFailed,
    required TResult Function(PostSaved value) saved,
    required TResult Function(PostUnsaved value) unsaved,
    required TResult Function(PostSaveFailed value) saveFailed,
  }) {
    return saveFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostInitial value)? initial,
    TResult? Function(PostUploading value)? uploading,
    TResult? Function(PostUploaded value)? uploaded,
    TResult? Function(PostUploadError value)? uploadError,
    TResult? Function(PostLiked value)? liked,
    TResult? Function(PostUnliked value)? unliked,
    TResult? Function(PostLikeFailed value)? likeFailed,
    TResult? Function(PostSaved value)? saved,
    TResult? Function(PostUnsaved value)? unsaved,
    TResult? Function(PostSaveFailed value)? saveFailed,
  }) {
    return saveFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostInitial value)? initial,
    TResult Function(PostUploading value)? uploading,
    TResult Function(PostUploaded value)? uploaded,
    TResult Function(PostUploadError value)? uploadError,
    TResult Function(PostLiked value)? liked,
    TResult Function(PostUnliked value)? unliked,
    TResult Function(PostLikeFailed value)? likeFailed,
    TResult Function(PostSaved value)? saved,
    TResult Function(PostUnsaved value)? unsaved,
    TResult Function(PostSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (saveFailed != null) {
      return saveFailed(this);
    }
    return orElse();
  }
}

abstract class PostSaveFailed implements PostState {
  const factory PostSaveFailed({
    required final PostModel post,
    required final String message,
  }) = _$PostSaveFailedImpl;

  PostModel get post;
  String get message;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostSaveFailedImplCopyWith<_$PostSaveFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
