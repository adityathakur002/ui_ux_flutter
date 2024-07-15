import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/product_remote_repo.dart';
import '../entity/product_entity.dart';

final productRepositoryProvider = Provider<IProductRepository>(
  (ref) {
    // Check for the internet

    // final internetStatus = ref.watch(connectivityStatusProvider);

    // if (ConnectivityStatus.isConnected == internetStatus) {
    //   // If internet is available then return remote repo

    //   return ref.watch(productRemoteRepoProvider);
    // } else {
    //   // If internet is not available then return local repo

    //   return ref.watch(productLocalRepoProvider);
    // }

    return ref.watch(productRemoteRepoProvider);
  },
);

abstract class IProductRepository {
  Future<Either<Failure, bool>> addProduct(ProductEntity product);

  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, ProductEntity>> getProductById(String productId);
  Future<Either<Failure, bool>> deleteProduct(String productId);
  Future<Either<Failure, bool>> editProduct(
      String productId, ProductEntity product);
}
