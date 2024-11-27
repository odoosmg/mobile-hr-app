import 'package:flutter/material.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';

class TypeAheadItem extends StatelessWidget {
  final String name;
  const TypeAheadItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // width: double.infinity,
      // height: 50,
      // padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade500,
            height: 1,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Text(
              name,
              style: Theme.of(context).textTheme.blackS13W400,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
