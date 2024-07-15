import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/core/shared_prefs/user_shared_prefs.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../domain/entity/product_entity.dart';
import '../dto/get_product_dto.dart';
import '../model/product_apimodel.dart';

final productRemoteDataSourceProvider = Provider(
  (ref) => ProductRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    productApiModel: ref.read(productApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class ProductRemoteDataSource {
  final Dio dio;

  final ProductApiModel productApiModel;
  final UserSharedPrefs userSharedPrefs;

  ProductRemoteDataSource({
    required this.dio,
    required this.productApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addProduct(ProductEntity product) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createProduct,
        data: {
          "name": product.name,
          "image": product.image,
          "price": product.price,
          "desc": product.desc,
          "category": product.category,
        },
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllProducts);

      if (response.statusCode == 200) {
        // OR

        // 2nd way

        GetAllProductDTO productDTO = GetAllProductDTO.fromJson(response.data);

        return Right(productApiModel.toEntityList(productDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        )
      });
      Response response = await dio.post(
        ApiEndpoints.uploadProductImage,
        data: formData,
      );
      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
            error: e.error.toString(),
            statusCode: e.response?.statusCode.toString() ?? '0'),
      );
    }
  }

  Future<Either<Failure, ProductEntity>> getProductById(
      String productId) async {
    try {
      var response = await dio.get(ApiEndpoints.getProduct + productId);

      if (response.statusCode == 200) {
        // OR

        // 2nd way

        // GetAllProductDTO singleproductDTO =

        //     GetAllProductDTO.fromJson(response.data);

        // var product = (response.data['data'] as List)

        //     .map((pro) => ProductApiModel.fromJson(pro).toEntity())

        //     .toList();

        var product =
            ProductApiModel.fromJson(response.data['data']).toEntity();

        return Right(product);

        // GetProductByIdDTO singleproductDTO =

        //     GetProductByIdDTO.fromJson(response.data);

        // return Right(productApiModel.toEntityList(singleproductDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> editProduct(
      String productId, ProductEntity product) async {
    try {
      // Get the token from shared prefs

      String? token;

      var data = await userSharedPrefs.getUserToken();

      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.put(
        ApiEndpoints.editProduct + productId,
        data: {
          // "productName": product.productName,
          // "productImage": product.productImage,
          // "price": product.price,
          // "category": product.category,
          // "desc": product.desc,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteProduct(String productId) async {
    try {
      // Get the token from shared prefs

      String? token;

      var data = await userSharedPrefs.getUserToken();

      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteProduct + productId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
