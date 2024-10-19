// ignore_for_file: depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Screens/Employee%20Directory/bloc/employee_bloc.dart';
import 'package:hrm_employee/Screens/components/appbar/custom_appbar.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/Screens/components/ProfileImage/ui/profile_image.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';
import 'employee_directory_details.dart';

class EmployeeDirectory extends StatefulWidget {
  const EmployeeDirectory({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeDirectoryState createState() => _EmployeeDirectoryState();
}

class _EmployeeDirectoryState extends State<EmployeeDirectory> {
  late EmployeeBloc employeeBloc;
  Random random = Random();

  @override
  void initState() {
    employeeBloc = context.read<EmployeeBloc>();
    employeeBloc.add(EmployeeList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar:
          CustomAppBar.titleCompany(title: "Employee", onChanged: (v, _) {}),
      body: _blocBuilder(),
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
          'Employee Directory',
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Image(
            image: AssetImage('images/employeesearch.png'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border:
                          Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      onTap: () {
                        // const EmployeeDetails().launch(context);
                      },
                      leading: Image.asset('images/emp1.png'),
                      title: Text(
                        'Sahidul islam',
                        style: kTextStyle,
                      ),
                      subtitle: Text(
                        'Joining Date: 01, Jun 2021 ',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: kGreyTextColor,
                      ),
                    ),
                  ),
                  /*
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      onTap: () {
                        const EmployeeDetails().launch(context);
                      },
                      leading: Image.asset('images/emp2.png'),
                      title: Text(
                        'Mehedi Mohammad',
                        style: kTextStyle,
                      ),
                      subtitle: Text(
                        'Joining Date: 01, Jun 2021 ',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: kGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      onTap: () {
                        const EmployeeDetails().launch(context);
                      },
                      leading: Image.asset('images/emp3.png'),
                      title: Text(
                        'Ibne Riead',
                        style: kTextStyle,
                      ),
                      subtitle: Text(
                        'Joining Date: 01, Jun 2021 ',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: kGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      onTap: () {
                        const EmployeeDetails().launch(context);
                      },
                      leading: Image.asset('images/emp4.png'),
                      title: Text(
                        'Emily Jones',
                        style: kTextStyle,
                      ),
                      subtitle: Text(
                        'Joining Date: 01, Jun 2021 ',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: kGreyTextColor,
                      ),
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

  Widget _blocBuilder() {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      buildWhen: (previous, current) {
        if (current.stateType == EmployeeStateType.list) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return KBuilder(
            status: state.listResult!.status!,
            builder: (st) {
              return st == ApiStatus.loading
                  ? Container()
                  : _display(state.listResult!.data!.list!);
            });
      },
    );
  }

  Widget _display(List<UserModel> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: EdgeInsets.only(
                top: Measurement.screenPadding,

                /// bottom space last item
                bottom:
                    index != data.length - 1 ? 0 : Measurement.screenPadding),
            child: _employeeCard(data[index]),
          );
        });
  }

  Widget _employeeCard(UserModel data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
      ),
      child: ListTile(
        onTap: () {
          EmployeeDetails(
            employee: data,
          ).launch(context);
        },

        /// image
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: Color.fromARGB(
            255,
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: ProfileImage(
              image: data.image ?? "",
            ),
            // child: CircleAvatar(
            //   radius: 22,
            //   backgroundColor: AppColor.kWhiteColor,
            //   backgroundImage: MemoryImage(base64Decode(data.image ?? "")),
            // ),
          ),
        ),

        /// name
        title: Text(
          data.name ?? "",
          style: kTextStyle,
        ),

        /// department
        subtitle: Text(
          data.department ?? "",
          style: kTextStyle.copyWith(color: kGreyTextColor),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: kGreyTextColor,
        ),
      ),
    );
  }
}
