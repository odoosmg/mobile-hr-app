import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hrm_employee/GlobalComponents/others/loading_inidicator.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class CustomTypeAhead<T> extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool isRequired;
  final Widget Function(BuildContext, T) itemBuilder;
  final FutureOr<List<T>?> Function(String) suggestionsCallback;
  final Function(T) onSelected;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Function()? onClear;
  const CustomTypeAhead(
      {super.key,
      required this.title,
      this.titleStyle,
      this.isRequired = false,
      required this.itemBuilder,
      required this.suggestionsCallback,
      required this.onSelected,
      this.onChanged,
      this.controller,
      this.onClear});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      itemBuilder: itemBuilder,
      controller: controller,

      /// Loading
      loadingBuilder: (context) {
        return Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(5),
            height: 50,
            child: const CustomCircularProgressindicator());
      },

      /// Empty
      emptyBuilder: (a) {
        return Container(
            height: 40,
            padding:
                const EdgeInsets.only(left: Measurement.screenPadding, top: 4),
            child: Text(
              AppTrans.t.empty,
              style: Theme.of(context).textTheme.greyS14W400,
            ));
      },
      builder: (context, contr, focusNode) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.greyS15W400,
                ),
                if (isRequired)
                  Text(
                    '\t*',
                    style: TextStyle(color: Colors.red.shade900, fontSize: 16),
                  )
              ],
            ),
            Measurement.gap.kPdTop,

            /// FIELD
            TextField(
              style: Theme.of(context).textTheme.blackS15W700NoChange,
              controller: contr,
              onChanged: onChanged,
              focusNode: focusNode,
              decoration: InputDecoration(
                // hintText: "select",
                fillColor: Colors.grey.shade300,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
                isDense: true,
                border: InputBorder.none,

                ///
                suffixIcon:
                    onClear == null ? _arrowDown() : _arrowDownAndClear(),

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: Colors.transparent,
                  ),
                  borderRadius:
                      BorderRadius.circular(Measurement.cardBorderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Measurement.cardBorderRadius),
                  borderSide: BorderSide(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ],
        );
      },

      ///
      onSelected: onSelected,
      suggestionsCallback: suggestionsCallback,
    );
  }

  Widget _arrowDownAndClear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
      mainAxisSize: MainAxisSize.min, // added line
      children: [
        _arrowDown(),
        GestureDetector(
          onTap: onClear,
          child: Container(
            width: 30,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 2),
            height: 30,
            child: const Icon(
              Icons.clear,
              color: AppColor.kBlackColor,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _arrowDown() {
    return const Icon(
      Icons.keyboard_arrow_down,
      color: AppColor.kBlackColor,
      size: 26,
    );
  }
}
