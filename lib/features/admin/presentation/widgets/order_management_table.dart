import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';

class OrderManagementTable extends StatelessWidget {
  const OrderManagementTable({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    hintText: 'Search order report',
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
              hintText: 'Search order report',
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
      margin: const EdgeInsets.only(right: 4),
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
        columnSpacing: 30,
        headingRowHeight: 45,
        headingRowColor: WidgetStateProperty.all(const Color(0xFFDEF9EC).withOpacity(0.3)),
        columns: const [
          DataColumn(label: Text('No.', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Order Id', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Product', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Payment', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: [
          _buildDataRow(1, '#ORD0001', 'Wireless Bluetooth Headphones', '01-01-2025', '49.99', 'Paid', 'Delivered'),
          _buildDataRow(2, '#ORD0002', "Men's T-Shirt", '01-01-2025', '14.99', 'Unpaid', 'Pending'),
          _buildDataRow(3, '#ORD0003', "Men's Leather Wallet", '01-01-2025', '49.99', 'Paid', 'Delivered'),
          _buildDataRow(4, '#ORD0004', 'Memory Foam Pillow', '01-01-2025', '39.99', 'Paid', 'Shipped'),
          _buildDataRow(5, '#ORD0005', 'Adjustable Dumbbells', '01-01-2025', '14.99', 'Unpaid', 'Pending'),
          _buildDataRow(6, '#ORD0006', 'Coffee Maker', '01-01-2025', '79.99', 'Unpaid', 'Cancelled'),
        ],
      ),
    );
  }

  DataRow _buildDataRow(int no, String id, String product, String date, String price, String payment, String status) {
    Color statusColor;
    IconData statusIcon;
    
    switch (status.toLowerCase()) {
      case 'delivered':
        statusColor = AppColors.primary;
        statusIcon = Icons.local_shipping_outlined;
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case 'shipped':
        statusColor = Colors.blue;
        statusIcon = Icons.local_post_office_outlined;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel_outlined;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return DataRow(cells: [
      DataCell(Text('$no')),
      DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.w500))),
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
          const SizedBox(width: 10),
          SizedBox(width: 150, child: Text(product, overflow: TextOverflow.ellipsis)),
        ],
      )),
      DataCell(Text(date)),
      DataCell(Text(price)),
      DataCell(Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: payment == 'Paid' ? AppColors.primary : Colors.red, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(payment),
        ],
      )),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(statusIcon, size: 14, color: statusColor),
            const SizedBox(width: 4),
            Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      )),
      DataCell(IconButton(
        icon: const Icon(Icons.more_vert, size: 20),
        onPressed: () {},
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
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
