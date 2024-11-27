import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final TextStyle? titleTextStyle;
  final bool isRequired;
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final int maxLines;
  final bool readOnly;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final int maxLength;
  final Color? borderColor;
  final Color? fillColor;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final TextAlign textAlign;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField({
    super.key,
    this.title,
    this.titleTextStyle,
    this.isRequired = false,
    this.controller,
    this.hintText,
    this.focusNode,
    this.obscureText = false,
    this.fillColor,
    this.onChanged,
    this.textAlign = TextAlign.left,
    this.maxLength = 100,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.inputFormatters,
    this.suffixIcon,
    this.readOnly = false,
    this.borderColor,
    this.suffixIconConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: Measurement.gap),
            child: Row(children: [
              Text(
                title!,
                style:
                    titleTextStyle ?? Theme.of(context).textTheme.blackS15W700,
              ),
              if (isRequired)
                Text(
                  '\t*',
                  style: TextStyle(color: Colors.red.shade900, fontSize: 16),
                )
            ]),
          ),
        _field(context)
      ],
    );
  }

  TextFormField _field(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      focusNode: focusNode,
      autofocus: autofocus,
      maxLength: maxLength,
      readOnly: readOnly,
      controller: controller,
      style: Theme.of(context).textTheme.blackS15W700NoChange,
      onChanged: onChanged,
      obscureText: obscureText,
      obscuringCharacter: "*",
      decoration: InputDecoration(
          fillColor: fillColor ?? Colors.grey.shade300,
          filled: true,
          counterText: "",
          contentPadding: const EdgeInsets.all(10),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(Measurement.cardRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Measurement.cardRadius),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade500,
            ),
          ),

          /// SuffixIcon
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.hintText),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters ?? [],
      maxLines: maxLines,
    );
  }
}
