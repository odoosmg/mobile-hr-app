import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';

class ProfileBarListener extends StatelessWidget {
  final Widget Function(Session) builder;
  const ProfileBarListener({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            AppServices.instance<DatabaseService>().session!.listenable(),
        builder: (context, box, widget) {
          return builder(box.get(Session.boxName) ?? Session());
        });
  }
}
