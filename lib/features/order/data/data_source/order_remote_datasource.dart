import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/order_entity.dart';
import '../dto/get_all_order_dto.dart';
import '../model/order_api_model.dart';

final cartRemoteDataSourceProvider = Provider(
  (ref) => CartRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    cartApiModel: ref.read(cartApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class CartRemoteDataSource {
  final Dio dio;

  final CartApiModel cartApiModel;

  final UserSharedPrefs userSharedPrefs;

  CartRemoteDataSource({
    required this.dio,
    required this.cartApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addCart(CartEntity cart) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createCart,
        data: {
          "user": cart.userId,
          "product": cart.productId,
          "name": cart.name,
          "price": cart.price,
          "image": cart.image,
          "quantity": cart.quantity,
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

  Future<Either<Failure, List<CartEntity>>> getAllCarts() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCart);

      if (response.statusCode == 200) {
        // OR

        // 2nd way

        GetAllCartDTO orderDTO = GetAllCartDTO.fromJson(response.data);

        return Right(cartApiModel.toEntityList(orderDTO.data));
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

  Future<Either<Failure, bool>> deleteCart(String cartId) async {
    try {
      // Get the token from shared prefs

      String? token;

      var data = await userSharedPrefs.getUserToken();

      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteCart + cartId,
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

  Future<Either<Failure, List<CartEntity>>> getCart(String user) async {
    try {
      var response = await dio.post(ApiEndpoints.getCart, data: {
        "user": user,
      });

      if (response.statusCode == 200) {
        // OR

        // 2nd way

        GetAllCartDTO productDTO = GetAllCartDTO.fromJson(response.data);

        return Right(cartApiModel.toEntityList(productDTO.data));
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
}
