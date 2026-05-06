import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/weekly_report.dart';
import '../widgets/transaction_table.dart';
import '../widgets/top_products.dart';
import '../widgets/best_selling_products.dart';
import '../widgets/add_new_product_widget.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

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
                const AdminHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildSummaryCards(context),
                        const SizedBox(height: 24),
                        _buildSecondRow(context),
                        const SizedBox(height: 24),
                        _buildThirdRow(context),
                        const SizedBox(height: 24),
                        _buildFourthRow(context),
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

  Widget _buildSummaryCards(BuildContext context) {
    final cards = [
      const DashboardCard(
        title: 'Total Sales',
        subtitle: 'Last 7 days',
        content: SummaryContent(
          value: '\$350K',
          label: 'Sales',
          trend: '+10.4%',
          isPositive: true,
          previousLabel: 'Previous 7days',
          previousValue: '(\$235)',
        ),
      ),
      const DashboardCard(
        title: 'Total Orders',
        subtitle: 'Last 7 days',
        content: SummaryContent(
          value: '10.7K',
          label: 'order',
          trend: '+14.4%',
          isPositive: true,
          previousLabel: 'Previous 7days',
          previousValue: '(7.4k)',
        ),
      ),
      const DashboardCard(
        title: 'Pending & Canceled',
        subtitle: 'Last 7 days',
        content: PendingCanceledContent(),
      ),
    ];

    if (Responsive.isMobile(context)) {
      return Column(
        children: cards.map((c) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(height: 220, width: double.infinity, child: c),
        )).toList(),
      );
    }

    return Row(
      children: cards.map((c) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(height: 220, child: c),
        ),
      )).toList(),
    );
  }

  Widget _buildSecondRow(BuildContext context) {
    return const WeeklyReport();
  }

  Widget _buildThirdRow(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(flex: 2, child: TransactionTable()),
          SizedBox(width: 24),
          Expanded(flex: 1, child: TopProducts()),
        ],
      );
    }
    return Column(
      children: const [
        TransactionTable(),
        SizedBox(height: 24),
        TopProducts(),
      ],
    );
  }

  Widget _buildFourthRow(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(flex: 2, child: BestSellingProducts()),
          SizedBox(width: 24),
          Expanded(flex: 1, child: AddNewProductWidget()),
        ],
      );
    }
    return Column(
      children: const [
        BestSellingProducts(),
        SizedBox(height: 24),
        AddNewProductWidget(),
      ],
    );
  }
}
