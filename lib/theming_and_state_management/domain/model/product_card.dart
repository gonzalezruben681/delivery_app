import 'package:delivery_app/theming_and_state_management/domain/model/product.dart';

class ProductCart {
  final Product product;
  int quantity;

  ProductCart({required this.product, this.quantity = 1});
}
