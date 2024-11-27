import 'package:flutter/material.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

///**
/// use only in Product Order add.
/// cuz [rowData] specific header and body
/// */
class ProdcutTable extends StatelessWidget {
  final List<String> rowData;
  final TextStyle? textStyle;
  final Function()? onDelete;
  const ProdcutTable({
    super.key,
    required this.rowData,
    this.textStyle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return _row(context);
  }

  Widget _row(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            rowData[0],
            style:
                textStyle ?? Theme.of(context).textTheme.blackS13W700NoChange,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _text(context, rowData[1]),
        _text(context, rowData[2]),
        _text(context, rowData[3]),
        _text(context, rowData[4]),
        _delete(context),
      ],
    );
  }

  Widget _text(BuildContext context, String text, [int flex = 1]) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: textStyle ?? Theme.of(context).textTheme.blackS13W700NoChange,
        ),
      ),
    );
  }

  /// display when have onDelete
  Widget _delete(BuildContext context) {
    /// null not displaying
    if (onDelete == null) {
      return const SizedBox(
        height: 20,
        width: 40,
      );
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          CustomDialog.confirmRemove(
            context,
            onRemove: () async {
              Navigator.pop(context);

              /// Delay abit
              await Future.delayed(const Duration(milliseconds: 500));

              onDelete!.call();
            },
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _removeItem(context, "Product", rowData[0]),
                Measurement.gap.kHeight,
                _removeItem(context, "Qty", rowData[1]),
                Measurement.gap.kHeight,
                _removeItem(context, "Price", rowData[2]),
                Measurement.gap.kHeight,
                _removeItem(context, "Foc", rowData[3]),
                Measurement.gap.kHeight,
                _removeItem(context, "Discount", rowData[4]),
              ],
            ),
          );
        },
        child: SizedBox(
          width: 40,
          height: 30,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Icon(
              Icons.delete_outline,
              color: Colors.grey.shade500,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }

  Widget _removeItem(BuildContext context, String text1, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              text1,
              style: Theme.of(context).textTheme.blackS13W400,
            )),
        Expanded(
            child: Text(
          text2,
          style: Theme.of(context).textTheme.greyS13W400,
        )),
      ],
    );
  }
}
