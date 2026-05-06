import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/category_model.dart';
import '../../../../core/theme/app_colors.dart';

class CategoryCard extends StatefulWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.push('/category/${widget.category.title}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 160,
          margin: const EdgeInsets.only(right: 20, bottom: 20, top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.border.withValues(alpha: 0.5),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.08 : 0.03),
                blurRadius: _isHovered ? 25 : 12,
                offset: Offset(0, _isHovered ? 10 : 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Container
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isHovered 
                      ? AppColors.primary.withValues(alpha: 0.1) 
                      : const Color(0xFFF8F9FA),
                  shape: BoxShape.circle,
                ),
                child: AnimatedScale(
                  scale: _isHovered ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: CachedNetworkImage(
                    imageUrl: widget.category.image,
                    height: 44,
                    width: 44,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const SizedBox(
                      height: 44, width: 44,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.category_outlined,
                      size: 28,
                      color: AppColors.textBody,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.category.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${widget.category.itemCount} Items',
                style: TextStyle(
                  color: AppColors.textBody.withValues(alpha: 0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              // Futuristic indicator line
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isHovered ? 30 : 0,
                height: 2.5,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
