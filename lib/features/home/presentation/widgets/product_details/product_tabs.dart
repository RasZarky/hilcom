import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ProductTabs extends StatefulWidget {
  final bool isMobile;
  const ProductTabs({super.key, required this.isMobile});

  @override
  State<ProductTabs> createState() => _ProductTabsState();
}

class _ProductTabsState extends State<ProductTabs> {
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.isMobile ? 20 : 40),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTab('Description', 0),
                _buildTab('Additional info', 1),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildActiveTabContent(),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final bool isActive = _activeTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTabIndex = index),
      child: Container(
        margin: const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  bottom: BorderSide(color: AppColors.primary, width: 2))
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textBody,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTabContent() {
    switch (_activeTabIndex) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Unbelievable comfort and style. Our premium organic quinoa is sourced from the best farms, ensuring a healthy and delicious meal every time. It is rich in protein and fiber, making it a perfect addition to any diet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac dui sed nunc sagittis rhoncus at a mi. Aliquam hendrerit pulvinar mollis. Donec ut sem.',
              style: TextStyle(color: AppColors.textBody, height: 1.6),
            ),
            const SizedBox(height: 30),
            const Text(
              'Packaging & Delivery',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading),
            ),
            const SizedBox(height: 15),
            const Text(
              'Less than 24 hours delivery within the city. International shipping available. We take great care in packaging our products to ensure they arrive in perfect condition.',
              style: TextStyle(color: AppColors.textBody, height: 1.6),
            ),

          ],
        );
      default:
        return const Center(child: Text('Content coming soon...'));
    }
  }
}
