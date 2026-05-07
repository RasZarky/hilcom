import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/profile_card.dart';
import '../widgets/change_password_card.dart';
import '../widgets/profile_update_card.dart';

class AdminRolePage extends StatelessWidget {
  const AdminRolePage({super.key});

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
                const AdminHeader(title: 'Admin role'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About section',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.heading,
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (Responsive.isDesktop(context))
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    ProfileCard(),
                                    SizedBox(height: 24),
                                    ChangePasswordCard(),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                flex: 3,
                                child: ProfileUpdateCard(),
                              ),
                            ],
                          )
                        else
                          const Column(
                            children: [
                              ProfileCard(),
                              SizedBox(height: 24),
                              ChangePasswordCard(),
                              SizedBox(height: 24),
                              ProfileUpdateCard(),
                            ],
                          ),
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
}
