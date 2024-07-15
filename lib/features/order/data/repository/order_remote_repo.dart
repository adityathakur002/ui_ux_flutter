import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/core/failure/failure.dart';
import 'package:gadget_store/features/order/domain/entity/order_entity.dart';

import '../../domain/repository/order_repository.dart';
import '../data_source/order_remote_datasource.dart';

final cartRemoteRepoProvider = Provider(
  (ref) => CartRemoteRepository(
    cartRemoteDataSource: ref.read(cartRemoteDataSourceProvider),
  ),
);

class CartRemoteRepository implements ICartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRemoteRepository({required this.cartRemoteDataSource});
  @override
  Future<Either<Failure, bool>> addCart(CartEntity cart) {
    return cartRemoteDataSource.addCart(cart);
  }

  @override
  Future<Either<Failure, bool>> deleteCart(String cartId) {
    return cartRemoteDataSource.deleteCart(cartId);
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getAllCarts() {
    return cartRemoteDataSource.getAllCarts();
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCart(String user) {
    return cartRemoteDataSource.getCart(user);
  }
}
