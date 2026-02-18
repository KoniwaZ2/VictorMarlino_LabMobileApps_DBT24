import 'package:flutter/material.dart';
import '../models/orders_model.dart';
import '../models/products_model.dart';

class OrderCard extends StatelessWidget {
  final Orders order;
  final Products? product;
  final VoidCallback? onDetails;

  const OrderCard({
    super.key,
    required this.order,
    this.product,
    this.onDetails,
  });

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

  String _formatDate(String dateStr) {
    final parts = dateStr.split('-');
    if (parts.length != 3) return dateStr;
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final month = int.tryParse(parts[1]) ?? 0;
    return '${int.tryParse(parts[2]) ?? parts[2]} ${months[month]} ${parts[0]}';
  }

  String _orderRef(int orderId) =>
      '#PUR-${orderId.toRadixString(16).toUpperCase().padLeft(8, '0')}';

  @override
  Widget build(BuildContext context) {
    final colorName = order.color;
    final dotColor = _parseColor(colorName);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Product Image
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 100,
                height: 110,
                child: product != null
                    ? Image.asset(
                        product!.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(dotColor),
                      )
                    : _placeholder(dotColor),
              ),
            ),
          ),

          // ── Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product?.name ?? 'Unknown Product',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(order.orderDate),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Size + Color
                  Row(
                    children: [
                      const Text(
                        'Size',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF555555),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _SizeChip(size: order.size),
                      const SizedBox(width: 12),
                      const Text(
                        'Color',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF555555),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _ColorDot(color: dotColor),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Order ref + Details button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111111),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _orderRef(order.orderId),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onDetails ?? () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF111111),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: 0,
                        ),
                        child: const Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder(Color color) {
    return Container(
      color: color.withOpacity(0.2),
      child: const Center(
        child: Icon(Icons.checkroom, size: 32, color: Color(0xFFAAAAAA)),
      ),
    );
  }
}

// ── Sub-widgets

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
