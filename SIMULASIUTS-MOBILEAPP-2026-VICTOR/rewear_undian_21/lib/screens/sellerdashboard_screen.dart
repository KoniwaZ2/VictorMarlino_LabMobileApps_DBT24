import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/orders_model.dart';
import '../models/products_model.dart';
import '../models/buyers_model.dart';
import '../models/sellers_model.dart';
import '../widgets/botnav.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  int _selectedNav = 0;

  Seller get seller => mockSellers.first;

  String get formattedTotalSales {
    return 'Rp ${seller.totalSales}';
  }

  int get totalOrdersCount => mockOrders.length;

  int get ordersToBePacked =>
      mockOrders.where((o) => o.status == 'Processing').length;

  int get ordersInTransit =>
      mockOrders.where((o) => o.status == 'On Delivery').length;

  int get ordersCompleted =>
      mockOrders.where((o) => o.status == 'Delivered').length;

  /// Returns the 3 most recent orders (by orderId desc)
  List<Orders> get recentOrders {
    final sorted = [...mockOrders]
      ..sort((a, b) => b.orderId.compareTo(a.orderId));
    return sorted.take(3).toList();
  }

  String _formatCurrency(num amount) {
    return 'Rp ${amount.toInt()}';
  }

  String _formatDate(String dateStr) {
    final parts = dateStr.split('-');
    if (parts.length != 3) return dateStr;
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final month = int.tryParse(parts[1]) ?? 0;
    return '${months[month]} ${parts[2]}, ${parts[0]}';
  }

  String _orderRef(int orderId) =>
      '#PUR-${orderId.toRadixString(16).toUpperCase().padLeft(8, '0')}';

  Products? _productById(int id) => mockProducts.cast<Products?>().firstWhere(
    (p) => p?.id == id,
    orElse: () => null,
  );

  Buyer? _buyerById(int id) => mockBuyers.cast<Buyer?>().firstWhere(
    (b) => b?.buyerId == id,
    orElse: () => null,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildSalesCard(),
                    _buildRecentOrdersSection(),
                    _buildOverviewSection(),
                    const SizedBox(height: 24),
                  ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Logo — perfectly centered
          const Text(
            'R≡W≡AR',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 5,
              color: Color(0xFF111111),
            ),
          ),
          // Chat button — pinned to the right
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFDDDDDD)),
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                size: 18,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Sales',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),

            // Total Sales + Orders
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _statBox(
                      label: 'Total Sales',
                      value: formattedTotalSales,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _statBox(
                      label: 'Orders',
                      value: seller.totalOrders.toString(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ratings header
            Row(
              children: [
                const Text(
                  'Ratings and Reviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Rating + Total Purchased
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_border,
                            size: 22,
                            color: Color(0xFF111111),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            seller.rating.toStringAsFixed(
                              seller.rating % 1 == 0 ? 0 : 1,
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Total purchased',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            seller.totalSold.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBox({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Text(
            'Recent Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
        ),
        ...recentOrders.map((order) => _buildOrderCard(order)),
      ],
    );
  }

  Widget _buildOrderCard(Orders order) {
    // Badge styling
    Color badgeBg;
    Color badgeFg;

    switch (order.status) {
      case 'Delivered':
        badgeBg = const Color(0xFFE6F9F0);
        badgeFg = const Color(0xFF1A9E5C);
        break;
      case 'On Delivery':
        badgeBg = const Color(0xFFE8F0FE);
        badgeFg = const Color(0xFF1A5CC4);
        break;
      case 'Processing':
        badgeBg = const Color(0xFFFFF8E1);
        badgeFg = const Color(0xFFC48A00);
        break;
      case 'Pending':
        badgeBg = const Color(0xFFFFF0E6);
        badgeFg = const Color(0xFFC45A00);
        break;
      default:
        badgeBg = const Color(0xFFF0F0F0);
        badgeFg = const Color(0xFF666666);
    }

    final product = _productById(order.productId);
    final buyer = _buyerById(order.buyerId);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF0F0F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID row + badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _orderRef(order.orderId),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: badgeFg,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Buyer + product info
            if (buyer != null)
              Text(
                buyer.name,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF555555),
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (product != null)
              Text(
                '${order.quantity} item${order.quantity > 1 ? 's' : ''} · ${product.name}',
                style: const TextStyle(fontSize: 13, color: Color(0xFF555555)),
              ),
            const SizedBox(height: 4),
            Text(
              _formatCurrency(order.total),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 8),

            // Date + courier + view details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      _formatDate(order.orderDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF999999),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        order.courier,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111111),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
    final items = [
      _OverviewEntry(
        icon: Icons.inventory_2_outlined,
        label: 'Orders to be Packed',
        count: ordersToBePacked,
      ),
      _OverviewEntry(
        icon: Icons.local_shipping_outlined,
        label: 'Orders in Transit',
        count: ordersInTransit,
      ),
      _OverviewEntry(
        icon: Icons.check_circle_outline,
        label: 'Orders Completed',
        count: ordersCompleted,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Text(
            'Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ...items.map(
                (item) => _buildOverviewRow(
                  icon: item.icon,
                  label: item.label,
                  count: item.count.toString(),
                ),
              ),
              _buildOverviewRow(
                icon: Icons.account_balance_wallet,
                label: 'My Balance',
                count: null,
                darkIcon: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewRow({
    required IconData icon,
    required String label,
    String? count,
    bool darkIcon = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: darkIcon
                      ? const Color(0xFF111111)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: darkIcon ? Colors.white : const Color(0xFF111111),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
              if (count != null) ...[
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111111),
                  ),
                ),
                const SizedBox(width: 10),
              ],
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF999999),
                size: 20,
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFF0F0F0)),
      ],
    );
  }
}

class _OverviewEntry {
  final IconData icon;
  final String label;
  final int count;
  const _OverviewEntry({
    required this.icon,
    required this.label,
    required this.count,
  });
}
