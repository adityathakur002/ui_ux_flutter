import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/product_remote_data.dart';

final productRemoteRepoProvider = Provider(
  (ref) => ProductRemoteRepository(
    productRemoteDataSource: ref.read(productRemoteDataSourceProvider),
  ),
);

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRemoteRepository({
    required this.productRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> addProduct(ProductEntity product) {
    return productRemoteDataSource.addProduct(product);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return productRemoteDataSource.getAllProducts();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return productRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String productId) {
    return productRemoteDataSource.getProductById(productId);
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(String productId) {
    return productRemoteDataSource.deleteProduct(productId);
  }

  @override
  Future<Either<Failure, bool>> editProduct(
      String productId, ProductEntity product) {
    return productRemoteDataSource.editProduct(productId, product);
  }
}
