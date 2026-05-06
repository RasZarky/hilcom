class ProductModel {
  final String title;
  final String category;
  final String image;
  final double rating;
  final String brand;
  final double price;
  final double? oldPrice;
  final String? badge;
  final String? videoUrl; // Optional TikTok or other video URL

  ProductModel({
    required this.title,
    required this.category,
    required this.image,
    required this.rating,
    required this.brand,
    required this.price,
    this.oldPrice,
    this.badge,
    this.videoUrl,
  });
}
