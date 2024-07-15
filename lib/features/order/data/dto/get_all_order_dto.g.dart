// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCartDTO _$GetAllCartDTOFromJson(Map<String, dynamic> json) =>
    GetAllCartDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => CartApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCartDTOToJson(GetAllCartDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
