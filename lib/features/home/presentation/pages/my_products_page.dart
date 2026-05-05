import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/web_secondary_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!isMobile) const WebSecondaryHeader(currentPage: 'My Products'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 50,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Products',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Track the status of products you\'ve sent to be sold.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textBody.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildProductsList(context, isMobile),
                ],
              ),
            ),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsList(BuildContext context, bool isMobile) {
    // Mock data for products sent to be sold
    final List<Map<String, dynamic>> products = [
      {
        'name': 'Samsung Double Door Fridge',
        'date': 'Nov 12, 2023',
        'status': 'Approved',
        'price': 'GH₵ 850.00',
        'quantity': '1 unit',
        'color': Colors.green,
      },
      {
        'name': 'Modern Wooden Wardrobe',
        'date': 'Nov 10, 2023',
        'status': 'Pending',
        'price': 'GH₵ 450.00',
        'quantity': '1 unit',
        'color': Colors.orange,
      },
      {
        'name': 'Honda CBR 150R Motorbike',
        'date': 'Nov 08, 2023',
        'status': 'In Review',
        'price': 'GH₵ 2,500.00',
        'quantity': '1 unit',
        'color': Colors.blue,
      },
      {
        'name': 'HP Pavilion Laptop',
        'date': 'Nov 05, 2023',
        'status': 'Sold',
        'price': 'GH₵ 1,200.00',
        'quantity': '1 unit',
        'color': AppColors.primary,
      },
    ];

    if (isMobile) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.heading,
                      ),
                    ),
                    _buildStatusBadge(product['status'] as String, product['color'] as Color),
                  ],
                ),
                const SizedBox(height: 10),
                _buildInfoRow('Date Sent:', product['date'] as String),
                _buildInfoRow('Quantity:', product['quantity'] as String),
                _buildInfoRow('Est. Value:', product['price'] as String),
              ],
            ),
          );
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            children: [
              _buildTableHeader('Product'),
              _buildTableHeader('Date Sent'),
              _buildTableHeader('Quantity'),
              _buildTableHeader('Est. Value'),
              _buildTableHeader('Status'),
            ],
          ),
          ...products.map((product) => TableRow(
            children: [
              _buildTableCell(product['name'] as String, isBold: true),
              _buildTableCell(product['date'] as String),
              _buildTableCell(product['quantity'] as String),
              _buildTableCell(product['price'] as String),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: _buildStatusBadge(
                    product['status'] as String,
                    product['color'] as Color,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String label) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTableCell(String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        value,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: AppColors.heading,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.textBody),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.heading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
