import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hrm_employee/ConnectionCubit/connectivity_cubit.dart';
import 'package:hrm_employee/GlobalComponents/bloc/form-data/form_data_bloc.dart';
import 'package:hrm_employee/Repository/auth_repository.dart';
import 'package:hrm_employee/Repository/employee_repository.dart';
import 'package:hrm_employee/Repository/form_data_repository.dart';
import 'package:hrm_employee/Repository/home_repository.dart';
import 'package:hrm_employee/Repository/leave_repository.dart';
import 'package:hrm_employee/Repository/public_holiday_repository.dart';
import 'package:hrm_employee/Screens/Authentication/bloc/auth_bloc.dart';
import 'package:hrm_employee/Screens/Employee%20Directory/bloc/employee_bloc.dart';
import 'package:hrm_employee/Screens/Home/bloc/home_bloc.dart';
import 'package:hrm_employee/Screens/Leave%20Management/bloc/leave_bloc.dart';
import 'package:hrm_employee/Screens/PublicHoliday/Bloc/public_holiday_bloc.dart';

import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/global_scaffold_messenger_service.dart';
import 'package:hrm_employee/Services/navigation_service.dart';
import 'package:hrm_employee/generated/l10n/trans_localizations.dart';
import 'package:hrm_employee/l10n/l10n.dart';

import 'Screens/Splash Screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await AppServices.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(HomeRepository(), FormDataRepository()),
        ),
        BlocProvider(
          create: (context) => ConnectivityCubit(),
        ),
        BlocProvider(
          create: (context) => LeaveBloc(LeaveRepository()),
        ),
        BlocProvider(
          create: (context) => EmployeeBloc(EmployeeRepository()),
        ),
        BlocProvider(
          create: (context) => PublicHolidayBloc(PublicHolidayRepository()),
        ),
        BlocProvider(
          create: (context) => FormDataBloc(FormDataRepository()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: AppServices.instance<NavigatorService>().navigationKey,
        scaffoldMessengerKey:
            AppServices.instance<GlboalScaffoldMessengerState>().key,

        /// Translate
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        /// Theme
        theme: ThemeData(
          // Add the line below to get horizontal sliding transitions for routes.
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        title: 'Maan HRM',
        home: BlocListener<ConnectivityCubit, ConnectivityState>(
          listener: (context, state) {
            // print("listener ==============");
          },
          child: const Scaffold(body: SplashScreen()),
        ),
      ),
    );
    return MaterialApp(
      theme: ThemeData(
        // Add the line below to get horizontal sliding transitions for routes.
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      title: 'Maan HRM',
      home: const SplashScreen(),
    );
  }
}
