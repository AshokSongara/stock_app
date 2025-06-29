import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter_assignment/services/mock_stock_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../models/stock_index.dart';
import '../../services/auth_repository.dart';
import '../../constants/app_api.dart';
import 'stock_event.dart';
import 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockApi _stockApi;
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  bool _isDisposed = false;

  StockBloc({
    required AuthenticationRepository authRepository,
    required StockApi stockApi,
  })  : _stockApi = stockApi,
        super(StockInitial()) {
    on<StockLoadRequested>(_onStockLoadRequested);
    on<StockDataReceived>(_onStockDataReceived);
    on<StockErrorOccurred>(_onStockErrorOccurred);
    on<StockReconnectRequested>(_onStockReconnectRequested);
    on<StockLogoutRequested>(_onStockLogoutRequested);
  }

  Future<void> _onStockLoadRequested(
    StockLoadRequested event,
    Emitter<StockState> emit,
  ) async {
    try {
      emit(StockLoadInProgress());

      // Initialize WebSocket connection for stock indices
      await _connectWebSocket();

      // Load stock data from API
      final stocks = await _stockApi.getStocks();

      // Create initial stock indices
      final indices = [
        const StockIndex(
          name: 'Nifty 50',
          symbol: AppApi.niftySymbol,
          ltp: '0',
          change: '0',
          changePercent: '0',
          open: '0',
          high: '0',
          low: '0',
          previousClose: '0',
          yearHigh: '',
          yearLow: '',
          upMoves: '',
          downMoves: '',
          marketCap: '',
        ),
        const StockIndex(
          name: 'Sensex',
          symbol: AppApi.sensexSymbol,
          ltp: '0',
          change: '0',
          changePercent: '0',
          open: '0',
          high: '0',
          low: '0',
          previousClose: '0',
          yearHigh: '',
          yearLow: '',
          upMoves: '',
          downMoves: '',
          marketCap: '',
        ),
      ];

      emit(StockLoadSuccess(
        stocks: stocks,
        indices: indices,
        declines: stocks.where((stock) {
          final changePercent = double.tryParse(stock.chgp) ?? 0.0;
          return changePercent < 0;
        }).length,
      ));
    } catch (e) {
      emit(StockLoadFailure(e.toString()));
    }
  }

  Future<void> _connectWebSocket() async {
    try {
      developer.log('Connecting to WebSocket: ${AppApi.webSocketUrl}', name: 'StockBloc');
      
      _channel?.sink.close();
      _channel = WebSocketChannel.connect(Uri.parse(AppApi.webSocketUrl));

      // Subscribe to Nifty 50
      _channel?.sink.add(AppApi.niftySubscription);
      developer.log('Sent Nifty subscription', name: 'StockBloc');

      // Subscribe to Sensex
      _channel?.sink.add(AppApi.sensexSubscription);
      developer.log('Sent Sensex subscription', name: 'StockBloc');

      _channel!.stream.listen(
        (data) {
          if (!_isDisposed) {
            developer.log('Received data: $data', name: 'StockBloc');
            add(StockDataReceived(data));
          }
        },
        onError: (error) {
          developer.log('WebSocket error: $error', name: 'StockBloc');
          if (!_isDisposed) {
            add(StockErrorOccurred(error.toString()));
          }
        },
        onDone: () {
          developer.log('WebSocket connection closed', name: 'StockBloc');
          if (!_isDisposed) {
            _scheduleReconnect();
          }
        },
      );
    } catch (e) {
      developer.log('Error connecting to WebSocket: $e', name: 'StockBloc');
      if (!_isDisposed) {
        add(StockErrorOccurred(e.toString()));
        _scheduleReconnect();
      }
    }
  }

  void _onStockDataReceived(
    StockDataReceived event,
    Emitter<StockState> emit,
  ) {
    try {
      if (state is StockLoadSuccess) {
        final currentState = state as StockLoadSuccess;
        final data = event.data.toString().trim();

        // Skip empty data
        if (data.isEmpty) {
          return;
        }

        // Parse the pipe-separated data
        final parts = data.split('|');
        if (parts.length < 7) {
          developer.log('Invalid data format: $data', name: 'StockBloc');
          return;
        }

        final exchange = parts[0]; // NSEIDX or BSEIDX
        final currentValue = parts[2]; // Current index value
        final high = parts[3];
        final low = parts[4];
        final open = parts[5];
        final close = parts[6];
        final percentChange = parts.length > 7 ? parts[7] : '0.0';

        // Construct the symbol
        String symbol;
        if (exchange == 'NSEIDX') {
          symbol = AppApi.niftySymbol;
        } else if (exchange == 'BSEIDX') {
          symbol = AppApi.sensexSymbol;
        } else {
          return;
        }

        // Calculate change
        final currentPrice = double.tryParse(currentValue) ?? 0.0;
        final previousClose = double.tryParse(close) ?? 0.0;
        final change = currentPrice - previousClose;

        // Update the corresponding index
        final updatedIndices = currentState.indices.map((index) {
          if (index.symbol == symbol) {
            return index.copyWith(
              ltp: currentValue,
              change: change.toStringAsFixed(2),
              changePercent: percentChange,
              open: open,
              high: high,
              low: low,
              previousClose: close,
            );
          }
          return index;
        }).toList();

        emit(currentState.copyWith(indices: updatedIndices));
      }
    } catch (e) {
      developer.log('Error processing stock data: $e', name: 'StockBloc');
    }
  }

  void _onStockErrorOccurred(
    StockErrorOccurred event,
    Emitter<StockState> emit,
  ) {
    emit(StockLoadFailure(event.error));
    _scheduleReconnect();
  }

  void _onStockReconnectRequested(
    StockReconnectRequested event,
    Emitter<StockState> emit,
  ) async {
    if (!_isDisposed) {
      await _connectWebSocket();
    }
  }

  void _onStockLogoutRequested(
    StockLogoutRequested event,
    Emitter<StockState> emit,
  ) {
    // Implementation of logout logic
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(
      const Duration(seconds: AppApi.reconnectDelaySeconds),
      () {
        if (!_isDisposed) {
          add(StockReconnectRequested());
        }
      },
    );
  }

  @override
  Future<void> close() {
    _isDisposed = true;
    _channel?.sink.close();
    _reconnectTimer?.cancel();
    return super.close();
  }
}
