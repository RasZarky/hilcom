import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/home_provider.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  void _navigateToPage(BuildContext context, String route, bool isLoggedIn) {
    context.pop(); // Close drawer
    if (isLoggedIn) {
      context.go(route);
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final authProvider = context.watch<AuthProvider>();
    final homeProvider = context.watch<HomeProvider>();

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: Colors.transparent, // Required for Glassmorphism
      child: Stack(
        children: [
          // 1. Glass Background
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  border: Border(
                    right: BorderSide(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Content
          Column(
            children: [
              _buildModernHeader(context),
              
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildSectionTitle('DISCOVER'),
                    _buildMenuItem(
                      context,
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home_rounded,
                      label: 'Home',
                      onTap: () {
                        context.pop();
                        context.go('/');
                      },
                      isActive: currentPath == '/',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.info_outline_rounded,
                      activeIcon: Icons.info_rounded,
                      label: 'About Us',
                      onTap: () {
                        context.pop();
                        context.go('/about');
                      },
                      isActive: currentPath == '/about',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.contact_support_outlined,
                      activeIcon: Icons.contact_support_rounded,
                      label: 'Contact',
                      onTap: () {
                        context.pop();
                        context.go('/contact');
                      },
                      isActive: currentPath == '/contact',
                    ),

                    const SizedBox(height: 25),
                    _buildSectionTitle('YOUR HILCOM'),
                    _buildMenuItem(
                      context,
                      icon: Icons.person_outline_rounded,
                      activeIcon: Icons.person_rounded,
                      label: 'Account',
                      onTap: () => _navigateToPage(context, '/account', authProvider.isLoggedIn),
                      isActive: currentPath == '/account',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.inventory_2_outlined,
                      activeIcon: Icons.inventory_2_rounded,
                      label: 'My Products',
                      onTap: () => _navigateToPage(context, '/my-products', authProvider.isLoggedIn),
                      isActive: currentPath == '/my-products',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.favorite_outline_rounded,
                      activeIcon: Icons.favorite_rounded,
                      label: 'My Wishlist',
                      onTap: () => _navigateToPage(context, '/wishlist', authProvider.isLoggedIn),
                      isActive: currentPath == '/wishlist',
                      badge: homeProvider.wishlistCount > 0 ? '${homeProvider.wishlistCount}' : null,
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.shopping_cart_outlined,
                      activeIcon: Icons.shopping_cart_rounded,
                      label: 'My Cart',
                      onTap: () => _navigateToPage(context, '/cart', authProvider.isLoggedIn),
                      isActive: currentPath == '/cart',
                      badge: homeProvider.cartCount > 0 ? '${homeProvider.cartCount}' : null,
                    ),

                    const SizedBox(height: 30),
                    // Special Promo Card
                    _buildPromoCard(),
                  ],
                ),
              ),

              _buildFooter(context, authProvider),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // Background Color Shape
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // Header Info
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hilcom',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.heading,
                        ),
                      ),
                      Text(
                        'Quality Groceries',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textBody.withValues(alpha: 0.5),
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required VoidCallback onTap,
    required bool isActive,
    String? badge,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? Colors.white : AppColors.heading.withValues(alpha: 0.7),
                size: 22,
              ),
              const SizedBox(width: 15),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.heading,
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.badgeHot,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                )
              else if (isActive)
                const Icon(Icons.circle, color: Colors.white, size: 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.flash_on_rounded, color: AppColors.secondary, size: 30),
          const SizedBox(height: 15),
          const Text(
            'Special Summer Sale',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            'Get up to 50% off on all fresh products.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AuthProvider auth) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Divider(color: AppColors.border),
          const SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryLight,
                child: Icon(
                  auth.isLoggedIn ? Icons.person : Icons.person_outline, 
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auth.isLoggedIn ? (auth.userName ?? 'User') : 'Welcome Guest', 
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.heading),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      auth.isLoggedIn ? 'Manage your account' : 'Sign in to your account', 
                      style: const TextStyle(fontSize: 11, color: AppColors.textBody),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  context.pop();
                  if (auth.isLoggedIn) {
                    context.go('/account');
                  } else {
                    context.go('/login');
                  }
                },
                icon: Icon(
                  auth.isLoggedIn ? Icons.settings_outlined : Icons.login_rounded, 
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
