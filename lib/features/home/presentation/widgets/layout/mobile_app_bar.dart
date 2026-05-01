import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Hilcom',
          style: TextStyle(
              color: AppColors.primary, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(
            icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {}),
      ],
    );
  }
}
