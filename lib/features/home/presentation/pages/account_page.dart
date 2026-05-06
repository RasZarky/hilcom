import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../../domain/models/address_model.dart';
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
  String? _viewingOrderId;
  final _addressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final authProvider = context.watch<AuthProvider>();
    final homeProvider = context.watch<HomeProvider>();

    if (!authProvider.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      extendBodyBehindAppBar: true,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildPremiumHeader(context, authProvider, isMobile),
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

  Widget _buildPremiumHeader(BuildContext context, AuthProvider auth, bool isMobile) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: AppColors.primary.withValues(alpha: 0.05),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: isMobile ? 120 : 180,
              bottom: 40,
              left: isMobile ? 20 : 50,
              right: isMobile ? 20 : 50,
            ),
            child: Row(
              children: [
                _buildAnimatedAvatar(isMobile),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.stars_rounded, size: 14, color: AppColors.secondary),
                            SizedBox(width: 4),
                            Text(
                              'GOLD MEMBER',
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w900,
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        auth.userName ?? 'User Name',
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 42,
                          fontWeight: FontWeight.w900,
                          color: AppColors.heading,
                          letterSpacing: -1.5,
                        ),
                      ),
                      Text(
                        auth.userEmail ?? 'user@email.com',
                        style: TextStyle(
                          color: AppColors.textBody.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isMobile)
                  OutlinedButton.icon(
                    onPressed: () {
                      auth.logout();
                      context.go('/');
                    },
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: const Text('Sign Out'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.2)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedAvatar(bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
            ),
            child: CircleAvatar(
              radius: isMobile ? 45 : 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: isMobile ? 42 : 57,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Icon(Icons.person_rounded, size: isMobile ? 45 : 60, color: AppColors.primary),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10),
                ],
              ),
              child: const Icon(Icons.edit_rounded, size: 16, color: AppColors.heading),
            ),
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
        const SizedBox(width: 40),
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
        if (_selectedTab == 0 && _viewingOrderId == null) ...[
          _buildStatsGrid(context, home, true),
          const SizedBox(height: 30),
        ],
        if (_viewingOrderId == null) _buildSidebarMenu(context, auth),
        const SizedBox(height: 30),
        _buildMainContent(context, auth, home),
      ],
    );
  }

  Widget _buildSidebarMenu(BuildContext context, AuthProvider auth) {
    final menuItems = [
      {'icon': Icons.dashboard_rounded, 'label': 'Overview'},
      {'icon': Icons.local_mall_rounded, 'label': 'Orders'},
      {'icon': Icons.favorite_rounded, 'label': 'Wishlist'},
      {'icon': Icons.location_on_rounded, 'label': 'Addresses'},
      {'icon': Icons.person_rounded, 'label': 'Account Details'},
    ];

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          ...List.generate(menuItems.length, (index) {
            final isSelected = _selectedTab == index;
            final label = menuItems[index]['label'] as String;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                onTap: () {
                  if (label == 'Wishlist') {
                    context.push('/wishlist');
                  } else {
                    setState(() {
                      _selectedTab = index;
                      _viewingOrderId = null;
                    });
                  }
                },
                leading: Icon(
                  menuItems[index]['icon'] as IconData,
                  color: isSelected ? AppColors.primary : AppColors.heading.withValues(alpha: 0.5),
                  size: 22,
                ),
                title: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? AppColors.heading : AppColors.heading.withValues(alpha: 0.6),
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                tileColor: isSelected ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
                trailing: isSelected 
                  ? Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  : (label == 'Wishlist' ? const Icon(Icons.open_in_new, size: 14) : null),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, AuthProvider auth, HomeProvider home) {
    if (_viewingOrderId != null) {
      return _buildOrderDetailView(context, _viewingOrderId!);
    }

    switch (_selectedTab) {
      case 0:
        return Column(
          children: [
            if (MediaQuery.of(context).size.width >= 900) _buildStatsGrid(context, home, false),
            if (MediaQuery.of(context).size.width >= 900) const SizedBox(height: 40),
            _buildRecentOrdersSection(context),
          ],
        );
      case 1:
        return _buildOrdersView(context);
      case 3:
        return _buildAddressesView(context, auth);
      case 4:
        return _buildAccountDetailsView(context, auth);
      default:
        return _buildPlaceholderContent(context, "Coming Soon");
    }
  }

  Widget _buildStatsGrid(BuildContext context, HomeProvider home, bool isMobile) {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Orders', '12', Icons.shopping_bag_rounded, Colors.blueAccent, 0)),
        const SizedBox(width: 20),
        Expanded(child: _buildStatCard('Wishlist', '${home.wishlistCount}', Icons.favorite_rounded, Colors.redAccent, 1)),
        const SizedBox(width: 20),
        Expanded(child: _buildStatCard('Cart', '${home.cartCount}', Icons.shopping_cart_rounded, AppColors.primary, 2)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 150)),
      tween: Tween(begin: 0, end: 1),
      builder: (context, val, child) {
        return Opacity(
          opacity: val,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - val)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 20),
            Text(
              value,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.heading, height: 1),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: AppColors.textBody.withValues(alpha: 0.6), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrdersSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 30, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Orders',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.heading),
              ),
              TextButton(onPressed: () => setState(() => _selectedTab = 1), child: const Text('View All')),
            ],
          ),
          const SizedBox(height: 20),
          _buildOrderItem(
            id: 'ORD-2024-001',
            status: 'Pending',
            total: 'GH₵ 450.00',
            date: 'Jun 12, 2024',
            items: const [
              {'name': 'Tesla Model S Plaid', 'image': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&q=80&w=400'},
              {'name': 'Samsung 75" Neo QLED', 'image': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?auto=format&fit=crop&q=80&w=400'},
            ],
          ),
          const Divider(height: 40),
          _buildOrderItem(
            id: 'ORD-2023-098',
            status: 'Delivered',
            total: 'GH₵ 1,200.00',
            date: 'May 28, 2024',
            items: const [
              {'name': 'Sony WH-1000XM5', 'image': 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&fit=crop&q=80&w=400'},
              {'name': 'Classic King Bed Frame', 'image': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&q=80&w=400'},
              {'name': 'Harman Kardon SoundStick', 'image': 'https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&q=80&w=400'},
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String id,
    required String status,
    required String total,
    required String date,
    required List<Map<String, String>> items,
  }) {
    Color statusColor = status == 'Delivered' ? AppColors.primary : (status == 'Cancelled' ? Colors.red : Colors.orange);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.receipt_long_rounded, color: AppColors.heading),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(id, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.heading, fontSize: 16)),
                  Text(date, style: const TextStyle(color: AppColors.textBody, fontSize: 13)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(total, style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary, fontSize: 16)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text('Items Ordered:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.heading)),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(items[index]['image']!, width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        items[index]['name']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.heading),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                _viewingOrderId = id;
              });
            },
            icon: const Icon(Icons.arrow_forward_rounded, size: 16),
            label: const Text('View Order Details', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order History', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.heading)),
          const SizedBox(height: 30),
          _buildOrderItem(
            id: 'ORD-2024-001',
            status: 'Pending',
            total: 'GH₵ 450.00',
            date: 'Jun 12, 2024',
            items: const [
              {'name': 'Tesla Model S Plaid', 'image': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&q=80&w=400'},
              {'name': 'Samsung 75" Neo QLED', 'image': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?auto=format&fit=crop&q=80&w=400'},
            ],
          ),
          const Divider(height: 40),
          _buildOrderItem(
            id: 'ORD-2023-098',
            status: 'Delivered',
            total: 'GH₵ 1,200.00',
            date: 'May 28, 2024',
            items: const [
              {'name': 'Sony WH-1000XM5', 'image': 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&fit=crop&q=80&w=400'},
              {'name': 'Classic King Bed Frame', 'image': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&q=80&w=400'},
            ],
          ),
          const Divider(height: 40),
          _buildOrderItem(
            id: 'ORD-2023-085',
            status: 'Cancelled',
            total: 'GH₵ 89.00',
            date: 'May 10, 2024',
            items: const [
              {'name': 'Tesla Model S Plaid', 'image': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&q=80&w=400'},
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressesView(BuildContext context, AuthProvider auth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Shipping Addresses', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.heading)),
        const SizedBox(height: 30),
        ...auth.addresses.map((address) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildAddressCard(context, auth, address),
        )),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => _showAddressDialog(context, auth),
          icon: const Icon(Icons.add_location_alt_rounded),
          label: const Text('Add New Address'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard(BuildContext context, AuthProvider auth, AddressModel address) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: address.isDefault ? Border.all(color: AppColors.primary, width: 2) : Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(address.label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: AppColors.heading)),
              if (address.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                  child: const Text('DEFAULT', style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 15),
          Text(address.fullName, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.heading)),
          Text(address.street, style: const TextStyle(color: AppColors.textBody)),
          Text(address.city, style: const TextStyle(color: AppColors.textBody)),
          Text(address.phoneNumber, style: const TextStyle(color: AppColors.textBody)),
          const SizedBox(height: 20),
          Row(
            children: [
              TextButton.icon(
                onPressed: () => _showAddressDialog(context, auth, address: address),
                icon: const Icon(Icons.edit_rounded, size: 16),
                label: const Text('Edit'),
              ),
              const SizedBox(width: 10),
              TextButton.icon(
                onPressed: () => _showDeleteConfirmDialog(context, auth, address.id),
                icon: const Icon(Icons.delete_outline, size: 16),
                label: const Text('Remove', style: TextStyle(color: Colors.red)),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
              const Spacer(),
              if (!address.isDefault)
                TextButton(
                  onPressed: () => auth.updateAddress(address.copyWith(isDefault: true)),
                  child: const Text('Set as Default'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, AuthProvider auth, String addressId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to remove this address?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              auth.removeAddress(addressId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Address removed'), backgroundColor: Colors.red),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAddressDialog(BuildContext context, AuthProvider auth, {AddressModel? address}) {
    final labelController = TextEditingController(text: address?.label);
    final nameController = TextEditingController(text: address?.fullName);
    final streetController = TextEditingController(text: address?.street);
    final cityController = TextEditingController(text: address?.city);
    final phoneController = TextEditingController(text: address?.phoneNumber);
    bool isDefault = address?.isDefault ?? false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(address == null ? 'Add New Address' : 'Edit Address', style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Form(
              key: _addressFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildValidatedTextField('Label (e.g. Home, Office)', labelController),
                  const SizedBox(height: 15),
                  _buildValidatedTextField('Full Name', nameController),
                  const SizedBox(height: 15),
                  _buildValidatedTextField('Street Address', streetController),
                  const SizedBox(height: 15),
                  _buildValidatedTextField('City', cityController),
                  const SizedBox(height: 15),
                  _buildValidatedTextField('Phone Number', phoneController),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    title: const Text('Set as Default Address', style: TextStyle(fontSize: 14)),
                    value: isDefault,
                    onChanged: (val) => setDialogState(() => isDefault = val ?? false),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (_addressFormKey.currentState!.validate()) {
                  final newAddress = AddressModel(
                    id: address?.id ?? DateTime.now().toString(),
                    label: labelController.text,
                    fullName: nameController.text,
                    street: streetController.text,
                    city: cityController.text,
                    phoneNumber: phoneController.text,
                    isDefault: isDefault,
                  );
                  if (address == null) {
                    auth.addAddress(newAddress);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Address added successfully!'), backgroundColor: AppColors.primary));
                  } else {
                    auth.updateAddress(newAddress);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Address updated successfully!'), backgroundColor: AppColors.primary));
                  }
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              child: Text(address == null ? 'Add Address' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidatedTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.heading, fontSize: 13)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountDetailsView(BuildContext context, AuthProvider auth) {
    final nameController = TextEditingController(text: auth.userName);
    final emailController = TextEditingController(text: auth.userEmail);

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(30), 
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 20)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Account Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.heading)),
          const SizedBox(height: 30),
          _buildTextField('Full Name', nameController),
          const SizedBox(height: 20),
          _buildTextField('Email Address', emailController, enabled: false),
          const SizedBox(height: 20),
          _buildTextField('Phone Number', TextEditingController(text: '+233 50 000 0000')),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: AppColors.primary));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
            child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = true, bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.heading, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.withValues(alpha: 0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderContent(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          const Icon(Icons.hourglass_empty_rounded, size: 60, color: AppColors.border),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading)),
        ],
      ),
    );
  }

  Widget _buildOrderDetailView(BuildContext context, String orderId) {
    // Mock data for order details
    final items = [
      {'name': 'Tesla Model S Plaid', 'image': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&q=80&w=400', 'price': 'GH₵ 89,990.00', 'qty': '1'},
      {'name': 'Samsung 75" Neo QLED', 'image': 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?auto=format&fit=crop&q=80&w=400', 'price': 'GH₵ 2,299.99', 'qty': '1'},
    ];

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() => _viewingOrderId = null),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              const SizedBox(width: 10),
              Text('Order Details: $orderId', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.heading)),
            ],
          ),
          const SizedBox(height: 30),
          
          // Order Tracker / Stepper
          _buildOrderTracker(1), // Currently at 'Processed' step
          
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Date:', style: TextStyle(color: AppColors.textBody, fontSize: 13)),
                  Text('Jun 12, 2024', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                child: const Text('PENDING', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const Divider(height: 40),
          const Text('Items Ordered', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.heading)),
          const SizedBox(height: 20),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(item['image']!, width: 70, height: 70, fit: BoxFit.cover),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.heading)),
                      Text('Quantity: ${item['qty']}', style: const TextStyle(color: AppColors.textBody, fontSize: 14)),
                    ],
                  ),
                ),
                Text(item['price']!, style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary, fontSize: 16)),
              ],
            ),
          )),
          const Divider(height: 40),
          _buildSummaryRow('Subtotal', 'GH₵ 92,289.99'),
          _buildSummaryRow('Shipping', 'Free'),
          _buildSummaryRow('Tax', 'GH₵ 120.00'),
          const Divider(height: 30),
          _buildSummaryRow('Total', 'GH₵ 92,409.99', isBold: true),
          const SizedBox(height: 40),
          const Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.heading)),
          const SizedBox(height: 10),
          const Text('John Doe\nNo. 24, Oxford Street\nAccra, Ghana\n+233 50 000 0000', style: TextStyle(color: AppColors.textBody, height: 1.5)),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_rounded),
            label: const Text('Download Invoice'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.heading,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTracker(int currentStep) {
    final steps = ['Placed', 'Processed', 'Shipped', 'Delivered'];
    
    return Row(
      children: List.generate(steps.length, (index) {
        final isCompleted = index <= currentStep;
        final isLast = index == steps.length - 1;
        
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Container(height: 2, color: index == 0 ? Colors.transparent : (isCompleted ? AppColors.primary : AppColors.border))),
                  Icon(
                    isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    color: isCompleted ? AppColors.primary : AppColors.border,
                    size: 24,
                  ),
                  Expanded(child: Container(height: 2, color: isLast ? Colors.transparent : (index < currentStep ? AppColors.primary : AppColors.border))),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                steps[index],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                  color: isCompleted ? AppColors.heading : AppColors.textBody,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isBold ? AppColors.heading : AppColors.textBody, fontSize: isBold ? 18 : 15, fontWeight: isBold ? FontWeight.w900 : FontWeight.normal)),
          Text(value, style: TextStyle(color: isBold ? AppColors.primary : AppColors.heading, fontSize: isBold ? 24 : 15, fontWeight: isBold ? FontWeight.w900 : FontWeight.bold)),
        ],
      ),
    );
  }
}
