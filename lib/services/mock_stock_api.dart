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

  // Mock WebSocket data for indices
  static const Map<String, dynamic> _mockIndexData = {
    'NSEIDX_26000': {
      'symbol': 'NSEIDX_26000',
      'ltp': '19,425.35',
      'change': '123.45',
      'changePercent': '0.64',
      'open': '19,301.90',
      'high': '19,450.00',
      'low': '19,250.00',
      'previousClose': '19,301.90'
    },
    'BSEIDX_1': {
      'symbol': 'BSEIDX_1',
      'ltp': '64,363.78',
      'change': '234.56',
      'changePercent': '0.37',
      'open': '64,129.22',
      'high': '64,400.00',
      'low': '64,000.00',
      'previousClose': '64,129.22'
    }
  };

  Stream<Map<String, dynamic>> getMockIndexStream() async* {
    while (true) {
      // Simulate real-time updates with random changes
      final niftyData = Map<String, dynamic>.from(_mockIndexData['NSEIDX_26000']!);
      final sensexData = Map<String, dynamic>.from(_mockIndexData['BSEIDX_1']!);

      // Add small random changes
      niftyData['ltp'] = (double.parse(niftyData['ltp'].toString().replaceAll(',', '')) + 
          (DateTime.now().millisecondsSinceEpoch % 10 - 5)).toStringAsFixed(2);
      sensexData['ltp'] = (double.parse(sensexData['ltp'].toString().replaceAll(',', '')) + 
          (DateTime.now().millisecondsSinceEpoch % 10 - 5)).toStringAsFixed(2);

      yield {
        'NSEIDX_26000': niftyData,
        'BSEIDX_1': sensexData,
      };

      await Future.delayed(const Duration(seconds: 1));
    }
  }
} 