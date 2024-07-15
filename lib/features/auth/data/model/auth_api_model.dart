import 'package:gadget_store/features/auth/domain/entity/student_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;

  final String? image;

  final String fname;
  final String lname;

  final String phone;

  final String username;
  final String password;

  AuthApiModel({
    this.id,
    this.image,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.username,
    required this.password,
  });

  AuthApiModel.empty()
      : this(
          id: '',
          image: '',
          fname: '',
          lname: '',
          phone: '',
          username: '',
          password: '',
        );

  StudentEntity toEntity() => StudentEntity(
        id: id,
        image: image,
        fname: fname,
        lname: lname,
        phone: phone,
        username: username,
        password: password,
      );

  AuthApiModel toApiModel(StudentEntity entity) => AuthApiModel(
        id: id ?? '',
        image: entity.image,
        fname: entity.fname,
        lname: entity.lname,
        phone: entity.phone,
        username: entity.username,
        password: entity.password,
      );

  List<AuthApiModel> toApiModelList(List<StudentEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  List<StudentEntity> toEntityList(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //From Json

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  @override
  String toString() {
    return 'id: $id, image: $image, fname: $fname, lname: $lname, phone: $phone,username: $username';
  }
}
