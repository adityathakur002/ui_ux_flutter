// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_byId_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductByIdDTO _$GetProductByIdDTOFromJson(Map<String, dynamic> json) =>
    GetProductByIdDTO(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetProductByIdDTOToJson(GetProductByIdDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
