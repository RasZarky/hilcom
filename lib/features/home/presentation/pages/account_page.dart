import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/footer.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final authProvider = context.watch<AuthProvider>();

    if (!authProvider.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: isMobile ? 120 : 150),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Account',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 30),
                  if (isMobile)
                    Column(
                      children: [
                        _buildProfileCard(context, authProvider),
                        const SizedBox(height: 20),
                        _buildAccountMenu(context),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _buildAccountMenu(context)),
                        const SizedBox(width: 40),
                        Expanded(flex: 3, child: _buildProfileDetails(context, authProvider)),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, AuthProvider auth) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(Icons.person, size: 40, color: AppColors.primary),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  auth.userName ?? 'User Name',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  auth.userEmail ?? 'user@email.com',
                  style: const TextStyle(color: AppColors.textBody),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountMenu(BuildContext context) {
    final menuItems = [
      {'icon': Icons.dashboard_outlined, 'label': 'Dashboard'},
      {'icon': Icons.shopping_bag_outlined, 'label': 'Orders'},
      {'icon': Icons.favorite_outline, 'label': 'Wishlist'},
      {'icon': Icons.location_on_outlined, 'label': 'Addresses'},
      {'icon': Icons.person_outline, 'label': 'Account Details'},
      {'icon': Icons.logout, 'label': 'Logout', 'color': Colors.red},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: menuItems.map((item) {
          final isLogout = item['label'] == 'Logout';
          return ListTile(
            leading: Icon(
              item['icon'] as IconData,
              color: (item['color'] as Color?) ?? AppColors.heading,
            ),
            title: Text(
              item['label'] as String,
              style: TextStyle(
                color: (item['color'] as Color?) ?? AppColors.heading,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              if (isLogout) {
                context.read<AuthProvider>().logout();
                context.go('/');
              }
            },
            trailing: const Icon(Icons.chevron_right, size: 18),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context, AuthProvider auth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileCard(context, auth),
        const SizedBox(height: 30),
        const Text(
          'Recent Orders',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(40),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.border),
          ),
          child: const Column(
            children: [
              Icon(Icons.shopping_cart_outlined, size: 50, color: Colors.grey),
              SizedBox(height: 10),
              Text('No orders yet', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
