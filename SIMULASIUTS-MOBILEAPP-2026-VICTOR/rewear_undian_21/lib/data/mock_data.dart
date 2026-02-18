import '../models/buyers_model.dart';
import '../models/sellers_model.dart';
import '../models/products_model.dart';
import '../models/orders_model.dart';

List<Buyer> mockBuyers = [
  Buyer(buyerId: 1, phoneNumber: 8236734521, name: 'Raisha67'),
];

List<Seller> mockSellers = [
  Seller(
    sellerId: 1,
    totalSales: 1024000,
    rating: 4.8,
    totalSold: 156,
    totalOrders: 45,
  ),
];

List<Products> mockProducts = [
  Products(
    id: 1,
    name: 'Mini Dress',
    image: 'assets/images/mini.png',
    price: 505000,
    stock: 8,
    size: 'S',
    color: 'Green',
    discount: 0,
  ),
  Products(
    id: 2,
    name: 'Evie Mini Dress',
    image: 'assets/images/eve.png',
    price: 180000,
    stock: 12,
    size: 'S',
    color: 'Yellow',
    discount: 0,
  ),
  Products(
    id: 3,
    name: 'Long Crop Top',
    image: 'assets/images/long.png',
    price: 140000,
    stock: 15,
    size: 'M',
    color: 'Dark Gray',
    discount: 0,
  ),
];

List<Orders> mockOrders = [
  Orders(
    orderId: 2598118027,
    buyerId: 1,
    orderDate: '2025-02-20',
    productId: 1,
    quantity: 1,
    size: 'S',
    color: 'Green',
    courier: 'J&T Express',
    shippingAddress:
        'Jl. Raya Srikaya Blok 3.O No.3, RT.10/RW.4, Pagedangan, Kec. Pagedangan, Kabupaten Tangerang, Banten 15339',
    totalPrice: 389000,
    shippingFee: 10000,
    total: 399000,
    status: 'Processing',
  ),
  Orders(
    orderId: 1787855662,
    buyerId: 1,
    orderDate: '2025-02-19',
    productId: 2,
    quantity: 1,
    size: 'S',
    color: 'Yellow',
    courier: 'SiCepat',
    shippingAddress:
        'Jl. Raya Srikaya Blok 3.O No.3, RT.10/RW.4, Pagedangan, Kec. Pagedangan, Kabupaten Tangerang, Banten 15339',
    totalPrice: 126000,
    shippingFee: 9000,
    total: 135000,
    status: 'On Delivery',
  ),
  Orders(
    orderId: 1787855663,
    buyerId: 1,
    orderDate: '2025-02-16',
    productId: 3,
    quantity: 1,
    size: 'M',
    color: 'Dark Gray',
    courier: 'JNE',
    shippingAddress:
        'Jl. Raya Srikaya Blok 3.O No.3, RT.10/RW.4, Pagedangan, Kec. Pagedangan, Kabupaten Tangerang, Banten 15339',
    totalPrice: 140000,
    shippingFee: 12000,
    total: 152000,
    status: 'Processing',
  ),
];
