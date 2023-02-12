import 'package:delivery_app/theming_and_state_management/domain/model/product.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:flutter/material.dart';

class ProductsBloc extends ChangeNotifier {
  final ApiRepositoryInterface apiRepositoryInterface;

  ProductsBloc({required this.apiRepositoryInterface});

  List<Product> productList = [];

  void loadProduct() async {
    final result = await apiRepositoryInterface.getProducts();
    productList = result;
    notifyListeners();
  }
}
