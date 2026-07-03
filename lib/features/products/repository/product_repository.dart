import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductRepository {
  final Dio _dio = DioClient.dio;

  /// Fetch all products from the Fake Store API
  Future<List<ProductModel>> getProducts() async {
    try {
      final Response response = await _dio.get('/products');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;

        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load products. Status Code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception(_handleDioException(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  String _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please try again.';

      case DioExceptionType.sendTimeout:
        return 'Request timed out. Please try again.';

      case DioExceptionType.receiveTimeout:
        return 'Server response timed out.';

      case DioExceptionType.connectionError:
        return 'No internet connection.';

      case DioExceptionType.badResponse:
        return 'Server error (${e.response?.statusCode}).';

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.badCertificate:
        return 'Invalid server certificate.';

      case DioExceptionType.unknown:
        return e.message ?? 'An unknown error occurred.';
    }
  }
}