import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();

  bool isLoading = false;
  String? error;

  List<ProductModel> _allProducts = [];
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

bool get hasProducts => _allProducts.isNotEmpty;

  Future<void> fetchProducts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final data = await _repository.getProducts();

      _allProducts = data;
      _products = List.from(data);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    if (query.trim().isEmpty) {
      _products = List.from(_allProducts);
    } else {
      final searchText = query.toLowerCase();

      _products = _allProducts.where((product) {
        return product.title.toLowerCase().contains(searchText);
      }).toList();
    }

    notifyListeners();
  }

  void clearSearch() {
    _products = List.from(_allProducts);
    notifyListeners();
  }
}