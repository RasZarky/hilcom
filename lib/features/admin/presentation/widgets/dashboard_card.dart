import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final VoidCallback? onDetailsTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.heading,
                ),
              ),
              const Icon(Icons.more_vert, color: AppColors.textBody, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textBody,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(), // Only if we are sure it fits, but let's allow content to decide
              child: content,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlinedButton(
              onPressed: onDetailsTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.indigo,
                side: BorderSide(color: Colors.indigo.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Details', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryContent extends StatelessWidget {
  final String value;
  final String label;
  final String trend;
  final bool isPositive;
  final String previousLabel;
  final String previousValue;

  const SummaryContent({
    super.key,
    required this.value,
    required this.label,
    required this.trend,
    required this.isPositive,
    required this.previousLabel,
    required this.previousValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: AppColors.textBody),
              ),
              const SizedBox(width: 4),
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
                color: isPositive ? AppColors.primary : Colors.red,
              ),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? AppColors.primary : Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text: '$previousLabel ',
            style: const TextStyle(fontSize: 12, color: AppColors.textBody),
            children: [
              TextSpan(
                text: previousValue,
                style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class PendingCanceledContent extends StatelessWidget {
  const PendingCanceledContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pending', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '509',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading),
                    ),
                    const SizedBox(width: 4),
                    const Text('user 204', style: TextStyle(fontSize: 12, color: AppColors.primary)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Canceled', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '94',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_downward, size: 14, color: Colors.red),
                    const Text('14.4%', style: TextStyle(fontSize: 12, color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
