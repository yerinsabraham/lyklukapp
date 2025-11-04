// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CartState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res, CartState>;
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res, $Val extends CartState>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CartInitialImplCopyWith<$Res> {
  factory _$$CartInitialImplCopyWith(
    _$CartInitialImpl value,
    $Res Function(_$CartInitialImpl) then,
  ) = __$$CartInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CartInitialImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartInitialImpl>
    implements _$$CartInitialImplCopyWith<$Res> {
  __$$CartInitialImplCopyWithImpl(
    _$CartInitialImpl _value,
    $Res Function(_$CartInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CartInitialImpl implements CartInitial {
  const _$CartInitialImpl();

  @override
  String toString() {
    return 'CartState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CartInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
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
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CartInitial implements CartState {
  const factory CartInitial() = _$CartInitialImpl;
}

/// @nodoc
abstract class _$$CartAddingToCartImplCopyWith<$Res> {
  factory _$$CartAddingToCartImplCopyWith(
    _$CartAddingToCartImpl value,
    $Res Function(_$CartAddingToCartImpl) then,
  ) = __$$CartAddingToCartImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CartAddingToCartImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartAddingToCartImpl>
    implements _$$CartAddingToCartImplCopyWith<$Res> {
  __$$CartAddingToCartImplCopyWithImpl(
    _$CartAddingToCartImpl _value,
    $Res Function(_$CartAddingToCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CartAddingToCartImpl implements CartAddingToCart {
  const _$CartAddingToCartImpl();

  @override
  String toString() {
    return 'CartState.addingToCart()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CartAddingToCartImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return addingToCart();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return addingToCart?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (addingToCart != null) {
      return addingToCart();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return addingToCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return addingToCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (addingToCart != null) {
      return addingToCart(this);
    }
    return orElse();
  }
}

abstract class CartAddingToCart implements CartState {
  const factory CartAddingToCart() = _$CartAddingToCartImpl;
}

/// @nodoc
abstract class _$$CartAddedToCartImplCopyWith<$Res> {
  factory _$$CartAddedToCartImplCopyWith(
    _$CartAddedToCartImpl value,
    $Res Function(_$CartAddedToCartImpl) then,
  ) = __$$CartAddedToCartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CartModel cart});
}

/// @nodoc
class __$$CartAddedToCartImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartAddedToCartImpl>
    implements _$$CartAddedToCartImplCopyWith<$Res> {
  __$$CartAddedToCartImplCopyWithImpl(
    _$CartAddedToCartImpl _value,
    $Res Function(_$CartAddedToCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cart = null}) {
    return _then(
      _$CartAddedToCartImpl(
        cart:
            null == cart
                ? _value.cart
                : cart // ignore: cast_nullable_to_non_nullable
                    as CartModel,
      ),
    );
  }
}

/// @nodoc

class _$CartAddedToCartImpl implements CartAddedToCart {
  const _$CartAddedToCartImpl({required this.cart});

  @override
  final CartModel cart;

  @override
  String toString() {
    return 'CartState.addedToCart(cart: $cart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartAddedToCartImpl &&
            (identical(other.cart, cart) || other.cart == cart));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cart);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartAddedToCartImplCopyWith<_$CartAddedToCartImpl> get copyWith =>
      __$$CartAddedToCartImplCopyWithImpl<_$CartAddedToCartImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return addedToCart(cart);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return addedToCart?.call(cart);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (addedToCart != null) {
      return addedToCart(cart);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return addedToCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return addedToCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (addedToCart != null) {
      return addedToCart(this);
    }
    return orElse();
  }
}

abstract class CartAddedToCart implements CartState {
  const factory CartAddedToCart({required final CartModel cart}) =
      _$CartAddedToCartImpl;

  CartModel get cart;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartAddedToCartImplCopyWith<_$CartAddedToCartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartAddingToCartFailedImplCopyWith<$Res> {
  factory _$$CartAddingToCartFailedImplCopyWith(
    _$CartAddingToCartFailedImpl value,
    $Res Function(_$CartAddingToCartFailedImpl) then,
  ) = __$$CartAddingToCartFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CartAddingToCartFailedImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartAddingToCartFailedImpl>
    implements _$$CartAddingToCartFailedImplCopyWith<$Res> {
  __$$CartAddingToCartFailedImplCopyWithImpl(
    _$CartAddingToCartFailedImpl _value,
    $Res Function(_$CartAddingToCartFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CartAddingToCartFailedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$CartAddingToCartFailedImpl implements CartAddingToCartFailed {
  const _$CartAddingToCartFailedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CartState.addingToCartFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartAddingToCartFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartAddingToCartFailedImplCopyWith<_$CartAddingToCartFailedImpl>
  get copyWith =>
      __$$CartAddingToCartFailedImplCopyWithImpl<_$CartAddingToCartFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return addingToCartFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return addingToCartFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (addingToCartFailed != null) {
      return addingToCartFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return addingToCartFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return addingToCartFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (addingToCartFailed != null) {
      return addingToCartFailed(this);
    }
    return orElse();
  }
}

abstract class CartAddingToCartFailed implements CartState {
  const factory CartAddingToCartFailed(final String message) =
      _$CartAddingToCartFailedImpl;

  String get message;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartAddingToCartFailedImplCopyWith<_$CartAddingToCartFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartRemovingFromCartImplCopyWith<$Res> {
  factory _$$CartRemovingFromCartImplCopyWith(
    _$CartRemovingFromCartImpl value,
    $Res Function(_$CartRemovingFromCartImpl) then,
  ) = __$$CartRemovingFromCartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int productId});
}

/// @nodoc
class __$$CartRemovingFromCartImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartRemovingFromCartImpl>
    implements _$$CartRemovingFromCartImplCopyWith<$Res> {
  __$$CartRemovingFromCartImplCopyWithImpl(
    _$CartRemovingFromCartImpl _value,
    $Res Function(_$CartRemovingFromCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? productId = null}) {
    return _then(
      _$CartRemovingFromCartImpl(
        productId:
            null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$CartRemovingFromCartImpl implements CartRemovingFromCart {
  const _$CartRemovingFromCartImpl({required this.productId});

  @override
  final int productId;

  @override
  String toString() {
    return 'CartState.removingFromCart(productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartRemovingFromCartImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartRemovingFromCartImplCopyWith<_$CartRemovingFromCartImpl>
  get copyWith =>
      __$$CartRemovingFromCartImplCopyWithImpl<_$CartRemovingFromCartImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return removingFromCart(productId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return removingFromCart?.call(productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (removingFromCart != null) {
      return removingFromCart(productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return removingFromCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return removingFromCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (removingFromCart != null) {
      return removingFromCart(this);
    }
    return orElse();
  }
}

abstract class CartRemovingFromCart implements CartState {
  const factory CartRemovingFromCart({required final int productId}) =
      _$CartRemovingFromCartImpl;

  int get productId;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartRemovingFromCartImplCopyWith<_$CartRemovingFromCartImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartRemovedFromCartImplCopyWith<$Res> {
  factory _$$CartRemovedFromCartImplCopyWith(
    _$CartRemovedFromCartImpl value,
    $Res Function(_$CartRemovedFromCartImpl) then,
  ) = __$$CartRemovedFromCartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CartModel cart});
}

/// @nodoc
class __$$CartRemovedFromCartImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartRemovedFromCartImpl>
    implements _$$CartRemovedFromCartImplCopyWith<$Res> {
  __$$CartRemovedFromCartImplCopyWithImpl(
    _$CartRemovedFromCartImpl _value,
    $Res Function(_$CartRemovedFromCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cart = null}) {
    return _then(
      _$CartRemovedFromCartImpl(
        cart:
            null == cart
                ? _value.cart
                : cart // ignore: cast_nullable_to_non_nullable
                    as CartModel,
      ),
    );
  }
}

/// @nodoc

class _$CartRemovedFromCartImpl implements CartRemovedFromCart {
  const _$CartRemovedFromCartImpl({required this.cart});

  @override
  final CartModel cart;

  @override
  String toString() {
    return 'CartState.removedFromCart(cart: $cart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartRemovedFromCartImpl &&
            (identical(other.cart, cart) || other.cart == cart));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cart);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartRemovedFromCartImplCopyWith<_$CartRemovedFromCartImpl> get copyWith =>
      __$$CartRemovedFromCartImplCopyWithImpl<_$CartRemovedFromCartImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return removedFromCart(cart);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return removedFromCart?.call(cart);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (removedFromCart != null) {
      return removedFromCart(cart);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return removedFromCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return removedFromCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (removedFromCart != null) {
      return removedFromCart(this);
    }
    return orElse();
  }
}

abstract class CartRemovedFromCart implements CartState {
  const factory CartRemovedFromCart({required final CartModel cart}) =
      _$CartRemovedFromCartImpl;

  CartModel get cart;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartRemovedFromCartImplCopyWith<_$CartRemovedFromCartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartRemovingFromCartFailedImplCopyWith<$Res> {
  factory _$$CartRemovingFromCartFailedImplCopyWith(
    _$CartRemovingFromCartFailedImpl value,
    $Res Function(_$CartRemovingFromCartFailedImpl) then,
  ) = __$$CartRemovingFromCartFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CartRemovingFromCartFailedImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartRemovingFromCartFailedImpl>
    implements _$$CartRemovingFromCartFailedImplCopyWith<$Res> {
  __$$CartRemovingFromCartFailedImplCopyWithImpl(
    _$CartRemovingFromCartFailedImpl _value,
    $Res Function(_$CartRemovingFromCartFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CartRemovingFromCartFailedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$CartRemovingFromCartFailedImpl implements CartRemovingFromCartFailed {
  const _$CartRemovingFromCartFailedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CartState.removingFromCartFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartRemovingFromCartFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartRemovingFromCartFailedImplCopyWith<_$CartRemovingFromCartFailedImpl>
  get copyWith => __$$CartRemovingFromCartFailedImplCopyWithImpl<
    _$CartRemovingFromCartFailedImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return removingFromCartFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return removingFromCartFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (removingFromCartFailed != null) {
      return removingFromCartFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return removingFromCartFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return removingFromCartFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (removingFromCartFailed != null) {
      return removingFromCartFailed(this);
    }
    return orElse();
  }
}

abstract class CartRemovingFromCartFailed implements CartState {
  const factory CartRemovingFromCartFailed(final String message) =
      _$CartRemovingFromCartFailedImpl;

  String get message;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartRemovingFromCartFailedImplCopyWith<_$CartRemovingFromCartFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartUpdatingCartImplCopyWith<$Res> {
  factory _$$CartUpdatingCartImplCopyWith(
    _$CartUpdatingCartImpl value,
    $Res Function(_$CartUpdatingCartImpl) then,
  ) = __$$CartUpdatingCartImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CartUpdatingCartImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartUpdatingCartImpl>
    implements _$$CartUpdatingCartImplCopyWith<$Res> {
  __$$CartUpdatingCartImplCopyWithImpl(
    _$CartUpdatingCartImpl _value,
    $Res Function(_$CartUpdatingCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CartUpdatingCartImpl implements CartUpdatingCart {
  const _$CartUpdatingCartImpl();

  @override
  String toString() {
    return 'CartState.updatingCart()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CartUpdatingCartImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return updatingCart();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return updatingCart?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (updatingCart != null) {
      return updatingCart();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return updatingCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return updatingCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (updatingCart != null) {
      return updatingCart(this);
    }
    return orElse();
  }
}

abstract class CartUpdatingCart implements CartState {
  const factory CartUpdatingCart() = _$CartUpdatingCartImpl;
}

/// @nodoc
abstract class _$$CartUpdatedCartImplCopyWith<$Res> {
  factory _$$CartUpdatedCartImplCopyWith(
    _$CartUpdatedCartImpl value,
    $Res Function(_$CartUpdatedCartImpl) then,
  ) = __$$CartUpdatedCartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CartModel cart});
}

/// @nodoc
class __$$CartUpdatedCartImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartUpdatedCartImpl>
    implements _$$CartUpdatedCartImplCopyWith<$Res> {
  __$$CartUpdatedCartImplCopyWithImpl(
    _$CartUpdatedCartImpl _value,
    $Res Function(_$CartUpdatedCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cart = null}) {
    return _then(
      _$CartUpdatedCartImpl(
        cart:
            null == cart
                ? _value.cart
                : cart // ignore: cast_nullable_to_non_nullable
                    as CartModel,
      ),
    );
  }
}

/// @nodoc

class _$CartUpdatedCartImpl implements CartUpdatedCart {
  const _$CartUpdatedCartImpl({required this.cart});

  @override
  final CartModel cart;

  @override
  String toString() {
    return 'CartState.updatedCart(cart: $cart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartUpdatedCartImpl &&
            (identical(other.cart, cart) || other.cart == cart));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cart);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartUpdatedCartImplCopyWith<_$CartUpdatedCartImpl> get copyWith =>
      __$$CartUpdatedCartImplCopyWithImpl<_$CartUpdatedCartImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return updatedCart(cart);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return updatedCart?.call(cart);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (updatedCart != null) {
      return updatedCart(cart);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return updatedCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return updatedCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (updatedCart != null) {
      return updatedCart(this);
    }
    return orElse();
  }
}

abstract class CartUpdatedCart implements CartState {
  const factory CartUpdatedCart({required final CartModel cart}) =
      _$CartUpdatedCartImpl;

  CartModel get cart;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartUpdatedCartImplCopyWith<_$CartUpdatedCartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartUpdatingCartFailedImplCopyWith<$Res> {
  factory _$$CartUpdatingCartFailedImplCopyWith(
    _$CartUpdatingCartFailedImpl value,
    $Res Function(_$CartUpdatingCartFailedImpl) then,
  ) = __$$CartUpdatingCartFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CartUpdatingCartFailedImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartUpdatingCartFailedImpl>
    implements _$$CartUpdatingCartFailedImplCopyWith<$Res> {
  __$$CartUpdatingCartFailedImplCopyWithImpl(
    _$CartUpdatingCartFailedImpl _value,
    $Res Function(_$CartUpdatingCartFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CartUpdatingCartFailedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$CartUpdatingCartFailedImpl implements CartUpdatingCartFailed {
  const _$CartUpdatingCartFailedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CartState.updatingCartFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartUpdatingCartFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartUpdatingCartFailedImplCopyWith<_$CartUpdatingCartFailedImpl>
  get copyWith =>
      __$$CartUpdatingCartFailedImplCopyWithImpl<_$CartUpdatingCartFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return updatingCartFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return updatingCartFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (updatingCartFailed != null) {
      return updatingCartFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return updatingCartFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return updatingCartFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (updatingCartFailed != null) {
      return updatingCartFailed(this);
    }
    return orElse();
  }
}

abstract class CartUpdatingCartFailed implements CartState {
  const factory CartUpdatingCartFailed(final String message) =
      _$CartUpdatingCartFailedImpl;

  String get message;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartUpdatingCartFailedImplCopyWith<_$CartUpdatingCartFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartValidingCartImplCopyWith<$Res> {
  factory _$$CartValidingCartImplCopyWith(
    _$CartValidingCartImpl value,
    $Res Function(_$CartValidingCartImpl) then,
  ) = __$$CartValidingCartImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CartValidingCartImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartValidingCartImpl>
    implements _$$CartValidingCartImplCopyWith<$Res> {
  __$$CartValidingCartImplCopyWithImpl(
    _$CartValidingCartImpl _value,
    $Res Function(_$CartValidingCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CartValidingCartImpl implements CartValidingCart {
  const _$CartValidingCartImpl();

  @override
  String toString() {
    return 'CartState.validingCart()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CartValidingCartImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return validingCart();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return validingCart?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (validingCart != null) {
      return validingCart();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return validingCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return validingCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (validingCart != null) {
      return validingCart(this);
    }
    return orElse();
  }
}

abstract class CartValidingCart implements CartState {
  const factory CartValidingCart() = _$CartValidingCartImpl;
}

/// @nodoc
abstract class _$$CartValidCartImplCopyWith<$Res> {
  factory _$$CartValidCartImplCopyWith(
    _$CartValidCartImpl value,
    $Res Function(_$CartValidCartImpl) then,
  ) = __$$CartValidCartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> cartmap});
}

/// @nodoc
class __$$CartValidCartImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartValidCartImpl>
    implements _$$CartValidCartImplCopyWith<$Res> {
  __$$CartValidCartImplCopyWithImpl(
    _$CartValidCartImpl _value,
    $Res Function(_$CartValidCartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cartmap = null}) {
    return _then(
      _$CartValidCartImpl(
        cartmap:
            null == cartmap
                ? _value._cartmap
                : cartmap // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$CartValidCartImpl implements CartValidCart {
  const _$CartValidCartImpl({required final Map<String, dynamic> cartmap})
    : _cartmap = cartmap;

  final Map<String, dynamic> _cartmap;
  @override
  Map<String, dynamic> get cartmap {
    if (_cartmap is EqualUnmodifiableMapView) return _cartmap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cartmap);
  }

  @override
  String toString() {
    return 'CartState.validatedCart(cartmap: $cartmap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartValidCartImpl &&
            const DeepCollectionEquality().equals(other._cartmap, _cartmap));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cartmap));

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartValidCartImplCopyWith<_$CartValidCartImpl> get copyWith =>
      __$$CartValidCartImplCopyWithImpl<_$CartValidCartImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return validatedCart(cartmap);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return validatedCart?.call(cartmap);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (validatedCart != null) {
      return validatedCart(cartmap);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return validatedCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return validatedCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (validatedCart != null) {
      return validatedCart(this);
    }
    return orElse();
  }
}

abstract class CartValidCart implements CartState {
  const factory CartValidCart({required final Map<String, dynamic> cartmap}) =
      _$CartValidCartImpl;

  Map<String, dynamic> get cartmap;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartValidCartImplCopyWith<_$CartValidCartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CartValidingCartFailedImplCopyWith<$Res> {
  factory _$$CartValidingCartFailedImplCopyWith(
    _$CartValidingCartFailedImpl value,
    $Res Function(_$CartValidingCartFailedImpl) then,
  ) = __$$CartValidingCartFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg, List<String> messages});
}

/// @nodoc
class __$$CartValidingCartFailedImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartValidingCartFailedImpl>
    implements _$$CartValidingCartFailedImplCopyWith<$Res> {
  __$$CartValidingCartFailedImplCopyWithImpl(
    _$CartValidingCartFailedImpl _value,
    $Res Function(_$CartValidingCartFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? msg = null, Object? messages = null}) {
    return _then(
      _$CartValidingCartFailedImpl(
        msg:
            null == msg
                ? _value.msg
                : msg // ignore: cast_nullable_to_non_nullable
                    as String,
        messages:
            null == messages
                ? _value._messages
                : messages // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$CartValidingCartFailedImpl implements CartValidingCartFailed {
  const _$CartValidingCartFailedImpl({
    required this.msg,
    required final List<String> messages,
  }) : _messages = messages;

  @override
  final String msg;
  final List<String> _messages;
  @override
  List<String> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'CartState.validingCartFailed(msg: $msg, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartValidingCartFailedImpl &&
            (identical(other.msg, msg) || other.msg == msg) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    msg,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartValidingCartFailedImplCopyWith<_$CartValidingCartFailedImpl>
  get copyWith =>
      __$$CartValidingCartFailedImplCopyWithImpl<_$CartValidingCartFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() addingToCart,
    required TResult Function(CartModel cart) addedToCart,
    required TResult Function(String message) addingToCartFailed,
    required TResult Function(int productId) removingFromCart,
    required TResult Function(CartModel cart) removedFromCart,
    required TResult Function(String message) removingFromCartFailed,
    required TResult Function() updatingCart,
    required TResult Function(CartModel cart) updatedCart,
    required TResult Function(String message) updatingCartFailed,
    required TResult Function() validingCart,
    required TResult Function(Map<String, dynamic> cartmap) validatedCart,
    required TResult Function(String msg, List<String> messages)
    validingCartFailed,
  }) {
    return validingCartFailed(msg, messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? addingToCart,
    TResult? Function(CartModel cart)? addedToCart,
    TResult? Function(String message)? addingToCartFailed,
    TResult? Function(int productId)? removingFromCart,
    TResult? Function(CartModel cart)? removedFromCart,
    TResult? Function(String message)? removingFromCartFailed,
    TResult? Function()? updatingCart,
    TResult? Function(CartModel cart)? updatedCart,
    TResult? Function(String message)? updatingCartFailed,
    TResult? Function()? validingCart,
    TResult? Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult? Function(String msg, List<String> messages)? validingCartFailed,
  }) {
    return validingCartFailed?.call(msg, messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? addingToCart,
    TResult Function(CartModel cart)? addedToCart,
    TResult Function(String message)? addingToCartFailed,
    TResult Function(int productId)? removingFromCart,
    TResult Function(CartModel cart)? removedFromCart,
    TResult Function(String message)? removingFromCartFailed,
    TResult Function()? updatingCart,
    TResult Function(CartModel cart)? updatedCart,
    TResult Function(String message)? updatingCartFailed,
    TResult Function()? validingCart,
    TResult Function(Map<String, dynamic> cartmap)? validatedCart,
    TResult Function(String msg, List<String> messages)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (validingCartFailed != null) {
      return validingCartFailed(msg, messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CartInitial value) initial,
    required TResult Function(CartAddingToCart value) addingToCart,
    required TResult Function(CartAddedToCart value) addedToCart,
    required TResult Function(CartAddingToCartFailed value) addingToCartFailed,
    required TResult Function(CartRemovingFromCart value) removingFromCart,
    required TResult Function(CartRemovedFromCart value) removedFromCart,
    required TResult Function(CartRemovingFromCartFailed value)
    removingFromCartFailed,
    required TResult Function(CartUpdatingCart value) updatingCart,
    required TResult Function(CartUpdatedCart value) updatedCart,
    required TResult Function(CartUpdatingCartFailed value) updatingCartFailed,
    required TResult Function(CartValidingCart value) validingCart,
    required TResult Function(CartValidCart value) validatedCart,
    required TResult Function(CartValidingCartFailed value) validingCartFailed,
  }) {
    return validingCartFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CartInitial value)? initial,
    TResult? Function(CartAddingToCart value)? addingToCart,
    TResult? Function(CartAddedToCart value)? addedToCart,
    TResult? Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult? Function(CartRemovingFromCart value)? removingFromCart,
    TResult? Function(CartRemovedFromCart value)? removedFromCart,
    TResult? Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult? Function(CartUpdatingCart value)? updatingCart,
    TResult? Function(CartUpdatedCart value)? updatedCart,
    TResult? Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult? Function(CartValidingCart value)? validingCart,
    TResult? Function(CartValidCart value)? validatedCart,
    TResult? Function(CartValidingCartFailed value)? validingCartFailed,
  }) {
    return validingCartFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CartInitial value)? initial,
    TResult Function(CartAddingToCart value)? addingToCart,
    TResult Function(CartAddedToCart value)? addedToCart,
    TResult Function(CartAddingToCartFailed value)? addingToCartFailed,
    TResult Function(CartRemovingFromCart value)? removingFromCart,
    TResult Function(CartRemovedFromCart value)? removedFromCart,
    TResult Function(CartRemovingFromCartFailed value)? removingFromCartFailed,
    TResult Function(CartUpdatingCart value)? updatingCart,
    TResult Function(CartUpdatedCart value)? updatedCart,
    TResult Function(CartUpdatingCartFailed value)? updatingCartFailed,
    TResult Function(CartValidingCart value)? validingCart,
    TResult Function(CartValidCart value)? validatedCart,
    TResult Function(CartValidingCartFailed value)? validingCartFailed,
    required TResult orElse(),
  }) {
    if (validingCartFailed != null) {
      return validingCartFailed(this);
    }
    return orElse();
  }
}

abstract class CartValidingCartFailed implements CartState {
  const factory CartValidingCartFailed({
    required final String msg,
    required final List<String> messages,
  }) = _$CartValidingCartFailedImpl;

  String get msg;
  List<String> get messages;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartValidingCartFailedImplCopyWith<_$CartValidingCartFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
