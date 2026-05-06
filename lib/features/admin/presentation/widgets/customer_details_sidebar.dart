import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class CustomerDetailsSidebar extends StatelessWidget {
  const CustomerDetailsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=john'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.heading,
                      ),
                    ),
                    const Text(
                      'john.doe@example.com',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textBody,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 16, color: Colors.indigo),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'Customer Info'),
          const SizedBox(height: 16),
          _buildInfoItem(Icons.phone_outlined, '+1234567890'),
          const SizedBox(height: 12),
          _buildInfoItem(Icons.location_on_outlined, '123 Main St, NY'),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'Social Media'),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSocialIcon(Icons.public, Colors.blue), // Mock Facebook
              _buildSocialIcon(Icons.chat_bubble_outline, Colors.green), // Mock WhatsApp
              _buildSocialIcon(Icons.alternate_email, Colors.lightBlue), // Mock Twitter/X
              _buildSocialIcon(Icons.business_center, Colors.indigo), // Mock LinkedIn
              _buildSocialIcon(Icons.camera_alt_outlined, Colors.pink), // Mock Instagram
            ],
          ),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'Activity'),
          const SizedBox(height: 16),
          const Text('Registration: 15.01.2025', style: TextStyle(fontSize: 13, color: AppColors.heading)),
          const SizedBox(height: 4),
          const Text('Last purchase: 10.01.2025', style: TextStyle(fontSize: 13, color: AppColors.heading)),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'Order overview'),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildOrderStat('150', 'Total order', Colors.indigo),
              _buildOrderStat('140', 'Completed', AppColors.primary),
              _buildOrderStat('10', 'Canceled', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textBody),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 13, color: AppColors.heading)),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Icon(icon, size: 20, color: color),
    );
  }

  Widget _buildOrderStat(String value, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.heading),
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textBody,
      ),
    );
  }
}
