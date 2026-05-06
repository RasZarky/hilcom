import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

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
          const Text(
            'Customer Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.heading,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 30,
              headingRowHeight: 45,
              headingRowColor: WidgetStateProperty.all(const Color(0xFFDEF9EC).withOpacity(0.3)),
              columns: const [
                DataColumn(label: Text('Customer Id', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                DataColumn(label: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                DataColumn(label: Text('Order Count', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                DataColumn(label: Text('Total Spend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
              ],
              rows: List.generate(8, (index) {
                final isEven = index % 2 == 0;
                final statuses = ['Active', 'Active', 'Active', 'Inactive', 'VIP', 'Inactive', 'Active', 'VIP'];
                final names = ['John Doe', 'John Doe', 'John Doe', 'Jane Smith', 'Emily Davis', 'Jane Smith', 'John Doe', 'Emily Davis'];
                
                return _buildDataRow(
                  '#CUST00${index + 1}', 
                  names[index % names.length], 
                  '+1234567890', 
                  '${20 + index}', 
                  '3,450.00', 
                  statuses[index % statuses.length],
                  isEven,
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          _buildPagination(),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String id, String name, String phone, String orders, String spend, String status, bool isEven) {
    Color statusColor;
    switch (status) {
      case 'Active':
        statusColor = AppColors.primary;
        break;
      case 'VIP':
        statusColor = Colors.orange;
        break;
      case 'Inactive':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      color: WidgetStateProperty.all(isEven ? Colors.transparent : Colors.grey[50]),
      cells: [
        DataCell(Text(id, style: const TextStyle(fontSize: 13))),
        DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
        DataCell(Text(phone, style: const TextStyle(fontSize: 13))),
        DataCell(Text(orders, style: const TextStyle(fontSize: 13))),
        DataCell(Text(spend, style: const TextStyle(fontSize: 13))),
        DataCell(Row(
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        )),
        DataCell(Row(
          children: [
            IconButton(icon: const Icon(Icons.chat_bubble_outline, size: 18, color: AppColors.textBody), onPressed: () {}),
            IconButton(icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.textBody), onPressed: () {}),
          ],
        )),
      ],
    );
  }

  Widget _buildPagination() {
    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, size: 16),
          label: const Text('Previous', style: TextStyle(fontSize: 12)),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.heading,
            side: const BorderSide(color: AppColors.border),
          ),
        ),
        const Spacer(),
        _buildPageNumber('1', true),
        _buildPageNumber('2', false),
        _buildPageNumber('3', false),
        _buildPageNumber('4', false),
        _buildPageNumber('5', false),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('....', style: TextStyle(color: AppColors.textBody)),
        ),
        _buildPageNumber('24', false),
        const Spacer(),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.heading,
            side: const BorderSide(color: AppColors.border),
          ),
          child: const Row(
            children: [
              Text('Next', style: TextStyle(fontSize: 12)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageNumber(String number, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
      ),
      child: Text(
        number,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? AppColors.primary : AppColors.heading,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
