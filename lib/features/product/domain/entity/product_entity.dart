class ProductEntity {
  final String? productId;

  final String name;

  final String? image;

  final String price;

  final String desc;
  final String? experience;
  final String category;

  ProductEntity({
    this.productId,
    required this.name,
    this.image,
    required this.price,
    required this.desc,
    this.experience,
    required this.category,
  });
}
