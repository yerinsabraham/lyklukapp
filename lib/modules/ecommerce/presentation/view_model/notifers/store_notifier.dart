import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/modules/ecommerce/domain/repo/market_repositories.dart';
import '../../../data/repo_impl/market_repo_impls.dart';
import '../../../domain/repo/store_repository.dart';
// import '../state/shop_state.dart';
import '../../../model/store_model.dart';
import '../state/store_state.dart';

final storeNotifierProvider = NotifierProvider<StoreNotifier, StoreState>(
  StoreNotifier.new,
);

final currentStoreProvider = StateProvider<StoreModel?>((ref) {
  final state = ref.watch(storeNotifierProvider);
  return state.maybeWhen(
    orElse: () {},
    storeCreated: (store, msg) => store);
});

class StoreNotifier extends Notifier<StoreState> {
  late AnalyticsService analyticsService;
  late StoreRepository storeRepository;

  @override
  build() {
    analyticsService = ref.read(analyticsServiceProvider);
    storeRepository = ref.read(storeRepoProvider);
    return StoreIntialState();
  }

  void createStore({required Map<String, dynamic> data}) async {
    try {
      state = StoreCreating();

      final result = await storeRepository.createStore(data: data);
      result.fold(
        (failure) {
          state = StoreCreationFailed(message: failure.message);
        },
        (r) async {
          state = StoreCreated(store: r.data, msg: r.message);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = StoreCreationFailed(message: e.toString());
    } 
  }

  void setCarriers({required List<String> carrierCodes, required int storeId}) async {
    try {
      state = StoreState.settingCarriers();
      final data = {"carrierCodes": carrierCodes};
      final result = await storeRepository.setStoreCarriers(data: data, storeId: storeId);
      result.fold(
        (failure) {
          state = StoreState.settingCarriersFailed(message: failure.message);
        },
        (r) {
          state = StoreState.settingCarriersSuccess(
            data: r.data,
            msg: r.message,
          );
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = StoreCreationFailed(message: e.toString());
    }
  }

  void verifyStoreIndentity({required Map<String, dynamic> data}) async {
    try {
      state = StoreState.storeIndentityVerifying();
      final result = await storeRepository.verifyStoreIndentity(data: data);
      result.fold(
        (failure) {
          state = StoreState.storeVerificationFailed(message: failure.message);
        },
        (r) {
          state = StoreState.storeIndentityVerified(msg: r.message);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = StoreState.storeVerificationFailed(message: e.toString());
    }
  }

  /// valid file  i. max 10mb  and allow file type only jpg,jpeg,png,pdf
  String? validateStoreDocFile(File file){
    final ext = file.path.split('.').last;
    final  size= file.lengthSync();
    if (size > 10 * 1024 * 1024) {
      return "File size is too large";
    }
    if (ext.toLowerCase() != "jpg" &&
        ext.toLowerCase() != "jpeg" &&
        ext.toLowerCase() != "png" &&
        ext.toLowerCase() != "pdf") {
      return  "File type $ext is not allowed only jpg,jpeg,png,pdf"  ;
    }
    return  null ;
    
  }
  

  void storeDocUpload(File doc) async {
    try {
      final v= validateStoreDocFile(doc) ;
      if(v != null){
        state = StoreState.storeDocuUploadFailed(message: v);
        return ;
      }
      
      final data = {
        "document": await MultipartFile.fromFile(
          doc.path,
          filename: doc.path.split('/').last,
        ),
      };
      final result = await storeRepository.uploadStoreDocument(
        data: data,
        onProgress: (p) {
          state = StoreState.storeDocUploading(progress: p);
        },
      );
      result.fold( 
        (failure) {
          state = StoreState.storeDocuUploadFailed(message: failure.message);
        },
        (r) {
          state = StoreState.storeDocUploaded(msg: r.message, url: r.data);
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = StoreState.storeDocuUploadFailed(message: e.toString());
    } 
  }

  void updateStoreSettings() {}

  void updateStore() {}

  void uploadStoreImages() {}
}
