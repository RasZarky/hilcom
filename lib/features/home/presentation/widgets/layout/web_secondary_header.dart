import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class WebSecondaryHeader extends StatelessWidget {
  final String currentPage;
  const WebSecondaryHeader({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () => context.push('/sell-to-hilcom'),
            icon: const Icon(Icons.question_mark),
            label: const Text('Have products to sell?'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          const SizedBox(width: 20),
          _buildNavLink(context, 'Home', '/'),
          const SizedBox(width: 20),
          _buildNavLink(context, 'About', '/about'),
          const SizedBox(width: 20),
          _buildNavLink(context, 'Shop', '#'),
          const SizedBox(width: 20),
          _buildNavLink(context, 'My Products', '/my-products'),
          const SizedBox(width: 20),
          _buildNavLink(context, 'Contact', '/contact'),
          const Spacer(),
          const Icon(Icons.headset_mic_outlined, color: AppColors.textBody),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('+233 55 167 8559',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              Text('24/7 Support Center', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String label, String route) {
    final bool isActive = currentPage == label;
    return GestureDetector(
      onTap: route == '#' ? null : () => context.go(route),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.primary : AppColors.heading,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
