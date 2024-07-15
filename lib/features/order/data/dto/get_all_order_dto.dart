import 'package:json_annotation/json_annotation.dart';

import '../model/order_api_model.dart';

part 'get_all_order_dto.g.dart';

@JsonSerializable()
class GetAllCartDTO {
  final bool success;

  final int count;

  final List<CartApiModel> data;

  GetAllCartDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllCartDTOToJson(this);

  //From Json

  factory GetAllCartDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCartDTOFromJson(json);
}
