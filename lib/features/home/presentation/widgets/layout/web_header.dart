import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../../providers/home_provider.dart';

class WebHeader extends StatelessWidget implements PreferredSizeWidget {
  const WebHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go('/'),
                    child: Hero(
                      tag: 'logo-img',
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Hilcom',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'All Categories',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                          VerticalDivider(
                            width: 1,
                            indent: 10,
                            endIndent: 10,
                            color: AppColors.primary.withValues(alpha: 0.2),
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                context.read<HomeProvider>().setSearchQuery(value);
                              },
                              decoration: const InputDecoration(
                                hintText: 'Search for items...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                hintStyle: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                          Icon(Icons.search, color: AppColors.primary.withValues(alpha: 0.7)),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  _buildHeaderAction(Icons.favorite_outline_rounded, 'Wishlist', onTap: () => context.go('/wishlist')),
                  Consumer<HomeProvider>(
                    builder: (context, provider, _) {
                      return _buildHeaderAction(
                        Icons.shopping_cart_outlined,
                        'Cart',
                        badge: provider.cartCount > 0 ? '${provider.cartCount}' : null,
                        onTap: () => context.go('/cart'),
                      );
                    },
                  ),
                  _buildHeaderAction(Icons.inventory_2_outlined, 'My Products', onTap: () => context.go('/my-products')),
                  _buildHeaderAction(Icons.person_outline_rounded, 'Account'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, String label, {String? badge, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 24, color: AppColors.heading),
                if (badge != null)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        badge,
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: AppColors.heading, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
