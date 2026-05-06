import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/order_stat_card.dart';
import '../widgets/order_management_table.dart';

class OrderManagementPage extends StatelessWidget {
  const OrderManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: !Responsive.isDesktop(context) ? const AdminSidebar() : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              flex: 1,
              child: AdminSidebar(),
            ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const AdminHeader(title: 'Order Management'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopActionRow(context),
                        const SizedBox(height: 24),
                        _buildStatCards(context),
                        const SizedBox(height: 24),
                        const OrderManagementTable(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopActionRow(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.heading,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Order', style: TextStyle(fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, size: 18),
                  label: const Text('More', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.heading,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        const Text(
          'Order List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.heading,
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Order'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, size: 18),
          label: const Text('More Action'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.heading,
            side: const BorderSide(color: AppColors.border),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCards(BuildContext context) {
    final stats = [
      const OrderStatCard(
        title: 'Total Orders',
        value: '1,240',
        trend: '14.4%',
        subtitle: 'Last 7 days',
      ),
      const OrderStatCard(
        title: 'New Orders',
        value: '240',
        trend: '20%',
        subtitle: 'Last 7 days',
      ),
      const OrderStatCard(
        title: 'Completed Orders',
        value: '960',
        trend: '85%',
        subtitle: 'Last 7 days',
      ),
      const OrderStatCard(
        title: 'Canceled Orders',
        value: '87',
        trend: '5%',
        isPositive: false,
        subtitle: 'Last 7 days',
      ),
    ];

    if (!Responsive.isDesktop(context)) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
          childAspectRatio: Responsive.isMobile(context) ? 2.5 : 2.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) => stats[index],
      );
    }

    return Row(
      children: stats.map((s) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: s,
        ),
      )).toList(),
    );
  }
}
