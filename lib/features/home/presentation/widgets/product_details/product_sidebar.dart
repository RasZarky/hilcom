import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ProductSidebar extends StatelessWidget {
  const ProductSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSidebarCard('Category', [
          _buildSidebarItem('Milks & Dairies', 26),
          _buildSidebarItem('Clothing', 14),
          _buildSidebarItem('Pet Foods', 56),
          _buildSidebarItem('Baking material', 65),
          _buildSidebarItem('Fresh Fruit', 123),
        ]),
        const SizedBox(height: 30),
        _buildSidebarCard('Fill by price', [
          Slider(value: 0.5, onChanged: (v) {}, activeColor: AppColors.primary),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('From: \$0'),
              Text('To: \$2000'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Color', style: TextStyle(fontWeight: FontWeight.bold)),
          CheckboxListTile(
            value: true,
            onChanged: (v) {},
            title: const Text('Red'),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
          CheckboxListTile(
            value: false,
            onChanged: (v) {},
            title: const Text('Green'),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text('Filter'),
          ),
        ]),
        const SizedBox(height: 30),
        _buildSidebarCard('New products', [
          _buildSmallProductItem('Chen Cardigan', 99.50),
          _buildSmallProductItem('Chen Sweater', 89.50),
          _buildSmallProductItem('Colorful Jacket', 25.00),
        ]),
        const SizedBox(height: 30),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=400&auto=format&fit=crop',
            height: 400,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading)),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSidebarItem(String label, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textBody)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10)),
            child: Text('$count',
                style: const TextStyle(color: AppColors.primary, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallProductItem(String title, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/id/1/80/80',
                width: 80,
                height: 80,
                fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.primary)),
                Text('\$$price',
                    style: const TextStyle(color: AppColors.textBody)),
                Row(
                    children: const [
                  Icon(Icons.star, color: AppColors.secondary, size: 14),
                  Icon(Icons.star, color: AppColors.secondary, size: 14)
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
