// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/bloc/form-data/form_data_bloc.dart';

import 'package:hrm_employee/GlobalComponents/button/main_btn.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_loading.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/Screens/Authentication/bloc/auth_bloc.dart';

import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';
import '../Home/home_screen.dart';

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

  /// local bloc
  late AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
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
                      onChanged: (text) {
                        _validate();
                      },
                      enabled: true,
                      decoration: const InputDecoration(
                        labelText: 'Usersname',
                        hintText: 'Enter username',
                        labelStyle: kTextStyle,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(),
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
                    onChanged: (text) {
                      _validate();
                    },
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: kTextStyle,
                      hintText: 'Enter password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  /*
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
*/
                  /// ** Bloc
                  BlocBuilder<AuthBloc, AuthState>(
                    bloc: authBloc,
                    buildWhen: (previous, current) {
                      ApiResult<Session> response = current.signin!;

                      /// validate, this should rebuild
                      if (current.authStateType == AuthStateType.validate) {
                        if (current.isValidForm || !current.isValidForm) {
                          return true;
                        }
                      }

                      /// SigIn is not rebuild
                      if (current.authStateType == AuthStateType.signin) {
                        if (response.status == ApiStatus.loading) {
                          /// show loading
                          CustomLoading.show(context);
                        } else {
                          /// hide loading
                          CustomLoading.hide(context);

                          if (current.signin!.isSuccess) {
                            ///
                            _initCompany();

                            /// Success
                            const HomeScreen().launch(context, isNewTask: true);
                          } else {
                            /// Failed
                            CustomDialog.error(context,
                                errCode: response.statuscode,
                                errMsg: response.errorMessage);
                          }
                        }
                      }

                      /// No need to build.
                      return false;
                    },
                    builder: (context, state) {
                      return MainBtn(
                          title: "Sign In",
                          isOk: state.isValidForm,
                          onPressed: () {
                            /// close keyboard
                            FocusManager.instance.primaryFocus!.unfocus();

                            ///
                            authBloc.add(
                              AuthSignIn(
                                username: usernameTEC.text,
                                password: passwordTEC.text,
                              ),
                            );
                          });
                    },
                  ),
                  // ButtonGlobal(
                  //   buttontext: 'Sign In',
                  //   buttonDecoration:
                  //       kButtonDecoration.copyWith(color: kMainColor),
                  //   onPressed: true
                  //       ? null
                  //       : () async {
                  //           ///
                  //           authBloc.add(AuthSignIn(
                  //                 username: usernameTEC.text,
                  //                 password: passwordTEC.text,
                  //               ));

                  //           return;

                  //           ///
                  //           bool isValid =
                  //               await PurchaseModel().isActiveBuyer();
                  //           if (isValid) {
                  //             HomeScreen().launch(context);
                  //           } else {
                  //             showLicense(context: context);
                  //           }
                  //         },
                  // ),
/*
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
*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///***************************************************
  ///
  ///***************************************************/

  void _validate() {
    authBloc.add(AuthValidate(
      username: usernameTEC.text,
      password: passwordTEC.text,
    ));
  }

  ///
  void _initCompany() {
    /// Fixed null
    final formDataBox = AppServices.instance<DatabaseService>().getFormData ??
        SelectFormModel();
    formDataBox.companyList = [];
    formDataBox.companySelected = [];
    AppServices.instance<DatabaseService>().putFormData(formDataBox);

    /// fixed always loading after login.
    /// first init, status is loading.
    context.read<FormDataBloc>().add(FormDataCompanyList(false));
  }

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    usernameTEC.dispose();
    passwordTEC.dispose();

    /// updae state.isValidForm = false
    authBloc.add(
      AuthValidate(
        username: "",
        password: "",
      ),
    );
    super.dispose();
  }
}
