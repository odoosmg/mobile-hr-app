import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'app_local.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class AppLocal {
  static const boxName = 'AppLocal';
  @HiveField(0)
  int? id;

  @HiveField(1)
  bool? isConnectInternet;

  @HiveField(2, defaultValue: false)
  bool isDarkMode = false;

  @HiveField(3)
  String? lang;

  /// purpose is to show once.
  @HiveField(4, defaultValue: false)
  @ValueKey(false)
  @JsonValue(false)
  bool? isOnboardClose;

  AppLocal();

  factory AppLocal.fromJson(Map<String, dynamic> json) =>
      _$AppLocalFromJson(json);

  Map<String, dynamic> toJson() => _$AppLocalToJson(this);
}
