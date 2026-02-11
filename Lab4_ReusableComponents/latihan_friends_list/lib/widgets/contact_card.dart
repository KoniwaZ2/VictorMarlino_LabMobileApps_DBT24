import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ContactCard extends StatelessWidget {
  final UserModel user;

  const ContactCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.imageUrl)),
      title: Text(user.name),
      subtitle: Text(user.lastMessage),
      onTap: () {
        // Handle contact card tap
      },
    );
  }
}
