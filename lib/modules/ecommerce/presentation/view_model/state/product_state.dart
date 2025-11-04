import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/market_models.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.productIntialState() = ProductIntialState;
  /// save post state
  const factory ProductState.saveProduct({required ProductModel product}) = SaveProduct;
  const factory ProductState.unsaveProduct({required ProductModel product}) =
      UnSaveProduct;
  const factory ProductState.saveProductFailed({required String message,required ProductModel product}) = SaveProductFailed;

  ///create product state
  const factory ProductState.creatingProduct() = CreatingProduct;
  const factory ProductState.createdProduct({required ProductModel product, required String message}) = CreatedProduct;
  const factory ProductState.createProductFailed({required String message}) = CreateProductFailed;

  ///update product state
  const factory ProductState.updatingProduct({required ProductModel product}) = UpdatingProduct;
  const factory ProductState.updatedProduct({required ProductModel product, required String message}) = UpdatedProduct;
  const factory ProductState.updateProductFailed({required String message}) = UpdateProductFailed;

  ///delete product state
  const factory ProductState.deletingProduct({required ProductModel product}) = DeletingProduct;
  const factory ProductState.deletedProduct({required ProductModel product, required String message}) = DeletedProduct;
  const factory ProductState.deleteProductFailed({required String message}) = DeleteProductFailed; 

  /// image upload state
  const factory ProductState.uploadingImage({required String message, required int productId,}) = UploadingImage;
  const factory ProductState.imageUploaded({required String message, required int productId, required List<String> images, required int storeId}) = ImageUploaded;
  const factory ProductState.imageUploadFailed({required String message, required int productId,}) = ImageUploadFailed;

}
