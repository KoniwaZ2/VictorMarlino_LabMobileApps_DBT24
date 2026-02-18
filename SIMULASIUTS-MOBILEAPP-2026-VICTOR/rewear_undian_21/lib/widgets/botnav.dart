// lib/widgets/botnav.dart

import 'package:flutter/material.dart';
import '../screens/sellerdashboard_screen.dart';
import '../screens/products_screen.dart';
import '../screens/orders_screen.dart';
// import '../screens/profile_screen.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTap;

  const BottomNav({super.key, required this.selectedIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      Icons.home_outlined,
      Icons.list_alt_outlined,
      Icons.inventory_2_outlined,
      Icons.person_outline,
    ];

    return Container(
      height: 72,
      color: const Color(0xFF111111),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final isActive = selectedIndex == i;
          return GestureDetector(
            onTap: () => _navigate(context, i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                items[i],
                color: isActive ? Colors.white : const Color(0xFF888888),
                size: 24,
              ),
            ),
          );
        }),
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    if (index == selectedIndex) return;

    onTap?.call(index);

    Widget destination;
    switch (index) {
      case 0:
        destination = const SellerDashboardScreen();
        break;
      case 1:
        destination = const MyProductsScreen();
        break;
      case 2:
        destination = const OrdersScreen();
        break;
      case 3:
        // destination = const ProfileScreen();
        return; // belum ada screen, tidak navigate
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => destination,
        transitionsBuilder: (_, animation, __, child) {
          final isForward = index > selectedIndex;
          final begin = Offset(isForward ? 1.0 : -1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}
