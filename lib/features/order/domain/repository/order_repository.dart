import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/order_remote_repo.dart';
import '../entity/order_entity.dart';

final cartRepositoryProvider = Provider<ICartRepository>((ref) {
  return ref.watch(cartRemoteRepoProvider);
});

abstract class ICartRepository {
  Future<Either<Failure, bool>> addCart(CartEntity cart);

  Future<Either<Failure, List<CartEntity>>> getAllCarts();

  Future<Either<Failure, List<CartEntity>>> getCart(String user);

  Future<Either<Failure, bool>> deleteCart(String cartId);
}
