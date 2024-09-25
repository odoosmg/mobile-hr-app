import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/navigation_service.dart';
import 'package:hrm_employee/generated/l10n/trans_localizations.dart';

class AppTrans {
  static final t = AppLocalizations.of(
      AppServices.instance<NavigatorService>().getCurrentContext)!;
}
