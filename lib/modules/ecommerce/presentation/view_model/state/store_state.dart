import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/store_model.dart';

part 'store_state.freezed.dart';

@freezed
 class StoreState with _$StoreState {

   const factory StoreState.storeIntialState() = StoreIntialState;

  //create store

  const factory StoreState.storeCreating() = StoreCreating;
  const factory StoreState.storeCreated({
    required StoreModel store,required String msg}) = StoreCreated;
  const factory StoreState.storeCreationFailed({required String message}) = StoreCreationFailed;




  /// update store
  const factory StoreState.storeUpdating() = StoreUpdating;
  const factory StoreState.storeUpdated({
    required StoreModel store,
    required String msg,
  }) = StoreUpdated;
  const factory StoreState.storeUpdateFailed({required String message}) =
      StoreUpdateFailed;

  /// update store setting
  const factory StoreState.storeSettingUpdating() = StoreSettingUpdating;
  const factory StoreState.storeSettingUpdated({
    required StoreModel store,
    required String msg,
  }) = StoreSettingUpdated;
  const factory StoreState.storeSettingUpdateFailed({required String message}) =
      StoreSettingUpdateFailed;

  /// verify store (admin only )
  const factory StoreState.storeVerifying() = StoreVerifying;
  const factory StoreState.storeVerified({required String msg}) = StoreVerified;
  const factory StoreState.storeVerificationFailed({required String message}) =
      StoreVerificationFailed;

  /// verify store indentity 
  const factory StoreState.storeIndentityVerifying() = StoreIdentityVerifying;
  const factory StoreState.storeIndentityVerified({required String msg}) = StoreIdentityVerified;
  const factory StoreState.storeVerificationIndentityFailed({required String message}) =
      StoreVerificationIdentityFailed;

  /// reject store (admin only )
  const factory StoreState.storeRejecting() = StoreRejecting;
  const factory StoreState.storeRejected({required String msg}) = StoreRejected;
  const factory StoreState.storeRejectionFailed({required String message}) =
      StoreRejectionFailed;

  /// set carriers
   const factory StoreState.settingCarriers() = SettingCarriers;
  const factory StoreState.settingCarriersSuccess({required String msg, required Map data}) = SettingCarriersSuccess;
  const factory StoreState.settingCarriersFailed({required String message}) =
      SettingCarriersFailed;
  /// store document upload
  const factory StoreState.storeDocUploading({required double progress}) = StoreDocUploading;
  const factory StoreState.storeDocUploaded({required String msg, required String url}) = StoreDocUploaded;
  const factory StoreState.storeDocuUploadFailed({required String message}) =
      StoreDocUploadFailed;


  
}