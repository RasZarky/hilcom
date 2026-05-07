import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/category_summary_card.dart';
import '../widgets/category_table.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

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
                const AdminHeader(title: 'Categories'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopActionRow(context),
                        const SizedBox(height: 24),
                        _buildDiscoverSection(context),
                        const SizedBox(height: 32),
                        const CategoryTable(),
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

  Widget _buildTopActionRow(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Discover',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.heading,
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Product'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, size: 18),
          label: const Text('More Action'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.heading,
            side: const BorderSide(color: AppColors.border),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverSection(BuildContext context) {
    final categories = [
      {'title': 'Electronics', 'image': 'https://images.unsplash.com/photo-1498049794561-7780e7231661?q=80&w=200&auto=format&fit=crop'},
      {'title': 'Fashion', 'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?q=80&w=200&auto=format&fit=crop'},
      {'title': 'Accessories', 'image': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=200&auto=format&fit=crop'},
      {'title': 'Home & Kitchen', 'image': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?q=80&w=200&auto=format&fit=crop'},
      {'title': 'Sports & Outdoors', 'image': 'https://images.unsplash.com/photo-1461896642383-05717aa3960b?q=80&w=200&auto=format&fit=crop'},
      {'title': 'Toys & Games', 'image': 'https://images.unsplash.com/photo-1533738363-b7f9aef128ce?q=80&w=200&auto=format&fit=crop'},
      {'title': 'Health & Fitness', 'image': 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=200&auto=format&fit=crop'},
      {'title': 'Books', 'image': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?q=80&w=200&auto=format&fit=crop'},
    ];

    if (Responsive.isMobile(context)) {
      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CategorySummaryCard(
                title: categories[index]['title'] as String,
                imageUrl: categories[index]['image'] as String,
              ),
            );
          },
        ),
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: categories.map<Widget>((cat) {
        return CategorySummaryCard(
          title: cat['title'] as String,
          imageUrl: cat['image'] as String,
        );
      }).toList(),
    );
  }
}
