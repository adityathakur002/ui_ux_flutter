import 'package:json_annotation/json_annotation.dart';

import '../model/product_apimodel.dart';

part 'get_product_dto.g.dart';

@JsonSerializable()
class GetAllProductDTO {
  final bool success;

  final int count;

  final List<ProductApiModel> data;

  GetAllProductDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllProductDTOToJson(this);

  //From Json

  factory GetAllProductDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllProductDTOFromJson(json);
}
