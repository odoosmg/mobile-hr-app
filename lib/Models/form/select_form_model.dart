import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'select_form_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class SelectFormModel {
  static const boxName = 'SelectFormModel';
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? keyword;

  @HiveField(3)
  bool? isSelected;

  @HiveField(4)
  List<SelectFormModel>? companySelected;
  @HiveField(5)
  List<SelectFormModel>? companyList;

  SelectFormModel();

  factory SelectFormModel.fromJson(Map<String, dynamic> json) =>
      _$SelectFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$SelectFormModelToJson(this);
}
