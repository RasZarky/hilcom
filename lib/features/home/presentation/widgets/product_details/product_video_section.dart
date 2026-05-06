import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ProductVideoSection extends StatelessWidget {
  final String videoUrl;
  final bool isMobile;

  const ProductVideoSection({
    super.key,
    required this.videoUrl,
    required this.isMobile,
  });

  String? _extractTikTokId(String url) {
    final RegExp regExp = RegExp(r"video/(\d+)");
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  @override
  Widget build(BuildContext context) {
    String embedUrl = videoUrl;
    if (videoUrl.contains('tiktok.com')) {
      final videoId = _extractTikTokId(videoUrl);
      if (videoId != null) {
        embedUrl = 'https://www.tiktok.com/embed/v2/$videoId';
      }
    }

    // Set a portrait height that fits TikTok's 9:16 aspect ratio.
    final double playerHeight = isMobile ? 650 : 800;

    // Use a clean iframe tag. We'll control sizing through Flutter and customStylesBuilder.
    // Added scrolling="no" and explicit height to the iframe.
    final String htmlContent = '''
      <iframe 
        src="$embedUrl" 
        width="${playerHeight.toInt()/2}"  
        height="${playerHeight.toInt()}" 
        style="border: none; width: 100%; height: ${playerHeight}px; overflow: hidden;" 
        scrolling="no"
        allowfullscreen>
      </iframe>
    ''';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Presentation',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.heading,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 2,
          width: 80,
          color: AppColors.primary.withValues(alpha: 0.3),
        ),
        const SizedBox(height: 30),
        HtmlWidget(
              htmlContent,
              // Force the iframe to occupy the full height in pixels.
              // This is critical on Web to prevent it from defaulting to a 300px landscape box.
              customStylesBuilder: (element) {
                if (element.localName == 'iframe') {
                  return {
                    'width': '100%',
                    'height': '${playerHeight}px',
                    'border': 'none',
                    'display': 'block',
                  };
                }
                return null;
              },
              onLoadingBuilder: (context, element, loadingProgress) => const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),

      ],
    );
  }
}
