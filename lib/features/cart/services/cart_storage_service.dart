import 'package:hive/hive.dart';

import '../../../core/storage/hive_service.dart';

class CartStorageService {
  CartStorageService._();

  static const String _cartKey = 'cart';

  static Future<void> saveCart(
    List<Map<String, dynamic>> items,
  ) async {
    final Box box = HiveService.getCartBox();

    await box.put(_cartKey, items);
  }

  static List<Map<String, dynamic>> loadCart() {
    final Box box = HiveService.getCartBox();

    final dynamic data = box.get(_cartKey);

    if (data == null) {
      return [];
    }

    return (data as List)
        .map(
          (e) => Map<String, dynamic>.from(e as Map),
        )
        .toList();
  }

  static Future<void> clearCart() async {
    final Box box = HiveService.getCartBox();

    await box.delete(_cartKey);
  }
}