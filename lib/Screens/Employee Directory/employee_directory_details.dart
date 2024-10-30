// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Screens/Employee%20Directory/bloc/employee_bloc.dart';
import 'package:hrm_employee/Screens/components/kbuilder/k_builder.dart';
import 'package:hrm_employee/Screens/components/others/custom_scaffold.dart';
import 'package:hrm_employee/Screens/components/ProfileImage/ui/profile_image.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class EmployeeDetails extends StatefulWidget {
  final UserModel employee;
  const EmployeeDetails({super.key, required this.employee});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  late EmployeeBloc employeeBloc;
  late UserModel argData;

  @override
  void initState() {
    argData = widget.employee;
    employeeBloc = context.read<EmployeeBloc>();
    employeeBloc.add(EmployeeDetail(argData.id ?? 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ProfileImage(image: argData.image ?? ""),
          title: Text(
            argData.name ?? "",
            style: kTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: argData.department!.isEmpty
              ? null
              : Text(
                  argData.department!,
                  style:
                      kTextStyle.copyWith(color: Colors.white.withOpacity(0.5)),
                ),
          // trailing: const Icon(
          //   Icons.close,
          //   color: Colors.white,
          // ),
        ),
      ),
      body: _blocBuilder(),
    );
  }

  Widget _display(UserModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Personal Information',
                style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(
                height: 30.0,
              ),

              /// Email
              _appTextField(
                title: 'Email Address',
                value: data.email ?? "",
                showCursor: true,
              ),
              const SizedBox(
                height: 20.0,
              ),

              /// Phone
              _appTextField(
                title: 'Phone',
                value: data.phone ?? "",
              ),
              const SizedBox(
                height: 20.0,
              ),

              /// Position
              _appTextField(
                title: 'Position',
                value: data.position ?? "",
              ),
              const SizedBox(
                height: 20.0,
              ),

              /// Department
              _appTextField(
                title: 'Department',
                value: data.department ?? "",
              ),
              const SizedBox(
                height: 20.0,
              ),

              /// Company
              _appTextField(title: 'Company', value: data.company?.name ?? ""),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _blocBuilder() {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      buildWhen: (previous, current) {
        if (current.stateType == EmployeeStateType.detail) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return KBuilder(
            status: state.detailResult!.status!,
            builder: (st) {
              return st == ApiStatus.loading
                  ? Container()
                  : _display(state.detailResult!.data!);
            });
      },
    );
  }

  AppTextField _appTextField({
    required String title,
    required String value,
    bool showCursor = false, // enable scroll text when long text
  }) {
    return AppTextField(
      textFieldType: TextFieldType.NAME,
      readOnly: true,
      showCursor: showCursor,
      controller: TextEditingController(text: value.isEmpty ? "N/A" : value),
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
