import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/product_entity.dart';

part 'product_apimodel.g.dart';

final productApiModelProvider = Provider(
  (ref) => ProductApiModel.empty(),
);

@JsonSerializable()
class ProductApiModel {
  @JsonKey(name: '_id')
  final String? productId;

  final String? image;

  final String name;

  final String price;

  final String desc;
  final String? experience;
  final String category;

  ProductApiModel({
    this.productId,
    this.image,
    required this.name,
    required this.price,
    required this.desc,
    this.experience,
    required this.category,
  });

  ProductApiModel.empty()
      : this(
          productId: '',
          image: '',
          name: '',
          price: '',
          desc: '',
          experience: '',
          category: '',
        );

  ProductEntity toEntity() => ProductEntity(
        productId: productId,
        image: image,
        name: name,
        price: price,
        desc: desc,
        experience: experience,
        category: category,
      );

  ProductApiModel toApiModel(ProductEntity entity) => ProductApiModel(
        productId: productId ?? '',
        image: entity.image,
        name: entity.name,
        price: entity.price,
        desc: entity.desc,
        experience: entity.experience,
        category: entity.category,
      );

  List<ProductApiModel> toApiModelList(List<ProductEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  //From Json

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  @override
  String toString() {
    return 'productId: $productId, productName: $name, productImage: $image, price: $price';
  }
}
