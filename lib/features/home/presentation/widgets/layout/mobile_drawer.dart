import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Text(
              'Hilcom',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.pop();
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              context.pop();
              context.go('/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shop_outlined),
            title: const Text('Shop'),
            onTap: () => context.pop(),
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail_outlined),
            title: const Text('Contact'),
            onTap: () {
              context.pop();
              context.go('/contact');
            },
          ),
        ],
      ),
    );
  }
}
