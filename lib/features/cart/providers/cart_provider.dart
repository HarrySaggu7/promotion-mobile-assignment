import 'package:flutter/material.dart';

import '../../products/models/product_model.dart';
import '../models/cart_item.dart';
import '../services/cart_storage_service.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Save current cart to Hive
  void _saveCart() {
    final cartData = _items
        .map(
          (item) => {
            'productId': item.product.id,
            'quantity': item.quantity,
          },
        )
        .toList();

    // Fire-and-forget. We don't need to await this.
    CartStorageService.saveCart(cartData);
  }

  /// Restore cart from Hive
  void restoreCart(List<ProductModel> products) {
    _items.clear();

    final savedCart = CartStorageService.loadCart();

    for (final item in savedCart) {
      final productId = item['productId'] as int;
      final quantity = item['quantity'] as int;

      try {
        final product = products.firstWhere(
          (p) => p.id == productId,
        );

        _items.add(
          CartItem(
            product: product,
            quantity: quantity,
          ),
        );
      } catch (_) {
        // Ignore products that no longer exist
      }
    }

    notifyListeners();
  }

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

    _saveCart();
    notifyListeners();
  }

  void increaseQuantity(ProductModel product) {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) return;

    _items[index].quantity++;

    _saveCart();
    notifyListeners();
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

    _saveCart();
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _items.removeWhere(
      (item) => item.product.id == product.id,
    );

    _saveCart();
    notifyListeners();
  }

  void clearCart() {
    _items.clear();

    CartStorageService.clearCart();

    notifyListeners();
  }
}