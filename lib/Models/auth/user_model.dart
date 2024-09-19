import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class UserModel {
  static const boxName = 'UserModel';
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phone;

  @HiveField(4)
  String? department;

  @HiveField(5)
  String? position;

  @HiveField(6)
  String? company;

  @HiveField(7)
  String? image;

  @HiveField(8)
  String? manager;

  @HiveField(9)
  String? status;

  @HiveField(10)
  String? employeeName;

  @HiveField(11)
  String? departmentName;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
