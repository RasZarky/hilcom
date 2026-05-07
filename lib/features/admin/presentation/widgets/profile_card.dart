import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.heading),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textBody),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined, size: 20, color: AppColors.textBody),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=wade'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Wade Warren',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.heading),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'wade.warren@example.com',
                style: TextStyle(color: AppColors.textBody, fontSize: 13),
              ),
              const SizedBox(width: 8),
              Icon(Icons.copy_outlined, size: 16, color: Colors.blue[300]),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Linked with Social media',
            style: TextStyle(color: AppColors.textBody, fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.g_mobiledata, Colors.red),
              _buildSocialIcon(Icons.facebook, Colors.blue),
              _buildSocialIcon(Icons.close, Colors.black), // Assuming X
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline, size: 18),
            label: const Text('Social media'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.heading,
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
