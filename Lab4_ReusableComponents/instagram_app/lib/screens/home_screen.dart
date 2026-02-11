import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/story_bubble.dart';
import '../widgets/post_card.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 32),
                  const Text(
                    'Instagram',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),

            // Combined Scrollable Content
            Expanded(
              child: ListView.builder(
                itemCount:
                    stories.length +
                    posts.length +
                    1, // 1 for stories section + posts
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Stories Section
                    return Column(
                      children: [
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            itemCount: stories.length,
                            itemBuilder: (context, storyIndex) {
                              final story = stories[storyIndex];
                              return StoryBubble(
                                story: story,
                                isYourStory: false,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Posts
                    final postIndex = index - 1;
                    if (postIndex < posts.length) {
                      final post = posts[postIndex];
                      final user = users.firstWhere(
                        (u) => u.id == post.userId,
                        orElse: () => users[0],
                      );

                      return PostCard(
                        post: post,
                        username: user.name,
                        userImage: user.imageURL,
                        likes: '${postIndex * 200 + 1500} likes',
                      );
                    }
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
