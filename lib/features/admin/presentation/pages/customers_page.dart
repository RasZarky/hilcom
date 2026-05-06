import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/order_stat_card.dart';
import '../widgets/customer_overview_chart.dart';
import '../widgets/customer_table.dart';
import '../widgets/customer_details_sidebar.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

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
                const AdminHeader(title: 'Customers'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopSection(context),
                        const SizedBox(height: 24),
                        _buildDetailsSection(context),
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

  Widget _buildTopSection(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          const OrderStatCard(
            title: 'Total Customers',
            value: '11,040',
            trend: '14.4%',
            subtitle: 'Last 7 days',
          ),
          const SizedBox(height: 16),
          const OrderStatCard(
            title: 'New Customers',
            value: '2,370',
            trend: '20%',
            subtitle: 'Last 7 days',
          ),
          const SizedBox(height: 16),
          const OrderStatCard(
            title: 'Visitor',
            value: '250k',
            trend: '20%',
            subtitle: 'Last 7 days',
          ),
          const SizedBox(height: 24),
          const CustomerOverviewChart(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: const [
              OrderStatCard(
                title: 'Total Customers',
                value: '11,040',
                trend: '14.4%',
                subtitle: 'Last 7 days',
              ),
              SizedBox(height: 16),
              OrderStatCard(
                title: 'New Customers',
                value: '2,370',
                trend: '20%',
                subtitle: 'Last 7 days',
              ),
              SizedBox(height: 16),
              OrderStatCard(
                title: 'Visitor',
                value: '250k',
                trend: '20%',
                subtitle: 'Last 7 days',
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        const Expanded(
          flex: 2,
          child: CustomerOverviewChart(),
        ),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            flex: 3,
            child: CustomerTable(),
          ),
          SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: CustomerDetailsSidebar(),
          ),
        ],
      );
    }

    return Column(
      children: const [
        CustomerTable(),
        SizedBox(height: 24),
        CustomerDetailsSidebar(),
      ],
    );
  }
}
