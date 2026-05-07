import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';
import 'admin_form_field.dart';

class ProfileUpdateCard extends StatelessWidget {
  const ProfileUpdateCard({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile Update',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.heading),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('Edit', style: TextStyle(fontSize: 13)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textBody,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=wade'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Upload New'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textBody,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildResponsiveRow(
            context,
            const AdminFormField(label: 'First Name', hintText: 'Wade'),
            const AdminFormField(label: 'Last Name', hintText: 'Warren'),
          ),
          const SizedBox(height: 20),
          _buildResponsiveRow(
            context,
            const AdminFormField(
              label: 'Password',
              hintText: '**********',
              isPassword: true,
              suffixIcon: Icon(Icons.visibility_off_outlined, size: 20, color: AppColors.textBody),
            ),
            const AdminFormField(
              label: 'Phone Number',
              hintText: '(406) 555-0120',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.flag, size: 20, color: Colors.blue), // Placeholder for flag
                  Icon(Icons.arrow_drop_down, color: AppColors.textBody),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildResponsiveRow(
            context,
            const AdminFormField(label: 'E-mail', hintText: 'wade.warren@example.com'),
            const AdminFormField(
              label: 'Date of Birth',
              hintText: '12- January- 1999',
              suffixIcon: Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textBody),
            ),
          ),
          const SizedBox(height: 20),
          const AdminFormField(label: 'Location', hintText: '2972 Westheimer Rd. Santa Ana, Illinois 85486'),
          const SizedBox(height: 20),
          const AdminFormField(
            label: 'Credit Card',
            hintText: '843-4359-4444',
            prefixIcon: Icon(Icons.credit_card, color: Colors.orange),
            suffixIcon: Icon(Icons.arrow_drop_down, color: AppColors.textBody),
          ),
          const SizedBox(height: 20),
          const AdminFormField(
            label: 'Biography',
            hintText: 'Enter a biography about you',
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textBody)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.auto_fix_high_outlined, size: 20, color: AppColors.textBody)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildResponsiveRow(BuildContext context, Widget left, Widget right) {
    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          left,
          const SizedBox(height: 20),
          right,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 20),
        Expanded(child: right),
      ],
    );
  }
}
