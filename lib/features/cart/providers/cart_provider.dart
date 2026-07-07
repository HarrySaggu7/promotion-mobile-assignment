import 'package:flutter/material.dart';

import '../../products/models/product_model.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addToCart(ProductModel product) {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(
        CartItem(product: product),
      );
    }

    notifyListeners();
  }

  void increaseQuantity(ProductModel product) {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _items.removeWhere(
      (item) => item.product.id == product.id,
    );

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}