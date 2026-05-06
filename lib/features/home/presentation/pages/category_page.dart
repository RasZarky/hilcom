import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../providers/home_provider.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/web_secondary_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';
import '../widgets/product_card.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final provider = context.watch<HomeProvider>();
    
    // Filter products by category
    final categoryProducts = [...provider.popularProducts, ...provider.dealsOfTheDay]
        .where((product) => product.category.toLowerCase() == categoryName.toLowerCase())
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!isMobile) WebSecondaryHeader(currentPage: categoryName),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 15 : 50,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        categoryName,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isMobile ? 32 : 48,
                              fontWeight: FontWeight.bold,
                              color: AppColors.heading,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${categoryProducts.length} items found in this category',
                    style: const TextStyle(color: AppColors.textBody, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  if (categoryProducts.isEmpty)
                    _buildEmptyCategory(context)
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 2 : 5,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: categoryProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: categoryProducts[index]);
                      },
                    ),
                ],
              ),
            ),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCategory(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inventory_2_outlined, size: 80, color: AppColors.border),
          const SizedBox(height: 20),
          const Text(
            'No products found',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading),
          ),
          const SizedBox(height: 10),
          const Text(
            'We couldn\'t find any products in this category at the moment.',
            style: TextStyle(color: AppColors.textBody),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => context.go('/'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
