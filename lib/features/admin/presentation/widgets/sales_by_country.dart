import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class SalesByCountry extends StatelessWidget {
  const SalesByCountry({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sales by Country',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),
              const Text('Sales', style: TextStyle(color: AppColors.textBody, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),
          _buildCountryRow('US', 30, 25.8, true, Colors.blue),
          _buildCountryRow('Brazil', 30, 15.8, false, Colors.green),
          _buildCountryRow('Australia', 25, 35.6, true, Colors.red),
          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('View Insight', style: TextStyle(color: Colors.indigo, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryRow(String country, int value, double percentage, bool isPositive, Color flagColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 18,
            decoration: BoxDecoration(
              color: flagColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(Icons.flag, size: 12, color: flagColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${value}k', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Row(
                      children: [
                        Icon(
                          isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                          size: 10,
                          color: isPositive ? AppColors.primary : Colors.red,
                        ),
                        Text(
                          '${percentage.abs()}%',
                          style: TextStyle(
                            fontSize: 10,
                            color: isPositive ? AppColors.primary : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(country, style: const TextStyle(color: AppColors.textBody, fontSize: 11)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: value / 40,
                    backgroundColor: Colors.grey[100],
                    color: Colors.indigo,
                    minHeight: 6,
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
