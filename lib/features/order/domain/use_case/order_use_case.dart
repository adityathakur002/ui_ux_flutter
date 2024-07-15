import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/order_entity.dart';
import '../repository/order_repository.dart';

final cartUseCaseProvider = Provider(
  (ref) => CartUseCase(cartRepository: ref.read(cartRepositoryProvider)),
);

class CartUseCase {
  final ICartRepository cartRepository;

  CartUseCase({
    required this.cartRepository,
  });

  Future<Either<Failure, List<CartEntity>>> getAllCarts() {
    return cartRepository.getAllCarts();
  }

  Future<Either<Failure, bool>> addCart(CartEntity cart) {
    return cartRepository.addCart(cart);
  }

  Future<Either<Failure, bool>> deleteCart(String cartId) {
    return cartRepository.deleteCart(cartId);
  }

  Future<Either<Failure, List<CartEntity>>> getCart(String user) {
    return cartRepository.getCart(user);
  }
}
