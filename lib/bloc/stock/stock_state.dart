import 'package:equatable/equatable.dart';
import '../../models/stock_index.dart';
import '../../models/stock_item.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object?> get props => [];
}

class StockInitial extends StockState {}

class StockLoadInProgress extends StockState {}

class StockLoadSuccess extends StockState {
  final List<StockIndex> indices;
  final List<StockItem> stocks;
  final int declines;

  const StockLoadSuccess({
    required this.indices,
    required this.stocks,
    required this.declines,
  });

  @override
  List<Object> get props => [indices, stocks, declines];

  StockLoadSuccess copyWith({
    List<StockIndex>? indices,
    List<StockItem>? stocks,
    int? declines,
  }) {
    return StockLoadSuccess(
      indices: indices ?? this.indices,
      stocks: stocks ?? this.stocks,
      declines: declines ?? this.declines,
    );
  }
}
class StockLoadFailure extends StockState {
  final String error;

  const StockLoadFailure(this.error);

  @override
  List<Object> get props => [error];
} 