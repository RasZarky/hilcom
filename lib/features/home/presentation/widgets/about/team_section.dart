import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class TeamSection extends StatelessWidget {
  final bool isMobile;
  const TeamSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 60),
      child: Column(
        children: [
          Text('Our Team', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 10),
          Container(height: 2, width: 80, color: AppColors.primaryLight),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    _buildTeamIntro(context, true),
                    const SizedBox(height: 40),
                    _buildTeamCard('H. Mehndi', 'CEO & Founder', 'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=400&auto=format&fit=crop'),
                    const SizedBox(height: 20),
                    _buildTeamCard('Dick Specht', 'Manager', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=400&auto=format&fit=crop'),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildTeamIntro(context, false)),
                    const SizedBox(width: 30),
                    Expanded(child: _buildTeamCard('H. Mehndi', 'CEO & Founder', 'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=400&auto=format&fit=crop')),
                    const SizedBox(width: 30),
                    Expanded(child: _buildTeamCard('Dick Specht', 'Manager', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=400&auto=format&fit=crop')),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildTeamIntro(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Our Team', style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Text('Meet Our Expert Team', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40)),
        const SizedBox(height: 20),
        const Text(
          'Proin ullamcorper accumsan tellus sit amet conge. Mauris et iaculis enim. Nam venenatis nisl finibus iaculis.',
          style: TextStyle(color: AppColors.textBody, height: 1.6),
        ),
        const SizedBox(height: 15),
        const Text(
          'Proin ullamcorper accumsan tellus sit amet conge. Mauris et iaculis enim. Nam venenatis nisl finibus iaculis.',
          style: TextStyle(color: AppColors.textBody, height: 1.6),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text('View All Members'),
        ),
      ],
    );
  }

  Widget _buildTeamCard(String name, String role, String image) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(image, height: 350, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.heading)),
                const SizedBox(height: 5),
                Text(role, style: const TextStyle(color: AppColors.textBody)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(Icons.facebook),
                    _buildSocialIcon(Icons.camera_alt_outlined),
                    _buildSocialIcon(Icons.alternate_email),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(icon, color: AppColors.primary, size: 20),
    );
  }
}
