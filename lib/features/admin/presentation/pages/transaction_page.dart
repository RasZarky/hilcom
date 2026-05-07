import 'package:flutter/material.dart';
import 'package:hilcom/core/utils/responsive.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/transaction_summary_card.dart';
import '../widgets/transaction_history_table.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

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
                const AdminHeader(title: 'Transaction'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopSection(context),
                        const SizedBox(height: 24),
                        const TransactionHistoryTable(),
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
    final stats = [
      const TransactionSummaryCard(
        title: 'Total Revenue',
        value: r'$15,045',
        trend: '14.4%',
        subtitle: 'Last 7 days',
      ),
      const TransactionSummaryCard(
        title: 'Completed Transactions',
        value: '3,150',
        trend: '20%',
        subtitle: 'Last 7 days',
      ),
      const TransactionSummaryCard(
        title: 'Pending Transactions',
        value: '150',
        trend: '85%',
        subtitle: 'Last 7 days',
      ),
      const TransactionSummaryCard(
        title: 'Failed Transactions',
        value: '75',
        trend: '15%',
        isPositive: false,
        subtitle: 'Last 7 days',
      ),
    ];

    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          ...stats.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: s,
          )),
        ],
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.2,
      children: stats,
    );
  }
}
