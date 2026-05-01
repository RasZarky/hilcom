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

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Add spacing for the floating app bar
            SizedBox(height: isMobile ? 110 : 120),
            if (!isMobile) const WebSecondaryHeader(currentPage: 'Shop'),
            Breadcrumb(currentPage: product.title, isMobile: isMobile),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 15 : 50,
                vertical: 20,
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
                  Expanded(child: ProductImageSection(image: product.image, isMobile: false)),
                  const SizedBox(width: 40),
                  Expanded(child: ProductInfoSection(product: product, isMobile: false)),
                ],
              ),
              const SizedBox(height: 50),
              const ProductTabs(isMobile: false),
              const SizedBox(height: 50),
              _buildRelatedProducts(context, false),
            ],
          ),
        ),
        const SizedBox(width: 30),
        const Expanded(
          flex: 1,
          child: ProductSidebar(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImageSection(image: product.image, isMobile: true),
        const SizedBox(height: 30),
        ProductInfoSection(product: product, isMobile: true),
        const SizedBox(height: 40),
        const ProductTabs(isMobile: true),
        const SizedBox(height: 40),
        _buildRelatedProducts(context, true),
      ],
    );
  }

  Widget _buildRelatedProducts(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Related products', 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(height: 2, width: 80, color: const Color(0xFF3BB77E).withValues(alpha: 0.3)),
        const SizedBox(height: 30),
        isMobile
            ? SizedBox(
                height: 420,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 15),
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
                  childAspectRatio: 0.7,
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
    final images = [
      'https://picsum.photos/id/1/400/400',
      'https://picsum.photos/id/2/400/400',
      'https://picsum.photos/id/3/400/400',
      'https://picsum.photos/id/4/400/400'
    ];

    return ProductCard(
      product: ProductModel(
        title: titles[index],
        category: 'Organic',
        image: images[index],
        rating: 4.5,
        brand: 'HilcomFood',
        price: 25.0 + (index * 10),
        oldPrice: 35.0 + (index * 10),
        badge: index % 2 == 0 ? 'New' : 'Hot',
      ),
    );
  }
}
