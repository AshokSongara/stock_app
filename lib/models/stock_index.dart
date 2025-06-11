import 'package:equatable/equatable.dart';

class StockIndex extends Equatable {
  final String symbol;
  final String name;
  final String ltp; // Last traded price
  final String change;
  final String changePercent;
  final String open;
  final String high;
  final String low;
  final String previousClose;
  final String yearHigh;
  final String yearLow;
  final String upMoves;
  final String downMoves;
  final String marketCap;

  const StockIndex({
    required this.symbol,
    required this.name,
    required this.ltp,
    required this.change,
    required this.changePercent,
    required this.open,
    required this.high,
    required this.low,
    required this.previousClose,
    required this.yearHigh,
    required this.yearLow,
    required this.upMoves,
    required this.downMoves,
    required this.marketCap,
  });

  factory StockIndex.fromJson(Map<String, dynamic> json) {
    return StockIndex(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      ltp: json['ltp'] as String,
      change: json['chg'] as String,
      changePercent: json['chgp'] as String,
      open: json['open'] as String,
      high: json['high'] as String,
      low: json['low'] as String,
      previousClose: json['pclose'] as String,
      yearHigh: json['yhigh'] as String,
      yearLow: json['ylow'] as String,
      upMoves: json['upmoves'] as String,
      downMoves: json['downmoves'] as String,
      marketCap: json['mcap'] as String,
    );
  }

  @override
  List<Object?> get props => [
        symbol,
        name,
        ltp,
        change,
        changePercent,
        open,
        high,
        low,
        previousClose,
        yearHigh,
        yearLow,
        upMoves,
        downMoves,
        marketCap,
      ];

  // Create a copy of this StockIndex with the given fields replaced with the new values
  StockIndex copyWith({
    String? symbol,
    String? name,
    String? ltp,
    String? change,
    String? changePercent,
    String? open,
    String? high,
    String? low,
    String? previousClose,
    String? yearHigh,
    String? yearLow,
    String? upMoves,
    String? downMoves,
    String? marketCap,
  }) {
    return StockIndex(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      ltp: ltp ?? this.ltp,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      previousClose: previousClose ?? this.previousClose,
      yearHigh: yearHigh ?? this.yearHigh,
      yearLow: yearLow ?? this.yearLow,
      upMoves: upMoves ?? this.upMoves,
      downMoves: downMoves ?? this.downMoves,
      marketCap: marketCap ?? this.marketCap,
    );
  }
}