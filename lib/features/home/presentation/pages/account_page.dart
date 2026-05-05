import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/footer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final authProvider = context.watch<AuthProvider>();
    final homeProvider = context.watch<HomeProvider>();

    if (!authProvider.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      extendBodyBehindAppBar: true,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context, authProvider, isMobile),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 15 : 50,
                vertical: 30,
              ),
              child: isMobile
                  ? _buildMobileLayout(context, authProvider, homeProvider)
                  : _buildWebLayout(context, authProvider, homeProvider),
            ),
            const SizedBox(height: 60),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, AuthProvider auth, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: isMobile ? 120 : 180,
        bottom: 40,
        left: isMobile ? 20 : 50,
        right: isMobile ? 20 : 50,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 3),
                    ),
                    child: CircleAvatar(
                      radius: isMobile ? 40 : 50,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Icon(Icons.person, size: isMobile ? 40 : 50, color: AppColors.primary),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: TextStyle(
                        color: AppColors.textBody,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      auth.userName ?? 'User Name',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 36,
                        fontWeight: FontWeight.w900,
                        color: AppColors.heading,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      auth.userEmail ?? 'user@email.com',
                      style: const TextStyle(color: AppColors.textBody, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              if (!isMobile)
                ElevatedButton.icon(
                  onPressed: () {
                    auth.logout();
                    context.go('/');
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.05),
                    foregroundColor: Colors.red,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context, AuthProvider auth, HomeProvider home) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildSidebarMenu(context, auth),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 3,
          child: _buildMainContent(context, auth, home),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, AuthProvider auth, HomeProvider home) {
    return Column(
      children: [
        _buildStatsGrid(context, home, true),
        const SizedBox(height: 20),
        _buildSidebarMenu(context, auth),
        const SizedBox(height: 20),
        _buildRecentOrders(context),
      ],
    );
  }

  Widget _buildSidebarMenu(BuildContext context, AuthProvider auth) {
    final menuItems = [
      {'icon': Icons.grid_view_rounded, 'label': 'Dashboard'},
      {'icon': Icons.shopping_bag_outlined, 'label': 'My Orders'},
      {'icon': Icons.favorite_outline_rounded, 'label': 'My Wishlist'},
      {'icon': Icons.location_on_outlined, 'label': 'Shipping Address'},
      {'icon': Icons.credit_card_outlined, 'label': 'Payment Methods'},
      {'icon': Icons.person_outline_rounded, 'label': 'Account Details'},
      {'icon': Icons.settings_outlined, 'label': 'Settings'},
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          ...List.generate(menuItems.length, (index) {
            final isSelected = _selectedTab == index;
            return ListTile(
              onTap: () => setState(() => _selectedTab = index),
              leading: Icon(
                menuItems[index]['icon'] as IconData,
                color: isSelected ? AppColors.primary : AppColors.heading,
              ),
              title: Text(
                menuItems[index]['label'] as String,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.heading,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.transparent,
              trailing: isSelected 
                ? const Icon(Icons.chevron_right, color: AppColors.primary)
                : null,
            );
          }),
          const Divider(height: 30),
          ListTile(
            onTap: () {
              auth.logout();
              context.go('/');
            },
            leading: const Icon(Icons.logout_rounded, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, AuthProvider auth, HomeProvider home) {
    switch (_selectedTab) {
      case 0:
        return Column(
          children: [
            _buildStatsGrid(context, home, false),
            const SizedBox(height: 30),
            _buildRecentOrders(context),
          ],
        );
      default:
        return _buildPlaceholderContent(context, "Under Construction");
    }
  }

  Widget _buildStatsGrid(BuildContext context, HomeProvider home, bool isMobile) {
    return GridView.count(
      crossAxisCount: isMobile ? 2 : 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: isMobile ? 1.5 : 2,
      children: [
        _buildStatCard(
          context,
          'Total Orders',
          '08',
          Icons.local_shipping_outlined,
          Colors.blue,
        ),
        _buildStatCard(
          context,
          'Wishlist Items',
          '${home.wishlistCount}',
          Icons.favorite_outline_rounded,
          Colors.red,
        ),
        _buildStatCard(
          context,
          'Total Cart',
          '${home.cartCount}',
          Icons.shopping_cart_outlined,
          AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.heading, height: 1),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: AppColors.textBody, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrders(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Orders',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading),
          ),
          const SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                Icon(Icons.shopping_bag_outlined, size: 60, color: Colors.grey[200]),
                const SizedBox(height: 15),
                Text(
                  'No orders yet',
                  style: TextStyle(color: AppColors.textBody, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: const Text('Start Shopping'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderContent(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction_rounded, size: 60, color: AppColors.primary.withOpacity(0.3)),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading),
            ),
            const SizedBox(height: 10),
            const Text('We are working hard to bring this feature to you.', style: TextStyle(color: AppColors.textBody)),
          ],
        ),
      ),
    );
  }
}
