import 'package:freezed_annotation/freezed_annotation.dart';


import '../../../model/store_model.dart';

part 'shop_state.freezed.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState.storeIntialState() = StoreIntialState;

  //create store

  const factory ShopState.storeCreating() = StoreCreating;
  const factory ShopState.storeCreated({
    required StoreModel store,
    required String msg,
  }) = StoreCreated;
  const factory ShopState.storeCreationFailed({required String message}) =
      StoreCreationFailed;

  /// update store
  const factory ShopState.storeUpdating() = StoreUpdating;
  const factory ShopState.storeUpdated({
    required StoreModel store,
    required String msg,
  }) = StoreUpdated;
  const factory ShopState.storeUpdateFailed({required String message}) =
      StoreUpdateFailed;

  /// update store setting
  const factory ShopState.storeSettingUpdating() = StoreSettingUpdating;
  const factory ShopState.storeSettingUpdated({
    required StoreModel store,
    required String msg,
  }) = StoreSettingUpdated;
  const factory ShopState.storeSettingUpdateFailed({required String message}) =
      StoreSettingUpdateFailed;

  /// verify store (admin only )
  const factory ShopState.storeVerifying() = StoreVerifying;
  const factory ShopState.storeVerified({required String msg}) = StoreVerified;
  const factory ShopState.storeVerificationFailed({required String message}) =
      StoreVerificationFailed;

  /// reject store (admin only )
  const factory ShopState.storeRejecting() = StoreRejecting;
  const factory ShopState.storeRejected({required String msg}) = StoreRejected;
  const factory ShopState.storeRejectionFailed({required String message}) =
      StoreRejectionFailed;

  /// set carriers
  const factory ShopState.settingCarriers() = SettingCarriers;
  const factory ShopState.settingCarriersSuccess({
    required String msg,
    required Map data,
  }) = SettingCarriersSuccess;
  const factory ShopState.settingCarriersFailed({required String message}) =
      SettingCarriersFailed;
}
