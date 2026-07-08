import 'package:hive/hive.dart';

import '../../../core/storage/hive_service.dart';

class CartStorageService {
  CartStorageService._();

  static const String cartKey = 'cart_items';

  static Future<void> saveCart(
      Map<int, int> cartData,
      ) async {
    final box = HiveService.getCartBox();

    final data = cartData.entries
        .map(
          (e) => {
        'productId': e.key,
        'quantity': e.value,
      },
    )
        .toList();

    await box.put(cartKey, data);
  }

  static List<Map<String, dynamic>> loadCart() {
    final box = HiveService.getCartBox();

    final data = box.get(cartKey);

    if (data == null) return [];

    return List<Map<String, dynamic>>.from(
      data.map((e) => Map<String, dynamic>.from(e)),
    );
  }

  static Future<void> clearCart() async {
    final box = HiveService.getCartBox();

    await box.delete(cartKey);
  }
}