import 'package:hive/hive.dart';

import '../../features/products/models/product_model.dart';
import 'hive_service.dart';

class CacheService {
  CacheService._();

  static const String _productsKey = 'products';

  /// Save all products to Hive
  static Future<void> saveProducts(
    List<ProductModel> products,
  ) async {
    final Box box = HiveService.getProductBox();

    final List<Map<String, dynamic>> jsonList =
        products.map((e) => e.toJson()).toList();

    await box.put(_productsKey, jsonList);
  }

  /// Load cached products
 static List<ProductModel> loadProducts() {
  final box = HiveService.getProductBox();

  final data = box.get(_productsKey);

  if (data == null) {
    return [];
  }

  return (data as List)
      .map(
        (item) => ProductModel.fromJson(
          Map<String, dynamic>.from(item as Map),
        ),
      )
      .toList();
}

  /// Clear cache
  static Future<void> clearProducts() async {
    final Box box = HiveService.getProductBox();

    await box.delete(_productsKey);
  }
}