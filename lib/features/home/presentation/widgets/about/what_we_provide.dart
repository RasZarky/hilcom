import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class WhatWeProvide extends StatelessWidget {
  final bool isMobile;
  const WhatWeProvide({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.sell_outlined, 'title': 'Best Prices & Offers', 'desc': 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'},
      {'icon': Icons.grid_view, 'title': 'Wide Assortment', 'desc': 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'},
      {'icon': Icons.local_shipping_outlined, 'title': 'Free Delivery', 'desc': 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'},
      {'icon': Icons.replay_outlined, 'title': 'Easy Returns', 'desc': 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'},
      {'icon': Icons.sentiment_satisfied_alt, 'title': '100% Satisfaction', 'desc': 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'},
      {'icon': Icons.stars, 'title': 'Great Daily Deal', 'desc': 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 60),
      child: Column(
        children: [
          Text('What We Provide?', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 10),
          Container(height: 2, width: 80, color: AppColors.primaryLight),
          const SizedBox(height: 50),
          isMobile
              ? Column(children: items.map((i) => _buildProvideItem(i)).toList())
              : Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: items.map((i) => SizedBox(width: (MediaQuery.of(context).size.width - 160) / 3, child: _buildProvideItem(i))).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildProvideItem(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(item['icon'] as IconData, size: 50, color: AppColors.primary),
          const SizedBox(height: 20),
          Text(item['title'] as String, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading)),
          const SizedBox(height: 15),
          Text(item['desc'] as String, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textBody, height: 1.5)),
          const SizedBox(height: 15),
          const Text('Read more', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
