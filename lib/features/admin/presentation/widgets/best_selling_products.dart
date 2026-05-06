import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class BestSellingProducts extends StatelessWidget {
  const BestSellingProducts({super.key});

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
                'Best selling product',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),
              _buildFilterButton(),
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 40,
              dataRowMaxHeight: 50,
              columnSpacing: 40,
              headingRowColor: WidgetStateProperty.all(const Color(0xFFDEF9EC).withOpacity(0.5)),
              headingTextStyle: const TextStyle(
                color: AppColors.textBody,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              columns: const [
                DataColumn(label: Text('PRODUCT')),
                DataColumn(label: Text('TOTAL ORDER')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('PRICE')),
              ],
              rows: [
                _buildDataRow('Apple iPhone 13', '104', 'Stock', AppColors.primary, '\$999.00'),
                _buildDataRow('Nike Air Jordan', '56', 'Stock out', Colors.red, '\$999.00'),
                _buildDataRow('T-shirt', '266', 'Stock', AppColors.primary, '\$999.00'),
                _buildDataRow('Cross Bag', '506', 'Stock', AppColors.primary, '\$999.00'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.indigo,
                side: BorderSide(color: Colors.indigo.withOpacity(0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Details', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Filter', style: TextStyle(color: Colors.white, fontSize: 12)),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String name, String orders, String status, Color statusColor, String price) {
    return DataRow(cells: [
      DataCell(Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.image, size: 20, color: AppColors.textBody),
          ),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      )),
      DataCell(Text(orders, style: const TextStyle(color: AppColors.textBody, fontSize: 13))),
      DataCell(Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(status, style: const TextStyle(color: AppColors.textBody, fontSize: 13)),
        ],
      )),
      DataCell(Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
    ]);
  }
}
