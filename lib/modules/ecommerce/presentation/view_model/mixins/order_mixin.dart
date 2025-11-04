// ignore_for_file: invalid_use_of_internal_member

import 'package:lykluk/utils/pagination/pagination.dart';

mixin OrderMixin<OrderModel> on PaginationController<OrderModel>  {
  /// listen product notifier and update the model if there is a change
  void onOrderUpdate() {
    // ref.listen(productNotifierProvider, (p, n) {
    //   n.maybeWhen(
    //     orElse: () {},
    //     saveProduct: (p) {
    //       findAndReplace(
    //         model: p as OrderModel,
    //         test: (m) => m.id == p.id,
    //       );
    //     },
    //   );
    // });
  }
}
