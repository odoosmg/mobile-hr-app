// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Screens/Authentication/profile_screen.dart';
import 'package:hrm_employee/Screens/Authentication/sign_in.dart';
import 'package:hrm_employee/Screens/Chat/chat_list.dart';
import 'package:hrm_employee/Screens/Notification/notification_screen.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:hrm_employee/constant.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel profile =
        AppServices.instance<DatabaseService>().getSession!.myProfile!;

    ///
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: context.height() / 3.6,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
              color: kMainColor,
            ),
            child: Column(
              children: [
                Container(
                  height: context.height() / 4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        CircleAvatar(
                          radius: 60.0,
                          backgroundColor: kMainColor,
                          backgroundImage:
                              MemoryImage(base64Decode(profile.image ?? "")),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${profile.name}',
                          style:
                              kTextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${profile.company}',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ],
                    ).onTap(() {
                      // const ProfileScreen().launch(context);
                    }),
                  ),
                ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                /*&
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            border: Border.all(color: Colors.white),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.6),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '22',
                                style: kTextStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'days',
                                style: kTextStyle.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Present',
                          style: kTextStyle.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            border: Border.all(color: Colors.white),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.6),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '3',
                                style: kTextStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'days',
                                style: kTextStyle.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Late',
                          style: kTextStyle.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            border: Border.all(color: Colors.white),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.6),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '5',
                                style: kTextStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'days',
                                style: kTextStyle.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Absent',
                          style: kTextStyle.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                */
              ],
            ),
          ),
          ListTile(
            onTap: () => const ProfileScreen().launch(context),
            title: Text(
              'Employee Profile',
              style: kTextStyle.copyWith(color: kTitleColor),
            ),
            leading: const Icon(
              FeatherIcons.user,
              color: kMainColor,
            ),
          ),
          ListTile(
            onTap: () => const ChatScreen().launch(context),
            title: Text(
              'Live Video Calling & Charting',
              style: kTextStyle.copyWith(color: kTitleColor),
            ),
            leading: const Icon(
              FeatherIcons.video,
              color: kMainColor,
            ),
          ),
          ListTile(
            onTap: () => const NotificationScreen().launch(context),
            title: Text(
              'Notification',
              style: kTextStyle.copyWith(color: kTitleColor),
            ),
            leading: const Icon(
              FeatherIcons.bell,
              color: kMainColor,
            ),
          ),
          ListTile(
            title: Text(
              'Terms & Conditions',
              style: kTextStyle.copyWith(color: kTitleColor),
            ),
            leading: const Icon(
              Icons.info_outline,
              color: kMainColor,
            ),
          ),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: kTextStyle.copyWith(color: kTitleColor),
            ),
            leading: const Icon(
              FeatherIcons.alertTriangle,
              color: kMainColor,
            ),
          ),
          ListTile(
            onTap: () => _confirmLogout(context),
            title: Text(
              'Logout',
              style: kTextStyle.copyWith(color: kTitleColor),
            ),
            leading: const Icon(
              FeatherIcons.logOut,
              color: kMainColor,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    CustomDialog.dialog(context,
        title: Text(
          "Logout",
          style: Theme.of(context).textTheme.blackS14W700,
        ),
        content: Text(
          "Are you sure to logout?",
          style: Theme.of(context).textTheme.blackS13W400,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel'.toUpperCase(),
              style: Theme.of(context).textTheme.greyS14W400,
            ),
          ),
          TextButton(
            onPressed: () {
              /// clear
              AppServices.instance<DatabaseService>().clearSession();
              const SignIn().launch(context, isNewTask: true);
            },
            child: Text(
              'Logout'.toUpperCase(),
              style: Theme.of(context).textTheme.mainS15W500,
            ),
          ),
        ]);
  }
}
