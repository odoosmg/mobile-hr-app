// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_loading.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Screens/Authentication/bloc/auth_bloc.dart';
import 'package:hrm_employee/Screens/Authentication/sign_up.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../GlobalComponents/button_global.dart';
import '../../GlobalComponents/purchase_model.dart';
import '../../constant.dart';
import '../Home/home_screen.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController usernameTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previousState, currentState) {
        ApiResult<Session> response = currentState.signin!;
        if (response.status == ApiStatus.loading) {
          /// show loading
          CustomLoading.show(context);
        } else {
          /// hide loading
          CustomLoading.hide(context);

          if (currentState.signin!.isSuccess) {
            /// Success
            const HomeScreen().launch(context, isNewTask: true);
          } else {
            /// Failed
            CustomDialog.error(context,
                errCode: response.statuscode, errMsg: response.errorMessage);
          }
        }

        /// No need to build.
        return false;
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kMainColor,
          appBar: AppBar(
            backgroundColor: kMainColor,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Sign In',
              style: kTextStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sign In now to begin an amazing journey',
                  style: kTextStyle.copyWith(color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 60.0,
                        child: AppTextField(
                          textFieldType: TextFieldType.NAME,
                          controller: usernameTEC,
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Usersname',
                            hintText: 'Enter username',
                            labelStyle: kTextStyle,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: const OutlineInputBorder(),
                            // prefixIcon: CountryCodePicker(
                            //   padding: EdgeInsets.zero,
                            //   onChanged: print,
                            //   initialSelection: 'BD',
                            //   showFlag: false,
                            //   showDropDownButton: true,
                            //   alignLeft: false,
                            // ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      AppTextField(
                        controller: passwordTEC,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: kTextStyle,
                          hintText: 'Enter password',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              value: isChecked,
                              activeColor: kMainColor,
                              thumbColor: kGreyTextColor,
                              onChanged: (bool value) {
                                setState(() {
                                  isChecked = value;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Save Me',
                            style: kTextStyle,
                          ),
                          const Spacer(),
                          Text(
                            'Forgot Password?',
                            style: kTextStyle,
                          ).onTap(() {
                            const ForgotPassword().launch(context);
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ButtonGlobal(
                        buttontext: 'Sign In',
                        buttonDecoration:
                            kButtonDecoration.copyWith(color: kMainColor),
                        onPressed: () async {
                          context.read<AuthBloc>().add(AuthSignIn(
                                username: usernameTEC.text,
                                password: passwordTEC.text,
                              ));

                          return;

                          ///
                          bool isValid = await PurchaseModel().isActiveBuyer();
                          if (isValid) {
                            HomeScreen().launch(context);
                          } else {
                            showLicense(context: context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: kTextStyle.copyWith(
                                color: kGreyTextColor,
                              ),
                            ),
                            WidgetSpan(
                              child: Text(
                                'Sign Up',
                                style: kTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kMainColor,
                                ),
                              ).onTap(() {
                                const SignUp().launch(context);
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
