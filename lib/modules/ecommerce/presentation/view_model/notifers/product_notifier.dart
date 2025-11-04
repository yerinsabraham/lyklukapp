import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/services.dart';

import '../../../data/ecommerce_services/upload_event.dart';
import '../../../data/repo_impl/product_repo_impl.dart';
import '../../../domain/repo/product_repository.dart';
import '../../../model/market_models.dart';
import '../state/product_state.dart';

final productNotifierProvider = NotifierProvider<ProductNotifier, ProductState>(
  ProductNotifier.new,
);

class ProductNotifier extends Notifier<ProductState> {
  late AnalyticsService analyticsService;
  late ProductRepository productRepository;
  @override
  build() {
    analyticsService = ref.read(analyticsServiceProvider);
    productRepository = ref.read(productRepoProvider);
    return ProductIntialState();
  }

  void createProduct({
    required Map<String, dynamic> data,
    required List<String> images,
  }) async {
    try {
      state = CreatingProduct();

      final result = await productRepository.createProduct(data: data);

      result.fold(
        (l) {
          state = CreateProductFailed(message: l.message);
        },
        (r) {
          state = CreatedProduct(message: r.message, product: r.data);
          productRepository.uploadProductImage(
            productId: r.data.id,
            images: images,
            storeId: r.data.store?.id ?? 0,
          );
        },
      );
    } catch (e) {
      log.e(e.toString());
      state = CreateProductFailed(message: e.toString());
    }
  }

  void toggleSaveProduct(ProductModel product) async {
    try {
      final newproduct = product.copyWith(featured: !product.featured);
      if (newproduct.featured) {
        state= SaveProduct(product: newproduct);
        final result = await productRepository.saveProduct(
          productId: product.id.toString(),
        );
        result.fold(
          (l) {
            state = SaveProductFailed(message: l.message, product: product);
          },
          (r) {
            // state = SaveProduct(product: r.data.copyWith(product: r.data.product.copyWith(featured: true)));
          },
        );
      } else {
        state= UnSaveProduct(product: newproduct);
        final result = await productRepository.unSaveProduct(
          productId: product.id.toString(),
        );
        result.fold(
          (l) {
            state = SaveProductFailed(message: l.message, product: product);
          },
          (r) {
            // state = UnSaveProduct(product: newproduct.toSaved());
          },
        );  
      }
    } catch (e) {
      log.e(e.toString());
      state = SaveProductFailed(message: e.toString(), product: product);
    }
  }
}

final productImageUploaderProgress = StreamProviderFamily<double, String>((
  ref,
  s,
) {
  final repo = ref.read(productRepoProvider);

  return repo.onUploadProgress().map((event) {
    if (event is UploadProgress && event.productId == s) {
      return event.progress;
    } else {
      return 0.0;
    }
  });
});
