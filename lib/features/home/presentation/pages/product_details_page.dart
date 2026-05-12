import 'package:flutter/material.dart';
import 'package:hilcom/features/home/domain/models/product_model.dart';
import 'package:hilcom/features/home/presentation/widgets/layout/web_header.dart';
import 'package:hilcom/features/home/presentation/widgets/layout/web_secondary_header.dart';
import 'package:hilcom/features/home/presentation/widgets/layout/mobile_app_bar.dart';
import 'package:hilcom/features/home/presentation/widgets/layout/mobile_drawer.dart';
import 'package:hilcom/features/home/presentation/widgets/layout/footer.dart';
import 'package:hilcom/features/home/presentation/widgets/layout/bottom_banner.dart';
import 'package:hilcom/features/home/presentation/widgets/common/breadcrumb.dart';
import 'package:hilcom/features/home/presentation/widgets/product_card.dart';
import 'package:hilcom/features/home/presentation/widgets/product_details/product_image_section.dart';
import 'package:hilcom/features/home/presentation/widgets/product_details/product_info_section.dart';
import 'package:hilcom/features/home/presentation/widgets/product_details/product_tabs.dart';
import 'package:hilcom/features/home/presentation/widgets/product_details/product_sidebar.dart';
import 'package:hilcom/features/home/presentation/widgets/product_details/product_video_section.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: isMobile ? 110 : 120),
            if (!isMobile) const WebSecondaryHeader(currentPage: 'Shop'),
            Breadcrumb(currentPage: product.title, isMobile: isMobile),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 15 : 50,
                vertical: 30,
              ),
              child: isMobile 
                ? _buildMobileLayout(context)
                : _buildWebLayout(context),
            ),
            BottomBanner(isMobile: isMobile),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ProductImageSection(
                      images: product.images, 
                      isMobile: false
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    flex: 1,
                    child: ProductInfoSection(
                      product: product, 
                      isMobile: false
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              if (product.videoUrl != null) ...[
                ProductVideoSection(videoUrl: product.videoUrl!, isMobile: false),
                const SizedBox(height: 60),
              ],
              const ProductTabs(isMobile: false),
              const SizedBox(height: 60),
              _buildRelatedProducts(context, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImageSection(images: product.images, isMobile: true),
        const SizedBox(height: 30),
        ProductInfoSection(product: product, isMobile: true),
        const SizedBox(height: 50),
        if (product.videoUrl != null) ...[
          ProductVideoSection(videoUrl: product.videoUrl!, isMobile: true),
          const SizedBox(height: 50),
        ],
        const ProductTabs(isMobile: true),
        const SizedBox(height: 50),
        _buildRelatedProducts(context, true),
      ],
    );
  }

  Widget _buildRelatedProducts(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Related products', 
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.heading),
            ),
            const SizedBox(width: 15),
            Expanded(child: Divider(color: AppColors.primary.withOpacity(0.1), thickness: 2)),
          ],
        ),
        const SizedBox(height: 30),
        isMobile
            ? SizedBox(
                height: 420,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 20),
                      child: _getRelatedProduct(index),
                    );
                  },
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _getRelatedProduct(index);
                },
              ),
      ],
    );
  }

  Widget _getRelatedProduct(int index) {
    final titles = [
      'Ultrabook Laptop 15.6 Inch',
      'Smart Bluetooth Speaker',
      'HomeSpeak 12L-04 Buds',
      'Digital Camera 4K 2023'
    ];
    final mainImages = [
      'https://picsum.photos/id/1/400/400',
      'https://picsum.photos/id/2/400/400',
      'https://picsum.photos/id/3/400/400',
      'https://picsum.photos/id/4/400/400'
    ];
    
    return ProductCard(
      product: ProductModel(
        title: titles[index],
        category: 'Electronics',
        image: mainImages[index],
        images: [
          mainImages[index],
          'https://picsum.photos/id/${index + 10}/400/400',
          'https://picsum.photos/id/${index + 20}/400/400',
        ],
        rating: 4.5,
        brand: 'HilcomTech',
        price: 25.0 + (index * 10),
        oldPrice: 35.0 + (index * 10),
        badge: index % 2 == 0 ? 'New' : 'Hot',
      ),
    );
  }
}
