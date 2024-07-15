import '../../domain/entity/product_entity.dart';

class ProductState {
  final bool isLoading;

  final List<ProductEntity> products;
  ProductEntity singleProduct;

  final String? error;

  final String? imageName;

  ProductState({
    required this.isLoading,
    required this.products,
    this.error,
    this.imageName,
    required this.singleProduct,
  });

  factory ProductState.initial() {
    return ProductState(
      isLoading: false,
      products: [],
      imageName: null,
      singleProduct: ProductEntity(
        name: 'dlkjfl',
        price: 'dfj',
        desc: 'dlfj',
        experience: 'exp',
        category: 'all',
      ),
    );
  }

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    String? error,
    ProductEntity? singleProduct,
    String? imageName,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      singleProduct: singleProduct ?? this.singleProduct,
    );
  }
}
