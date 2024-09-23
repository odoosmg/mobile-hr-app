// import 'package:employee_attendance/models/auth/user_model.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'session.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Session {
  static const boxName = 'Session';
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? username;

  @HiveField(2)
  String? accessToken;

  @HiveField(3)
  int? userId;

  @HiveField(4)
  Session? data;

  @HiveField(5)
  String? refreshToken;

  @HiveField(6)
  UserModel? myProfile;

  Session();

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
