import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_status_model.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Models/leave/leave_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'in_out_model.g.dart';

@JsonSerializable()
class InOutModel {
  int? id;
  int? checkInId;
  int? checkIn; // will remove after api change
  String? checkOutDatetime;
  String? checkInDatetime;

  InOutModel? latestCheckIn;
  InOutModel? latestCheckOut;

  List<LeaveModel>? leaveSummary;
  List<UserModel>? todayLeave;
  List<InOutModel>? list;
  int? page;
  String? workHours;

  /// to check when onRefresh or onLoad.
  ApiStatus? dataStatus;

  InOutModel();

  factory InOutModel.fromJson(Map<String, dynamic> json) =>
      _$InOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$InOutModelToJson(this);
}
