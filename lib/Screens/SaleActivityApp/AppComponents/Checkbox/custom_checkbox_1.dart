import 'package:flutter/material.dart';
import 'package:hrm_employee/utlis/app_color.dart';

class CustomCheckbox1 extends StatefulWidget {
  final Widget child;
  final Function(bool) onChanged;
  final Color? activeColor;
  final bool? initValue;
  const CustomCheckbox1(
      {super.key,
      required this.onChanged,
      required this.child,
      this.activeColor,
      this.initValue});

  @override
  State<CustomCheckbox1> createState() => _CustomCheckbox1State();
}

class _CustomCheckbox1State extends State<CustomCheckbox1> {
  bool isChecked = false;

  @override
  void initState() {
    if (widget.initValue != null) {
      isChecked = widget.initValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _checkbox(isChecked);
  }

  Widget _checkbox(bool checked) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!checked);
        setState(() {
          isChecked = !checked;
        });
      },
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            activeColor: widget.activeColor ?? AppColor.saMain,
            value: checked,
            onChanged: (v) {
              widget.onChanged(!checked);
              setState(() {
                isChecked = !checked;
              });
            },
          ),
          widget.child,
        ],
      ),
    );
  }
}
