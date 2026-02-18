import 'package:flutter/material.dart';
import '../models/products_model.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  final String dateReleased;
  final VoidCallback? onEdit;

  const ProductCard({
    super.key,
    required this.product,
    required this.dateReleased,
    this.onEdit,
  });

  String _formatCurrency(int price) {
    final str = price.toInt().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'Rp${buffer.toString()}';
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
    final discountedPrice = product.price * (1 - product.discount);
    final hasDiscount = product.discount > 0;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Date Released
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Row(
              children: [
                const Text(
                  'Date Released : ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                ),
                Text(
                  dateReleased,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 110,
                    height: 130,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: _parseColor(product.color).withOpacity(0.25),
                        child: const Center(
                          child: Icon(
                            Icons.checkroom,
                            size: 36,
                            color: Color(0xFFAAAAAA),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),

                      // Name
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                        ),
                      ),
                      const SizedBox(height: 10),

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
                          _SizeChip(size: product.size),
                          const SizedBox(width: 14),
                          const Text(
                            'Color',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF555555),
                            ),
                          ),
                          const SizedBox(width: 6),
                          _ColorDot(color: _parseColor(product.color)),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Price + Edit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              _formatCurrency(discountedPrice),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111111),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _EditButton(onPressed: onEdit),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Promotion / padding bottom
          if (hasDiscount)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Promotion :  Disc ${(product.discount * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFCC2200),
                  ),
                ),
              ),
            )
          else
            const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SizeChip extends StatelessWidget {
  final String size;
  const _SizeChip({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFEEEEEE),
      ),
      alignment: Alignment.center,
      child: Text(
        size,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
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
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.black12),
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _EditButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF111111),
        side: const BorderSide(color: Color(0xFF111111), width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        'Edit',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}
