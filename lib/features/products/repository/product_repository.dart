import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../models/product_model.dart';
import '../../../core/storage/cache_service.dart';

class ProductRepository {
  final Dio _dio = DioClient.dio;

  /// Fetch all products from the Fake Store API
  Future<List<ProductModel>> getProducts() async {
  try {
    final Response response = await _dio.get('/products');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data as List<dynamic>;

      final products = data
          .map(
            (json) => ProductModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();

      // Cache products locally
      await CacheService.saveProducts(products);

      return products;
    } else {
      throw Exception(
        'Failed to load products. Status Code: ${response.statusCode}',
      );
    }
  } on DioException {
    // Offline → return cached products
    final cachedProducts = CacheService.loadProducts();

    if (cachedProducts.isNotEmpty) {
      return cachedProducts;
    }

    rethrow;
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}
}