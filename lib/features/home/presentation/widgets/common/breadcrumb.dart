import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class Breadcrumb extends StatelessWidget {
  final String currentPage;
  final bool isMobile;

  const Breadcrumb({super.key, required this.currentPage, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 20),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                const Icon(Icons.home, size: 16, color: AppColors.primary),
                const SizedBox(width: 5),
                const Text('Home', style: TextStyle(color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.chevron_right, size: 16, color: AppColors.textBody),
          const SizedBox(width: 10),
          Text(currentPage, style: const TextStyle(color: AppColors.textBody)),
        ],
      ),
    );
  }
}
