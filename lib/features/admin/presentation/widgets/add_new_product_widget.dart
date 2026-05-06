import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class AddNewProductWidget extends StatelessWidget {
  const AddNewProductWidget({super.key});

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
                'Add New Product',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.heading),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline, size: 16, color: Colors.indigo),
                label: const Text('Add New', style: TextStyle(color: Colors.indigo, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Categories', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
          const SizedBox(height: 12),
          _buildCategoryItem(Icons.electrical_services, 'Electronic'),
          _buildCategoryItem(Icons.checkroom, 'Fashion'),
          _buildCategoryItem(Icons.home_outlined, 'Home'),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('See more', style: TextStyle(color: AppColors.textBody, fontSize: 12)),
            ),
          ),
          const Divider(),
          const Text('Product', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
          const SizedBox(height: 12),
          _buildProductActionItem('Smart Fitness Tracker', '\$39.99'),
          _buildProductActionItem('Leather Wallet', '\$19.99'),
          _buildProductActionItem('Electric Hair Trimmer', '\$34.99'),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('See more', style: TextStyle(color: AppColors.textBody, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textBody, size: 20),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          const Icon(Icons.chevron_right, size: 18, color: AppColors.textBody),
        ],
      ),
    );
  }

  Widget _buildProductActionItem(String title, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, size: 24, color: AppColors.textBody),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(price, style: const TextStyle(color: AppColors.textBody, fontSize: 11)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(0, 30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Row(
              children: [
                Icon(Icons.add, size: 14),
                Text('Add', style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
