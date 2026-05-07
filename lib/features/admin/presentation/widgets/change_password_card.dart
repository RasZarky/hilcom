import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'admin_form_field.dart';

class ChangePasswordCard extends StatelessWidget {
  const ChangePasswordCard({super.key});

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
                'Change Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.heading),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Need help?',
                  style: TextStyle(color: Colors.indigo, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AdminFormField(
            label: 'Current Password',
            hintText: 'Enter password',
            isPassword: true,
            suffixIcon: Icon(Icons.visibility_off_outlined, size: 20, color: AppColors.textBody),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
            child: const Text(
              'Forgot Current Password? Click here',
              style: TextStyle(color: Colors.indigo, fontSize: 12),
            ),
          ),
          const SizedBox(height: 16),
          const AdminFormField(
            label: 'New Password',
            hintText: 'Enter password',
            isPassword: true,
            suffixIcon: Icon(Icons.visibility_off_outlined, size: 20, color: AppColors.textBody),
          ),
          const SizedBox(height: 24),
          const AdminFormField(
            label: 'Re-enter Password',
            hintText: 'Enter password',
            isPassword: true,
            suffixIcon: Icon(Icons.visibility_off_outlined, size: 20, color: AppColors.textBody),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text('Save Change', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
