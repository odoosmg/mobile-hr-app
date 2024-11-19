// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_employee/GlobalComponents/bloc/form-data/form_data_bloc.dart';
import 'package:hrm_employee/Screens/Authentication/sign_in.dart';
import 'package:hrm_employee/Screens/Home/home_screen.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';
import 'on_board.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double logoSize = 0.1;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    /// call only login
    if (AppServices.instance<DatabaseService>().getToken.isNotEmpty) {
      /// temp solution.
      /// put here to fixed company loading status.
      /// but rebuild 2 times.
      context.read<FormDataBloc>().add(FormDataCompanyList(false));
    }

    /// Animation
    Future.delayed(const Duration(milliseconds: 50)).then((_) {
      setState(() {
        logoSize = 1;
      });
    });

    await Future.delayed(const Duration(milliseconds: 2400));

    defaultBlurRadius = 10.0;
    defaultSpreadRadius = 0.5;
    if (AppServices.instance<DatabaseService>().getToken.isNotEmpty) {
      /// has token, goto home
      const HomeScreen().launch(context, isNewTask: true);
    } else {
      /// if already close Onboard direct to Sign-in
      if (AppServices.instance<DatabaseService>()
          .getAppLocal!
          .isOnboardClose!) {
        const SignIn().launch(context, isNewTask: true);
      } else {
        const OnBoard().launch(context, isNewTask: true);
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
            ),

            // Text(
            //   "Soma Group",
            //   style: Theme.of(context).textTheme.whiteS20W700NoChange,
            // ),

            AnimatedScale(
              scale: logoSize,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              child: const Image(
                image: AssetImage('images/app_logo_primary.png'),
                // width: logoSize,
              ),
            ),
            // 10.kHeight,
            // const CustomCircularProgressindicator(),

            // const Image(
            //   image: AssetImage('images/round_logo.png'),
            // ),
            const Spacer(),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
