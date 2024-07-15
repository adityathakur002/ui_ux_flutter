import '../../domain/entity/order_entity.dart';

class CartState {
  final bool isLoading;

  final List<CartEntity> carts;

  final List<CartEntity> allcarts;

  final String? error;

  CartState({
    required this.isLoading,
    required this.carts,
    required this.allcarts,
    this.error,
  });

  factory CartState.initial() {
    return CartState(
      isLoading: false,
      carts: [],
      allcarts: [],
    );
  }

  CartState copyWith({
    bool? isLoading,
    List<CartEntity>? carts,
    List<CartEntity>? allcarts,
    String? error,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      carts: carts ?? this.carts,
      error: error ?? this.error,
      allcarts: allcarts ?? this.allcarts,
    );
  }
}
