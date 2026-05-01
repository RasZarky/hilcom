import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class WebHeader extends StatelessWidget implements PreferredSizeWidget {
  const WebHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            child: const Text('Hilcom',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text('All Categories',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  VerticalDivider(width: 1),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for items...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: AppColors.textBody),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
          const SizedBox(width: 40),
          _buildHeaderAction(Icons.refresh, 'Compare'),
          _buildHeaderAction(Icons.favorite_border, 'Wishlist'),
          _buildHeaderAction(Icons.shopping_cart_outlined, 'Cart'),
          _buildHeaderAction(Icons.person_outline, 'Account'),
        ],
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Icon(icon, size: 24, color: AppColors.heading),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(color: AppColors.heading)),
        ],
      ),
    );
  }
}
