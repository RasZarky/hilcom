import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

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
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildTable(context),
          const SizedBox(height: 20),
          _buildPagination(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabs(),
              const SizedBox(height: 16),
              _buildSearchAndFilters(context),
            ],
          )
        : Row(
            children: [
              _buildTabs(),
              const Spacer(),
              _buildSearchAndFilters(context),
            ],
          );
  }

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTab('All Product (145)', true),
          _buildTab('Featured Products', false),
          _buildTab('On Sale', false),
          _buildTab('Out of Stock', false),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Row(
      children: [
        SizedBox(
          width: isMobile ? 150 : 200,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search product',
              hintStyle: const TextStyle(fontSize: 12),
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
        _buildIconButton(Icons.add_box_outlined),
        const SizedBox(width: 8),
        _buildIconButton(Icons.more_horiz),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: AppColors.textBody),
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
          DataColumn(label: Text('No.', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Product', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Created Date', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Order', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: [
          _buildDataRow(1, 'Wireless Bluetooth Headphones', '01-01-2025', '25'),
          _buildDataRow(2, "Men's T-Shirt", '01-01-2025', '20'),
          _buildDataRow(3, "Men's Leather Wallet", '01-01-2025', '35'),
          _buildDataRow(4, 'Memory Foam Pillow', '01-01-2025', '10'),
          _buildDataRow(5, 'Coffee Maker', '01-01-2025', '45'),
          _buildDataRow(6, 'Casual Baseball Cap', '01-01-2025', '55'),
          _buildDataRow(7, 'Full HD Webcam', '01-01-2025', '20'),
          _buildDataRow(8, 'Smart LED Color Bulb', '01-01-2025', '16'),
        ],
      ),
    );
  }

  DataRow _buildDataRow(int no, String name, String date, String order) {
    return DataRow(cells: [
      DataCell(Text('$no')),
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
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      )),
      DataCell(Text(date)),
      DataCell(Text(order)),
      DataCell(Row(
        children: [
          IconButton(icon: const Icon(Icons.edit_outlined, size: 18), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () {}),
        ],
      )),
    ]);
  }

  Widget _buildPagination(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isMobile)
          _buildIconButton(Icons.arrow_back)
        else
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, size: 16),
            label: const Text('Previous', style: TextStyle(fontSize: 12)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.heading,
              side: const BorderSide(color: AppColors.border),
            ),
          ),
        if (!isMobile) const Spacer(),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPageNumber('1', true),
                _buildPageNumber('2', false),
                if (!isMobile) ...[
                  _buildPageNumber('3', false),
                  _buildPageNumber('4', false),
                  _buildPageNumber('5', false),
                ],
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('....'),
                ),
                _buildPageNumber('24', false),
              ],
            ),
          ),
        ),
        if (!isMobile) const Spacer(),
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
          color: isActive ? AppColors.primary : AppColors.heading,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}
