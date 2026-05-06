import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';

class AdminHeader extends StatelessWidget {
  final String title;
  const AdminHeader({super.key, this.title = 'Dashboard'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Row(
        children: [
          if (!Responsive.isDesktop(context)) ...[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.heading,
            ),
          ),
          const Spacer(),
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search data, users, or reports',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    filled: true,
                    fillColor: Colors.grey[50],
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.textBody),
            onPressed: () {},
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.wb_sunny_outlined, size: 16, color: AppColors.textBody),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=admin'),
          ),
        ],
      ),
    );
  }
}
