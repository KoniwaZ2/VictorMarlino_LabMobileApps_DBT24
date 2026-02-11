import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../screens/message_screen.dart';

class ContactCard extends StatelessWidget {
  final User user;
  final bool hasUnreadMessage;
  final String timeAgo;

  const ContactCard({
    super.key,
    required this.user,
    this.hasUnreadMessage = false,
    this.timeAgo = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageScreen(user: user)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Profile Picture
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade800, width: 1),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.imageURL),
                radius: 28,
              ),
            ),
            const SizedBox(width: 12),

            // Name and Last Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.lastMessage,
                          style: TextStyle(
                            color: hasUnreadMessage
                                ? Colors.white
                                : Colors.grey.shade500,
                            fontSize: 14,
                            fontWeight: hasUnreadMessage
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (timeAgo.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(
                          ' · $timeAgo',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Camera Icon and Unread Indicator
            Row(
              children: [
                const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey,
                  size: 24,
                ),
                const SizedBox(width: 8),
                if (hasUnreadMessage)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
