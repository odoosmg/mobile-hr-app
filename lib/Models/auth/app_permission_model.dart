import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'app_permission_model.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class AppPermissionModel {
  static const boxName = 'AppPermissionModel';
  @HiveField(0)
  int? id;

  @HiveField(1)
  bool? isApprover;

  @HiveField(2)
  AppPermissionModel? leave;

  /// Retrieve success
  @HiveField(3)
  bool? isRetrieveSuccess;

  @HiveField(4)
  AppPermissionModel? data;

  AppPermissionModel();

  factory AppPermissionModel.fromJson(Map<String, dynamic> json) =>
      _$AppPermissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppPermissionModelToJson(this);
}
