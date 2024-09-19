import 'package:json_annotation/json_annotation.dart';
part 'api_status_model.g.dart';

@JsonSerializable()
class ApiStatusModel<T> {
  int? statusCode;
  String? errorMessage;

  ApiStatusModel();

  factory ApiStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ApiStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiStatusModelToJson(this);
}
