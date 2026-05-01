import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class PerformanceSection extends StatelessWidget {
  final bool isMobile;
  const PerformanceSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 40),
      child: isMobile
          ? Column(
              children: [
                _buildPerformanceImages(),
                const SizedBox(height: 30),
                _buildPerformanceContent(context),
              ],
            )
          : Row(
              children: [
                Expanded(child: _buildPerformanceImages()),
                const SizedBox(width: 50),
                Expanded(child: _buildPerformanceContent(context)),
              ],
            ),
    );
  }

  Widget _buildPerformanceImages() {
    return Row(
      children: [
        Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network('https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=400&auto=format&fit=crop'))),
        const SizedBox(width: 15),
        Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network('https://images.unsplash.com/photo-1506484334402-40f2dd6bd77a?q=80&w=400&auto=format&fit=crop'))),
      ],
    );
  }

  Widget _buildPerformanceContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Our performance', style: TextStyle(color: AppColors.textBody, fontSize: 18)),
        const SizedBox(height: 10),
        Text('Your Partner for e-commerce grocery solution', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 20),
        const Text(
          'Edutopia is a free, non-profit, educational website. Edutopia provides ideas and resources to K-12 educators on how to improve the educational experience.',
          style: TextStyle(fontSize: 16, color: AppColors.textBody, height: 1.6),
        ),
        const SizedBox(height: 15),
        const Text(
          'Edutopia is a free, non-profit, educational website. Edutopia provides ideas and resources to K-12 educators on how to improve the educational experience.',
          style: TextStyle(fontSize: 16, color: AppColors.textBody, height: 1.6),
        ),
      ],
    );
  }
}
