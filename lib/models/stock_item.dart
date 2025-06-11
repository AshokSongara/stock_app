import 'package:equatable/equatable.dart';

class StockItem extends Equatable {
  final String symbol;
  final String ss;
  final String exchange;
  final String type;
  final String holdings;
  final String open;
  final String high;
  final String low;
  final String ltp;
  final String ptsC;
  final String chgp;
  final String trdVol;
  final String trdVolM;
  final String ntP;
  final String mVal;
  final String wkhi;
  final String wklo;
  final String wkhicmAdj;
  final String wklocmAdj;
  final String xDt;
  final String cAct;
  final String previousClose;
  final String dayEndClose;
  final String iislPtsChange;
  final String iislPercChange;
  final String yPC;
  final String mPC;

  const StockItem({
    required this.symbol,
    required this.ss,
    required this.exchange,
    required this.type,
    required this.holdings,
    required this.open,
    required this.high,
    required this.low,
    required this.ltp,
    required this.ptsC,
    required this.chgp,
    required this.trdVol,
    required this.trdVolM,
    required this.ntP,
    required this.mVal,
    required this.wkhi,
    required this.wklo,
    required this.wkhicmAdj,
    required this.wklocmAdj,
    required this.xDt,
    required this.cAct,
    required this.previousClose,
    required this.dayEndClose,
    required this.iislPtsChange,
    required this.iislPercChange,
    required this.yPC,
    required this.mPC,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      symbol: json['symbol']?.toString() ?? '',
      ss: json['ss']?.toString() ?? '',
      exchange: json['exchange']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      holdings: json['holdings']?.toString() ?? '',
      open: json['open']?.toString() ?? '',
      high: json['high']?.toString() ?? '',
      low: json['low']?.toString() ?? '',
      ltp: json['ltp']?.toString() ?? '',
      ptsC: json['ptsC']?.toString() ?? '',
      chgp: json['chgp']?.toString() ?? '',
      trdVol: json['trdVol']?.toString() ?? '',
      trdVolM: json['trdVolM']?.toString() ?? '',
      ntP: json['ntP']?.toString() ?? '',
      mVal: json['mVal']?.toString() ?? '',
      wkhi: json['wkhi']?.toString() ?? '',
      wklo: json['wklo']?.toString() ?? '',
      wkhicmAdj: json['wkhicm_adj']?.toString() ?? '',
      wklocmAdj: json['wklocm_adj']?.toString() ?? '',
      xDt: json['xDt']?.toString() ?? '',
      cAct: json['cAct']?.toString() ?? '',
      previousClose: json['previousClose']?.toString() ?? '',
      dayEndClose: json['dayEndClose']?.toString() ?? '',
      iislPtsChange: json['iislPtsChange']?.toString() ?? '',
      iislPercChange: json['iislPercChange']?.toString() ?? '',
      yPC: json['yPC']?.toString() ?? '',
      mPC: json['mPC']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'ss': ss,
      'exchange': exchange,
      'type': type,
      'holdings': holdings,
      'open': open,
      'high': high,
      'low': low,
      'ltp': ltp,
      'ptsC': ptsC,
      'chgp': chgp,
      'trdVol': trdVol,
      'trdVolM': trdVolM,
      'ntP': ntP,
      'mVal': mVal,
      'wkhi': wkhi,
      'wklo': wklo,
      'wkhicm_adj': wkhicmAdj,
      'wklocm_adj': wklocmAdj,
      'xDt': xDt,
      'cAct': cAct,
      'previousClose': previousClose,
      'dayEndClose': dayEndClose,
      'iislPtsChange': iislPtsChange,
      'iislPercChange': iislPercChange,
      'yPC': yPC,
      'mPC': mPC,
    };
  }

  @override
  List<Object?> get props => [
    symbol,
    ss,
    exchange,
    type,
    holdings,
    open,
    high,
    low,
    ltp,
    ptsC,
    chgp,
    trdVol,
    trdVolM,
    ntP,
    mVal,
    wkhi,
    wklo,
    wkhicmAdj,
    wklocmAdj,
    xDt,
    cAct,
    previousClose,
    dayEndClose,
    iislPtsChange,
    iislPercChange,
    yPC,
    mPC,
  ];
} 