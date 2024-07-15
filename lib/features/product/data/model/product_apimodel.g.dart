// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_apimodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      productId: json['_id'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String,
      price: json['price'] as String,
      desc: json['desc'] as String,
      experience: json['experience'] as String?,
      category: json['category'] as String,
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'desc': instance.desc,
      'experience': instance.experience,
      'category': instance.category,
    };
