// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Screens/Authentication/bloc/auth_bloc.dart';
import 'package:hrm_employee/Screens/components/ProfileImage/ui/profile_image.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/body_card.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();

    authBloc.add(AuthMyProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.titleActions(
        title: "Profile",
        // actions: [
        //   const Image(
        //     image: AssetImage('images/editprofile.png'),
        //   ).onTap(() {
        //     const EditProfile().launch(context);
        //   }),
        // ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) =>
            current.authStateType == AuthStateType.myProfile,
        builder: (context, state) {
          return KBuilder(
            status: state.myProfileResult!.status!,
            builder: (st) {
              return st == ApiStatus.loading
                  ? Container()
                  : _display(state.myProfileResult?.data ?? UserModel());
            },
          );
        },
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          const Image(
            image: AssetImage('images/editprofile.png'),
          ).onTap(() {
            const EditProfile().launch(context);
          }),
        ],
      ),
      body: BodyCard(
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) =>
              current.authStateType == AuthStateType.myProfile,
          builder: (context, state) {
            return KBuilder(
              status: state.myProfileResult!.status!,
              builder: (st) {
                return st == ApiStatus.loading
                    ? Container()
                    : _display(state.myProfileResult?.data ?? UserModel());
              },
            );
          },
        ),
      ),
      /*
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: context.width(),
              height: Measurement.heightPercent(context, 0.85),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),

              /// ** Bloc
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) =>
                    current.authStateType == AuthStateType.myProfile,
                builder: (context, state) {
                  return KBuilder(
                    status: state.myProfileResult!.status!,
                    builder: (st) {
                      return st == ApiStatus.loading
                          ? Container()
                          : _display(
                              state.myProfileResult?.data ?? UserModel());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      */
    );
  }

  Widget _display(UserModel data) {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),

        /// image

        ProfileImage(
          backgroundColor: AppColor.kMainColor.withOpacity(0.5),
          radius: 60,
          image: data.image ?? "",
        ),
        const SizedBox(
          height: 10.0,
        ),

        /// Name
        _field(AppTrans.t.name, data.name ?? ""),

        /// Email
        _field(AppTrans.t.email, data.email ?? ""),

        /// Manager
        _field(AppTrans.t.manager, data.manager ?? ""),

        /// Department
        _field(AppTrans.t.department, data.department ?? ""),

        /// Company
        _field(AppTrans.t.company, data.companyStr ?? ""),

        /*
                  AppTextField(
                    readOnly: true,
                    textFieldType: TextFieldType.NAME,
                    decoration: const InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'MaanTheme',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    readOnly: true,
                    textFieldType: TextFieldType.NAME,
                    decoration: const InputDecoration(
                      labelText: 'Owner/Admin name',
                      hintText: 'MaanTeam',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    readOnly: true,
                    textFieldType: TextFieldType.EMAIL,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'maantheme@maantheme.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    controller: TextEditingController(),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '+8801767 432556',
                      labelStyle: kTextStyle,
                      border: const OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    readOnly: true,
                    textFieldType: TextFieldType.NAME,
                    decoration: const InputDecoration(
                      labelText: 'Company Address',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: '112/3 Green Road',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Male',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  */
      ],
    );
  }

  Widget _field(String labelText, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: AppTextField(
        textFieldType: TextFieldType.PHONE,
        readOnly: true,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText.isEmpty ? "N/A" : hintText,
          labelStyle: kTextStyle,
          border: const OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
