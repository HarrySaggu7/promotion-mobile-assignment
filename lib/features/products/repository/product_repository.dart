import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductRepository {
  final Dio _dio = DioClient.dio;

  Future<List<ProductModel>> getProducts() async {
    try {
      final Response response = await _dio.get('/products');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data
            .map((json) => ProductModel.fromJson(json))
            .toList();
      }

      throw Exception(
        'Failed to load products. Status Code: ${response.statusCode}',
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';

      case DioExceptionType.sendTimeout:
        return 'Request timeout';

      case DioExceptionType.receiveTimeout:
        return 'Server response timeout';

      case DioExceptionType.badResponse:
        return 'Server error (${e.response?.statusCode})';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      case DioExceptionType.cancel:
        return 'Request cancelled';

      default:
        return e.message ?? 'Something went wrong';
    }
  }
}