class CartEntity {
  final String? orderId;

  final String userId;

  final String productId;

  final String name;

  final String image;

  final String price;

  final String? quantity;

  CartEntity({
    this.orderId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    this.quantity,
  });
}
