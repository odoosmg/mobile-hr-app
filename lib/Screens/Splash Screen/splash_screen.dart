// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_employee/GlobalComponents/others/loading_inidicator.dart';
import 'package:hrm_employee/Models/auth/app_local.dart';
import 'package:hrm_employee/Screens/Authentication/sign_in.dart';
import 'package:hrm_employee/Screens/Home/home_screen.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/button_global.dart';
import '../../GlobalComponents/purchase_model.dart';
import '../../constant.dart';
import 'on_board.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

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

    // bool isValid = await PurchaseModel().isActiveBuyer();
    // if(isValid){
    //   finish(context);
    //   const OnBoard().launch(context, isNewTask: true);
    // } else{
    //   showLicense(context: context);
    // }
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

            Text(
              "Soma Group",
              style: Theme.of(context).textTheme.whiteS20W700NoChange,
            ),
            10.height,
            const CustomCircularProgressindicator(),

            // const Image(
            //   image: AssetImage('images/round_logo.png'),
            // ),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Version 1.0.0',
                  style: GoogleFonts.manrope(
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
