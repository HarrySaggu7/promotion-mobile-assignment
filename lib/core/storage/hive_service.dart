import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();

  static const String cartBox = 'cart_box';
  static const String productBox = 'product_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(cartBox);
    await Hive.openBox(productBox);
  }

  static Box getCartBox() {
    return Hive.box(cartBox);
  }

  static Box getProductBox() {
    return Hive.box(productBox);
  }
}