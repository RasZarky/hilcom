import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../../providers/home_provider.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                // Separate Floating Glass Circle for Custom Hamburger
                _buildGlassCircle(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const _CustomHamburger(),
                ),
                const SizedBox(width: 12),
                // Main Glassmorphic AppBar Container
                Expanded(
                  child: _buildGlassContainer(
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => context.go('/'),
                          child: Hero(
                            tag: 'logo-img',
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 28,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Hilcom',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.search_rounded, 
                            color: AppColors.heading, size: 22),
                          onPressed: () {},
                        ),
                        _buildCartAction(context),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildGlassCircle({required VoidCallback onTap, required Widget child}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassContainer({required Widget child}) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(27),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildCartAction(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined,
                  color: AppColors.heading, size: 22),
              onPressed: () => context.push('/cart'),
            ),
            if (provider.cartCount > 0)
              Positioned(
                top: 10,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16, minHeight: 16,
                  ),
                  child: Text(
                    '${provider.cartCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      }
    );
  }
}

class _CustomHamburger extends StatelessWidget {
  const _CustomHamburger();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLine(22, 2.5),
        const SizedBox(height: 5),
        _buildLine(14, 2.5),
        const SizedBox(height: 5),
        _buildLine(18, 2.5),
      ],
    );
  }

  Widget _buildLine(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
