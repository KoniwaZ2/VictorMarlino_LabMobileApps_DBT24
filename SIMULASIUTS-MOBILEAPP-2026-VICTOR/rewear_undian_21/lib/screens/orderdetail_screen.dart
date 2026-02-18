// lib/screens/orderdetail_screen.dart

import 'package:flutter/material.dart';
import '../models/orders_model.dart';
import '../models/products_model.dart';
import '../models/buyers_model.dart';
import '../data/mock_data.dart';

class OrderDetailScreen extends StatelessWidget {
  final Orders order;

  const OrderDetailScreen({super.key, required this.order});

  Products? get _product {
    try {
      return mockProducts.firstWhere((p) => p.id == order.productId);
    } catch (_) {
      return null;
    }
  }

  Buyer? get _buyer {
    try {
      return mockBuyers.firstWhere((b) => b.buyerId == order.buyerId);
    } catch (_) {
      return null;
    }
  }

  String get _orderRef =>
      '#PUR-${order.orderId.toRadixString(16).toUpperCase().padLeft(8, '0')}';

  String _formatCurrency(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'Rp${buffer.toString()}';
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
      'Mei',
      'Jun',
      'Jul',
      'Agt',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final month = int.tryParse(parts[1]) ?? 0;
    return '${int.tryParse(parts[2]) ?? parts[2]} ${months[month]} ${parts[0]}';
  }

  Color _parseColor(String colorName) {
    final map = {
      'merah kotak': const Color(0xFFB94040),
      'biru tua': const Color(0xFF1A3A5C),
      'krem': const Color(0xFFD4C5A9),
      'putih': const Color(0xFFF0F0F0),
      'abu-abu': const Color(0xFF808080),
      'bunga pastel': const Color(0xFFE8B4C8),
    };
    return map[colorName.toLowerCase()] ?? const Color(0xFF999999);
  }

  @override
  Widget build(BuildContext context) {
    final product = _product;
    final buyer = _buyer;
    final int productPrice = product != null ? product.price : 0;
    final int total = order.total;
    final int subtotal = order.totalPrice;
    final int shippingFee = order.shippingFee;
    final int discount = 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            _buildTopBar(context),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ── Section 1: Order Info
                    _buildCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'New Order',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          Text(
                            _orderRef,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8B5E3C),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _infoRow(
                            label: 'Nama Pembeli',
                            value: buyer?.name ?? '-',
                          ),
                          const SizedBox(height: 10),
                          _infoRow(
                            label: 'Tanggal Pembelian',
                            value: _formatDate(order.orderDate),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Section 2: Product Detail
                    _buildCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Detail',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 80,
                                  height: 90,
                                  child: product != null
                                      ? Image.asset(
                                          product.image,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              _imgPlaceholder(product.color),
                                        )
                                      : Container(
                                          color: const Color(0xFFEEEEEE),
                                          child: const Icon(
                                            Icons.checkroom,
                                            color: Color(0xFFAAAAAA),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Name + Size + Color
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product != null
                                          ? '${product.name} - ${order.color}'
                                          : '-',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF111111),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Text(
                                          'Size',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF888888),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        _SizeChip(size: order.size),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          'Color',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF888888),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        _ColorDot(
                                          color: _parseColor(order.color),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Qty x Price
                              Text(
                                '${order.quantity} x ${_formatCurrency(productPrice)}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111111),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Section 3: Shipping Details
                    _buildCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Shipping Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _shippingRow(
                            label: 'Delivery',
                            value: order.courier,
                            bold: true,
                          ),
                          const SizedBox(height: 12),
                          _shippingRow(
                            label: 'Alamat',
                            value:
                                '${buyer?.name ?? '-'}\n+62${buyer?.phoneNumber ?? '-'}\n${order.shippingAddress}',
                            bold: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Section 4: Payment Details ───────────────────
                    _buildCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Payment Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _paymentRow(
                            label: 'Subtotal Product',
                            value: _formatCurrency(subtotal),
                          ),
                          _dottedDivider(),
                          _paymentRow(
                            label: 'Delivery Fee',
                            value: _formatCurrency(shippingFee),
                          ),
                          _dottedDivider(),
                          if (discount > 0) ...[
                            _paymentRow(
                              label: 'Discount',
                              value: '- ${_formatCurrency(discount)}',
                              valueColor: const Color(0xFFCC2200),
                            ),
                            _dottedDivider(),
                          ],
                          const SizedBox(height: 4),
                          _paymentRow(
                            label: 'Total',
                            value: _formatCurrency(total),
                            bold: true,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Accept Order Button
            _buildAcceptButton(context),
          ],
        ),
      ),
    );
  }

  // ── Top Bar ───────────────────────────────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
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
            'Order Details',
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

  // ── Accept Button ─────────────────────────────────────────────────────────

  Widget _buildAcceptButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            // TODO: handle accept order
            Navigator.maybePop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF111111),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Accept Order',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  // ── Reusable widgets ──────────────────────────────────────────────────────

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _infoRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF888888)),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111111),
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _shippingRow({
    required String label,
    required String value,
    bool bold = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF888888)),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              color: const Color(0xFF111111),
            ),
          ),
        ),
      ],
    );
  }

  Widget _paymentRow({
    required String label,
    required String value,
    bool bold = false,
    double fontSize = 14,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: const Color(0xFF555555),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ?? const Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dottedDivider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 5.0;
        const dashSpace = 4.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(
            count,
            (_) => Padding(
              padding: const EdgeInsets.only(right: dashSpace),
              child: Container(
                width: dashWidth,
                height: 1,
                color: const Color(0xFFCCCCCC),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _imgPlaceholder(String colorName) {
    return Container(
      color: _parseColor(colorName).withOpacity(0.2),
      child: const Center(
        child: Icon(Icons.checkroom, color: Color(0xFFAAAAAA)),
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _SizeChip extends StatelessWidget {
  final String size;
  const _SizeChip({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFEEEEEE),
      ),
      alignment: Alignment.center,
      child: Text(
        size,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Color(0xFF333333),
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  const _ColorDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.black12),
      ),
    );
  }
}
