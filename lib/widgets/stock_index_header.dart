import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_api.dart';
import '../models/stock_index.dart';

class StockIndexHeader extends StatelessWidget {
  final StockIndex stock;
  final bool showBorder;

  const StockIndexHeader({
    super.key,
    required this.stock,
    this.showBorder = true,
  });

  static Widget buildRow(List<StockIndex> indices) {
    // Find Nifty 50 and Sensex indices
    final niftyIndex = indices.firstWhere(
      (index) => index.symbol == AppApi.niftySymbol,
      orElse: () => const StockIndex(
        symbol: AppApi.niftySymbol,
        ltp: '--',
        change: '0.00',
        changePercent: '0.00',
        open: '--',
        high: '--',
        low: '--',
        previousClose: '--',
        name: 'Nifty 50',
        yearHigh: '--',
        yearLow: '--',
        upMoves: '--',
        downMoves: '--',
        marketCap: '--',
      ),
    );

    final sensexIndex = indices.firstWhere(
      (index) => index.symbol == AppApi.sensexSymbol,
      orElse: () => const StockIndex(
        symbol: AppApi.sensexSymbol,
        ltp: '--',
        change: '0.00',
        changePercent: '0.00',
        open: '--',
        high: '--',
        low: '--',
        previousClose: '--',
        name: 'Sensex',
        yearHigh: '--',
        yearLow: '--',
        upMoves: '--',
        downMoves: '--',
        marketCap: '--',
      ),
    );

    return Row(
      children: [
        Expanded(child: StockIndexHeader(stock: niftyIndex)),
        SizedBox(width: AppDimensions.spacingSmall.w),
        Expanded(child: StockIndexHeader(stock: sensexIndex)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final parsedChange = double.tryParse(stock.change) ?? 0;
    final isPositive = parsedChange >= 0;
    final color = isPositive ? AppColors.stockPositive : AppColors.stockNegative;

    return Container(
      padding: EdgeInsets.all(AppDimensions.containerPaddingExtraSmall.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8.r),
        border: showBorder ? Border.all(color: AppColors.border) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Index Name
          Text(
            stock.name,
            style: AppTextStyles.indexName,
          ),
          // LTP and Change
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LTP
              Text(stock.ltp, style: AppTextStyles.indexValue),
              // Change
              Text(
                '${stock.change} (${stock.changePercent}%)',
                style: AppTextStyles.indexChange.copyWith(color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
