import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final String username;
  final String userImage;
  final String likes;

  const PostCard({
    super.key,
    required this.post,
    required this.username,
    required this.userImage,
    required this.likes,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate time difference
    final now = DateTime.now();
    final difference = now.difference(widget.post.timestamp);
    String timeString;

    if (difference.inHours < 1) {
      timeString = '${difference.inMinutes} MINUTES AGO';
    } else if (difference.inHours < 24) {
      timeString = '${difference.inHours} HOURS AGO';
    } else if (difference.inDays < 7) {
      timeString = '${difference.inDays} DAYS AGO';
    } else {
      timeString = '${(difference.inDays ~/ 7)} WEEKS AGO';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFD5949),
                      Color(0xFFD6249F),
                      Color(0xFF285AEB),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.userImage),
                  radius: 16,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.white),
            ],
          ),
        ),

        // Post Images Carousel
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.post.imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.post.imageUrls[index],
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  );
                },
              ),
              // Indicator dots
              if (widget.post.imageUrls.length > 1)
                Positioned(
                  top: 8,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_currentPage + 1}/${widget.post.imageUrls.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Post Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              const Icon(Icons.favorite_border, color: Colors.white, size: 28),
              const SizedBox(width: 16),
              const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 26,
              ),
              const SizedBox(width: 16),
              const Icon(Icons.send, color: Colors.white, size: 26),
              const Spacer(),
              const Icon(Icons.bookmark_border, color: Colors.white, size: 28),
            ],
          ),
        ),

        // Likes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            widget.likes,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${widget.username} ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: widget.post.caption,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),

        // Timestamp
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Text(
            timeString,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}
