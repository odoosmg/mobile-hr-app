import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'public_holiday_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class PublicHolidayModel {
  static const boxName = 'PublicHolidayModel';
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? date;

  @HiveField(3)
  String? month;

  @HiveField(4)
  List<PublicHolidayModel>? list;

  @HiveField(5)
  List<PublicHolidayModel>? holidays;

  @HiveField(6)
  List<PublicHolidayModel>? listCurre;

  @HiveField(7)
  List<PublicHolidayModel>? listCurrentYear;
  @HiveField(8)
  List<PublicHolidayModel>? listNextYear;

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

  ///
  List<String> listStrDates(List<PublicHolidayModel> d) {
    return d.map((e) => e.date!).toList();
  }
}
