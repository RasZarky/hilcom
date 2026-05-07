import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final String location = GoRouterState.of(context).matchedLocation;
    
    final Widget sidebarContent = Column(
      children: [
        _buildHeader(context, isDesktop),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const _SidebarSectionTitle(title: 'Main menu'),
              _SidebarItem(
                icon: Icons.grid_view,
                title: 'Dashboard',
                isActive: location == '/admin-dashboard',
                onTap: () {
                  context.go('/admin-dashboard');
                  _handleTap(context, isDesktop);
                },
              ),
              _SidebarItem(
                icon: Icons.shopping_cart_outlined,
                title: 'Order Management',
                isActive: location == '/order-management',
                onTap: () {
                  context.go('/order-management');
                  _handleTap(context, isDesktop);
                },
              ),
              _SidebarItem(
                icon: Icons.people_outline,
                title: 'Customers',
                isActive: location == '/customers',
                onTap: () {
                  context.go('/customers');
                  _handleTap(context, isDesktop);
                },
              ),
              _SidebarItem(
                icon: Icons.confirmation_number_outlined,
                title: 'Coupon Code',
                onTap: () => _handleTap(context, isDesktop),
              ),
              _SidebarItem(
                icon: Icons.category_outlined,
                title: 'Categories',
                isActive: location.startsWith('/categories'),
                onTap: () {
                  context.go('/categories');
                  _handleTap(context, isDesktop);
                },
              ),
              _SidebarItem(
                icon: Icons.swap_horiz_outlined,
                title: 'Transaction',
                isActive: location == '/admin-transactions',
                onTap: () {
                  context.go('/admin-transactions');
                  _handleTap(context, isDesktop);
                },
              ),
              _SidebarItem(
                icon: Icons.star_outline,
                title: 'Brand',
                onTap: () => _handleTap(context, isDesktop),
              ),
              const SizedBox(height: 20),
              const _SidebarSectionTitle(title: 'Product'),
              _SidebarItem(
                icon: Icons.add_circle_outline,
                title: 'Add Products',
                isActive: location == '/add-product',
                onTap: () {
                  context.go('/add-product');
                  _handleTap(context, isDesktop);
                },
              ),
              _SidebarItem(
                icon: Icons.perm_media_outlined,
                title: 'Product Media',
                onTap: () => _handleTap(context, isDesktop),
              ),
              _SidebarItem(
                icon: Icons.list_alt_outlined,
                title: 'Product List',
                onTap: () => _handleTap(context, isDesktop),
              ),
              _SidebarItem(
                icon: Icons.rate_review_outlined,
                title: 'Product Reviews',
                onTap: () => _handleTap(context, isDesktop),
              ),
              const SizedBox(height: 20),
              const _SidebarSectionTitle(title: 'Admin'),
              _SidebarItem(
                icon: Icons.admin_panel_settings_outlined,
                title: 'Admin role',
                onTap: () => _handleTap(context, isDesktop),
              ),
              _SidebarItem(
                icon: Icons.settings_input_component_outlined,
                title: 'Control Authority',
                onTap: () => _handleTap(context, isDesktop),
              ),
            ],
          ),
        ),
        _buildFooter(context, isDesktop),
      ],
    );

    if (isDesktop) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: AppColors.border)),
        ),
        child: sidebarContent,
      );
    } else {
      return Drawer(
        backgroundColor: Colors.white,
        elevation: 16,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: sidebarContent,
      );
    }
  }

  void _handleTap(BuildContext context, bool isDesktop) {
    if (!isDesktop) {
      Scaffold.of(context).closeDrawer();
    }
  }

  Widget _buildHeader(BuildContext context, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.shopping_bag, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          const Text(
            'HILCOM',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.heading,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textBody, size: 24),
              onPressed: () => Scaffold.of(context).closeDrawer(),
            )
          else
            const Icon(Icons.menu_open, color: AppColors.textBody, size: 20),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=admin'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hilcom Admin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text('admin@hilcom.com', style: TextStyle(color: AppColors.textBody, fontSize: 11), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const Icon(Icons.logout, size: 18, color: AppColors.textBody),
            ],
          ),
          const SizedBox(height: 12),
          _SidebarItem(
            icon: Icons.storefront,
            title: 'Your Shop',
            onTap: () {
              context.go('/');
              _handleTap(context, isDesktop);
            },
            trailing: const Icon(Icons.open_in_new, size: 14, color: AppColors.textBody),
          ),
        ],
      ),
    );
  }
}

class _SidebarSectionTitle extends StatelessWidget {
  final String title;
  const _SidebarSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textBody,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final Widget? trailing;

  const _SidebarItem({
    required this.icon,
    required this.title,
    this.isActive = false,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? Colors.white : AppColors.textBody,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.heading.withOpacity(0.8),
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _SidebarSubItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarSubItem({
    required this.title,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.only(left: 48, top: 8, bottom: 8, right: 12),
        margin: const EdgeInsets.only(bottom: 2),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textBody,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
