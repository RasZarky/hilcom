import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';

class TransactionHistoryTable extends StatelessWidget {
  const TransactionHistoryTable({super.key});

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
        children: [
          _buildFilters(context),
          const SizedBox(height: 20),
          _buildTable(context),
          const SizedBox(height: 20),
          _buildPagination(context),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    
    if (isMobile) {
      return Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTab('All order (240)', true),
                _buildTab('Completed', false),
                _buildTab('Pending', false),
                _buildTab('Canceled', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search payment history',
                    hintStyle: const TextStyle(fontSize: 13),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildIconButton(Icons.filter_list),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        _buildTab('All order (240)', true),
        _buildTab('Completed', false),
        _buildTab('Pending', false),
        _buildTab('Canceled', false),
        const Spacer(),
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search payment history',
              hintStyle: const TextStyle(fontSize: 13),
              prefixIcon: const Icon(Icons.search, size: 18),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _buildIconButton(Icons.filter_list),
        const SizedBox(width: 8),
        _buildIconButton(Icons.swap_vert),
        const SizedBox(width: 8),
        _buildIconButton(Icons.more_horiz),
      ],
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.primary : AppColors.textBody,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: AppColors.textBody),
    );
  }

  Widget _buildTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 40,
        headingRowHeight: 45,
        headingRowColor: WidgetStateProperty.all(const Color(0xFFDEF9EC).withOpacity(0.3)),
        columns: const [
          DataColumn(label: Text('Customer Id', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Method', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: [
          _buildDataRow('#CUST001', 'John Doe', '01-01-2025', r'$2,904', 'CC', 'Complete'),
          _buildDataRow('#CUST001', 'John Doe', '01-01-2025', r'$2,904', 'PayPal', 'Complete'),
          _buildDataRow('#CUST001', 'John Doe', '01-01-2025', r'$2,904', 'CC', 'Complete'),
          _buildDataRow('#CUST001', 'John Doe', '01-01-2025', r'$2,904', 'Bank', 'Complete'),
          _buildDataRow('#CUST001', 'Jane Smith', '01-01-2025', r'$2,904', 'CC', 'Cancelled'),
          _buildDataRow('#CUST001', 'Emily Davis', '01-01-2025', r'$2,904', 'PayPal', 'Pending'),
          _buildDataRow('#CUST001', 'Jane Smith', '01-01-2025', r'$2,904', 'Bank', 'Cancelled'),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String id, String name, String date, String total, String method, String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'complete':
        statusColor = AppColors.primary;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(cells: [
      DataCell(Text(id)),
      DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
      DataCell(Text(date)),
      DataCell(Text(total, style: const TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text(method)),
      DataCell(Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(status, style: TextStyle(color: statusColor, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      )),
      DataCell(TextButton(
        onPressed: () {},
        child: const Text('View Details', style: TextStyle(color: Colors.indigo, fontSize: 12)),
      )),
    ]);
  }

  Widget _buildPagination(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    
    return Row(
      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
      children: [
        if (isMobile)
          _buildIconButton(Icons.arrow_back)
        else
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, size: 16),
            label: const Text('Previous'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.heading,
              side: const BorderSide(color: AppColors.border),
            ),
          ),
        if (isMobile) const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPageNumber('1', true),
            _buildPageNumber('2', false),
            if (!isMobile) ...[
              _buildPageNumber('3', false),
              _buildPageNumber('4', false),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text('....'),
            ),
            _buildPageNumber('24', false),
          ],
        ),
        if (isMobile) const SizedBox(width: 8),
        if (isMobile)
          _buildIconButton(Icons.arrow_forward)
        else
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.heading,
              side: const BorderSide(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Text('Next'),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPageNumber(String number, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: isActive ? AppColors.primary : AppColors.heading,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}
