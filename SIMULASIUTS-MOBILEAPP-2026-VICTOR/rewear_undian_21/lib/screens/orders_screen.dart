import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/orders_model.dart';
import '../models/products_model.dart';
import '../widgets/ordercard.dart';
import '../widgets/botnav.dart';
import 'orderdetail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedNav = 2;

  List<Orders> get newOrders =>
      mockOrders.where((o) => o.status != 'Delivered').toList()
        ..sort((a, b) => b.orderId.compareTo(a.orderId));

  Products? _productById(int id) => mockProducts.cast<Products?>().firstWhere(
    (p) => p?.id == id,
    orElse: () => null,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            Expanded(
              child: newOrders.isEmpty
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                      child: Column(
                        children: List.generate(newOrders.length, (i) {
                          final order = newOrders[i];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: OrderCard(
                              order: order,
                              product: _productById(order.productId),
                              onDetails: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        OrderDetailScreen(order: order),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedNav,
        onTap: (i) => setState(() => _selectedNav = i),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF111111),
                size: 22,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
          ),
          const Text(
            'New Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Color(0xFFCCCCCC)),
          SizedBox(height: 16),
          Text(
            'No new orders yet',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF999999),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
