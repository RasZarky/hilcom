import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ProductVideoSection extends StatefulWidget {
  final String videoUrl;
  final bool isMobile;

  const ProductVideoSection({
    super.key,
    required this.videoUrl,
    required this.isMobile,
  });

  @override
  State<ProductVideoSection> createState() => _ProductVideoSectionState();
}

class _ProductVideoSectionState extends State<ProductVideoSection> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    // Extract video ID if it's a TikTok URL
    String embedUrl = widget.videoUrl;
    if (widget.videoUrl.contains('tiktok.com')) {
      final videoId = _extractTikTokId(widget.videoUrl);
      if (videoId != null) {
        embedUrl = 'https://www.tiktok.com/embed/v2/$videoId';
      }
    }

    _controller = WebViewController();
    
    if (!kIsWeb) {
      // These methods and NavigationDelegate are often problematic on Web 
      // with certain versions of webview_flutter
      _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      _controller.setBackgroundColor(const Color(0x00000000));
      _controller.setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        ),
      );
    } else {
      // On Web, we disable the loading state immediately as we can't 
      // reliably use NavigationDelegate in some environments/versions
      _isLoading = false;
    }

    _controller.loadRequest(Uri.parse(embedUrl));
  }

  String? _extractTikTokId(String url) {
    // Standard and mobile tiktok URL regex
    final RegExp regExp = RegExp(r"video/(\d+)");
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  @override
  Widget build(BuildContext context) {
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
        Container(
          height: widget.isMobile ? 550 : 700,
          width: widget.isMobile ? double.infinity : 450,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // PointerInterceptor is vital for Web to allow 
              // Flutter overlays to work correctly on top of the iframe.
              PointerInterceptor(
                intercepting: kIsWeb,
                child: WebViewWidget(controller: _controller),
              ),
              if (_isLoading)
                const CircularProgressIndicator(color: AppColors.primary),
            ],
          ),
        ),
      ],
    );
  }
}
