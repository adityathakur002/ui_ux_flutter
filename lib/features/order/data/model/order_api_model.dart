import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/order_entity.dart';

part 'order_api_model.g.dart';

final cartApiModelProvider = Provider(
  (ref) => CartApiModel.empty(),
);

@JsonSerializable()
class CartApiModel {
  @JsonKey(name: '_id')
  final String? orderId;

  @JsonKey(name: 'user')
  final String userId;

  @JsonKey(name: 'product')
  final String productId;

  final String name;

  final String image;

  final String price;

  final String? quantity;

  CartApiModel({
    this.orderId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    this.quantity,
  });

  CartApiModel.empty()
      : this(
          orderId: '',
          userId: '',
          productId: '',
          name: '',
          price: '',
          image: '',
          quantity: null,
        );

  CartEntity toEntity() => CartEntity(
        orderId: orderId,
        userId: userId,
        productId: productId,
        name: name,
        price: price,
        image: image,
        quantity: quantity,
      );

  CartApiModel toApiModel(CartEntity entity) => CartApiModel(
        orderId: orderId ?? '',
        userId: entity.userId,
        productId: entity.productId,
        name: entity.name,
        price: entity.price,
        image: entity.image,
        quantity: entity.quantity,
      );

  List<CartApiModel> toApiModelList(List<CartEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  List<CartEntity> toEntityList(List<CartApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson

  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  //From Json

  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  @override
  String toString() {
    return 'cartId: $orderId, userId: $userId, productId: $productId';
  }
}
