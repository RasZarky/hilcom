import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class TransactionTable extends StatelessWidget {
  const TransactionTable({super.key});

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
                'Transaction',
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
              columnSpacing: 30,
              headingTextStyle: const TextStyle(
                color: AppColors.textBody,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              columns: const [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Id Customer')),
                DataColumn(label: Text('Order Date')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Amount')),
              ],
              rows: [
                _buildDataRow(1, '#6545', '01 Oct | 11:29 am', 'Paid', AppColors.primary, '\$64'),
                _buildDataRow(2, '#5412', '01 Oct | 11:29 am', 'Pending', Colors.orange, '\$557'),
                _buildDataRow(3, '#6622', '01 Oct | 11:29 am', 'Paid', AppColors.primary, '\$1.5k'),
                _buildDataRow(4, '#6462', '01 Oct | 11:29 am', 'Paid', AppColors.primary, '\$265'),
                _buildDataRow(5, '#6462', '01 Oct | 11:29 am', 'Paid', AppColors.primary, '\$265'),
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

  DataRow _buildDataRow(int no, String id, String date, String status, Color statusColor, String amount) {
    return DataRow(cells: [
      DataCell(Text('$no.', style: const TextStyle(color: AppColors.heading, fontWeight: FontWeight.w500))),
      DataCell(Text(id, style: const TextStyle(color: AppColors.heading, fontWeight: FontWeight.w500))),
      DataCell(Text(date, style: const TextStyle(color: AppColors.textBody, fontSize: 13))),
      DataCell(Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(status, style: const TextStyle(color: AppColors.heading, fontSize: 13)),
        ],
      )),
      DataCell(Text(amount, style: const TextStyle(color: AppColors.heading, fontWeight: FontWeight.bold))),
    ]);
  }
}
