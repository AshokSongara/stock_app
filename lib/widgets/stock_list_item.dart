import 'package:flutter/material.dart';
import 'package:flutter_assignment/constants/app_dimensions.dart';
import '../models/stock_item.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class StockListItem extends StatelessWidget {
  final StockItem stock;

  const StockListItem({
    super.key,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    // Parse string values to double, handling null and comma-separated numbers
    final ptsC = double.tryParse(stock.ptsC.replaceAll(',', '')) ?? 0;
    final chgp = double.tryParse(stock.chgp.replaceAll(',', '')) ?? 0;
    final isPositive = ptsC >= 0;
    final changeColor = isPositive ? AppColors.positive : AppColors.negative;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingExtraLarge,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Symbol and Name
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.symbol,
                  style: AppTextStyles.symbol,
                ),
                const SizedBox(height: 4),
                Text(
                  stock.ss,
                  style: AppTextStyles.name,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // LTP
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.ltp.toString(),
                  style: AppTextStyles.ltp,
                ),
                const SizedBox(height: 4),
                Text(
                  'LTP',
                  style: AppTextStyles.label,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Change
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ptsC.toStringAsFixed(2),
                  style: AppTextStyles.change.copyWith(
                    color: changeColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${chgp.toStringAsFixed(2)}%',
                  style: AppTextStyles.changePercent.copyWith(
                    color: changeColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}