import 'package:equatable/equatable.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object?> get props => [];
}

class StockLoadRequested extends StockEvent {}

class StockDataReceived extends StockEvent {
  final String data;

  const StockDataReceived(this.data);

  @override
  List<Object> get props => [data];
}

class StockErrorOccurred extends StockEvent {
  final String error;

  const StockErrorOccurred(this.error);

  @override
  List<Object> get props => [error];
}

class StockReconnectRequested extends StockEvent {}

class StockLogoutRequested extends StockEvent {}
