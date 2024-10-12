import 'package:json_annotation/json_annotation.dart';
part 'public_holiday_model.g.dart';

@JsonSerializable()
class PublicHolidayModel {
  int? id;
  String? name;
  String? date;
  String? month;

  List<PublicHolidayModel>? list;
  List<PublicHolidayModel>? holidays;

  PublicHolidayModel();

  factory PublicHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$PublicHolidayModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicHolidayModelToJson(this);
}
