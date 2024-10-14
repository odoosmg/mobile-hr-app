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

  List<String>? listStrDates;

  PublicHolidayModel();

  factory PublicHolidayModel.fromJson(Map<String, dynamic> json) =>
      _$PublicHolidayModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicHolidayModelToJson(this);

  /// only String date, ["2024-10-01", "2024-10-02", ...]
  List<String> getListStrDates() {
    if (holidays == null) {
      return [];
    }

    return holidays!.map((e) => e.date!).toList();
  }
}
