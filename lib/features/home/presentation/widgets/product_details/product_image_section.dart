import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ProductImageSection extends StatefulWidget {
  final List<String> images;
  final bool isMobile;
  const ProductImageSection({super.key, required this.images, required this.isMobile});

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.images.isNotEmpty ? widget.images.first : '';
  }

  @override
  void didUpdateWidget(ProductImageSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.images != widget.images && widget.images.isNotEmpty) {
      _selectedImage = widget.images.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // Main Image Container
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Hero(
            tag: _selectedImage,
            child: InteractiveViewer(
              panEnabled: false, // Set it to false
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: CachedNetworkImage(
                imageUrl: _selectedImage,
                fit: BoxFit.contain,
                width: double.infinity,
                height: widget.isMobile ? 350 : 500,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Thumbnails
        SizedBox(
          height: widget.isMobile ? 80 : 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final img = widget.images[index];
              final isSelected = img == _selectedImage;
              return GestureDetector(
                onTap: () => setState(() => _selectedImage = img),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: widget.isMobile ? 80 : 100,
                  height: widget.isMobile ? 80 : 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ] : [],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: img,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
