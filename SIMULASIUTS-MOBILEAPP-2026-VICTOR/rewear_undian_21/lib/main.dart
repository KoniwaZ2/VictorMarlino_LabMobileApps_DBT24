import 'package:flutter/material.dart';
import 'screens/sellerdashboard_screen.dart';

void main() {
  runApp(const RewearApp());
}

class RewearApp extends StatelessWidget {
  const RewearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rewear',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const SellerDashboardScreen(),
    );
  }
}
