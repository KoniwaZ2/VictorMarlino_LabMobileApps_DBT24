class Orders {
  final int orderId;
  final int buyerId;
  final String orderDate;
  final int productId;
  final int quantity;
  final String size;
  final String color;
  final String courier;
  final String shippingAddress;
  final int totalPrice;
  final int shippingFee;
  final int total;
  final String status;

  Orders({
    required this.orderId,
    required this.buyerId,
    required this.orderDate,
    required this.productId,
    required this.quantity,
    required this.size,
    required this.color,
    required this.courier,
    required this.shippingAddress,
    required this.totalPrice,
    required this.shippingFee,
    required this.total,
    required this.status,
  });
}
