import 'package:flutter/material.dart';
import 'package:instagram_app/screens/home_screen.dart';
import '../screens/dm_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: const Icon(Icons.home, color: Colors.white, size: 28),
          ),
          const Icon(Icons.movie, color: Colors.white, size: 28),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DMScreen()),
              );
            },
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          ),
          const Icon(Icons.search, color: Colors.white, size: 28),
          CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(
              'https://picsum.photos/100/100?random=99',
            ),
          ),
        ],
      ),
    );
  }
}
