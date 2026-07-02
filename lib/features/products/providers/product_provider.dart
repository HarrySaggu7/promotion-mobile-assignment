import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();

  bool isLoading = false;
  String? error;
  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      products = await _repository.getProducts();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}