import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class WelcomeSection extends StatelessWidget {
  final bool isMobile;
  const WelcomeSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 40),
      child: isMobile
          ? Column(
              children: [
                _buildWelcomeImage(),
                const SizedBox(height: 30),
                _buildWelcomeContent(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildWelcomeImage()),
                const SizedBox(width: 50),
                Expanded(child: _buildWelcomeContent(context)),
              ],
            ),
    );
  }

  Widget _buildWelcomeImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://images.unsplash.com/photo-1556910103-1c02745aae4d?q=80&w=800&auto=format&fit=crop',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildWelcomeContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome to Hilcom', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 20),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
          style: TextStyle(fontSize: 16, color: AppColors.textBody, height: 1.6),
        ),
        const SizedBox(height: 20),
        const Text(
          'Adipiscing enim eu turpis egestas pretium aenean pharetra magna ac. Eu ultrices vitae auctor eu augue ut lectus arcu bibendum. Elementum curabitur vitae nunc sed velit dignissim sodales ut eu.',
          style: TextStyle(fontSize: 16, color: AppColors.textBody, height: 1.6),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(child: _buildGalleryImage('https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=300&auto=format&fit=crop')),
            const SizedBox(width: 15),
            Expanded(child: _buildGalleryImage('https://images.unsplash.com/photo-1494390248081-4e521a5940db?q=80&w=300&auto=format&fit=crop')),
            const SizedBox(width: 15),
            Expanded(child: _buildGalleryImage('https://images.unsplash.com/photo-1516594798947-e65505dbb29d?q=80&w=300&auto=format&fit=crop')),
          ],
        )
      ],
    );
  }

  Widget _buildGalleryImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(url, height: 120, fit: BoxFit.cover),
    );
  }
}
