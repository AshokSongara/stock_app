import 'package:dio/dio.dart';
import '../models/stock_item.dart';

class StockApi {
  final Dio _dio;
  static const String _baseUrl = 'https://dummyjson.com';

  StockApi() : _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<StockItem>> getStocks() async {
    try {
      final response = await _dio.get('/c/077c-5026-4ce3-b008');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> stockData = responseData['data'] as List<dynamic>;
        
        return stockData.map((json) => StockItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load stocks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load stocks: $e');
    }
  }
} 