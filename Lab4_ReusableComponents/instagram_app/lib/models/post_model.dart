class Post {
  final List<String> imageUrls;
  final String caption;
  final DateTime timestamp;
  final String userId;

  Post({
    required this.imageUrls,
    required this.caption,
    required this.timestamp,
    required this.userId,
  });

  // Legacy support for single image
  Post.single({
    required String imageUrl,
    required this.caption,
    required this.timestamp,
    required this.userId,
  }) : imageUrls = [imageUrl];
}
