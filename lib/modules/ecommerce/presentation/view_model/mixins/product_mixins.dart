// ignore_for_file: invalid_use_of_internal_member


import '../../../../../utils/pagination/pagination.dart' show PaginatedResponse, PaginationController;

mixin ProductMixin<ProductModel>
    on PaginationController<ProductModel> {
  /// listen product notifier and update the model if there is a change
  // void onProductUpdate() {
  //   ref.listen(productNotifierProvider, (p, n) {
  //     n.maybeWhen(
  //       orElse: () {},
  //       saveProduct: (p) {
  //         findAndReplace(model: p, test: (m) => m.id == p.id);
  //       },
  //     );
  //   });
  // }
}
