class ProductModel {
  final String title;
  final String category;
  final String image;
  final List<String> images; // List including main image and extras
  final double rating;
  final String brand;
  final double price;
  final double? oldPrice;
  final String? badge;
  final String? videoUrl; // Optional TikTok or other video URL
  final DateTime? dealEndTime; // Optional end time for deals

  ProductModel({
    required this.title,
    required this.category,
    required this.image,
    List<String>? images,
    required this.rating,
    required this.brand,
    required this.price,
    this.oldPrice,
    this.badge,
    this.videoUrl,
    this.dealEndTime,
  }) : images = images ?? [image];
}
