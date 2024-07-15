// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      orderId: json['_id'] as String?,
      userId: json['user'] as String,
      productId: json['product'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      image: json['image'] as String,
      quantity: json['quantity'] as String?,
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.orderId,
      'user': instance.userId,
      'product': instance.productId,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'quantity': instance.quantity,
    };
