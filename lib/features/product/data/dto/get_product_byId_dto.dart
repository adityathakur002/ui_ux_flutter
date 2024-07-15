import 'package:json_annotation/json_annotation.dart';

import '../model/product_apimodel.dart';

part 'get_product_byId_dto.g.dart';

@JsonSerializable()
class GetProductByIdDTO {
  final bool success;

  final List<ProductApiModel> data;

  GetProductByIdDTO({
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetProductByIdDTOToJson(this);

  //From Json

  factory GetProductByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetProductByIdDTOFromJson(json);
}
