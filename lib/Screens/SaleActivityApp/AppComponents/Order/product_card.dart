// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/SaleActivity/Order/product_model.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Customer/select_product.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Fields/customer_textfield.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Order/order_product_total_price_card.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Order/product_btn_add.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Order/product_table.dart';
import 'package:hrm_employee/Screens/SaleActivityApp/AppComponents/Others/cus_card.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/navigation_service.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';
import 'package:hrm_employee/utlis/app_trans.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';

class ProductCard extends StatefulWidget {
  final List<ProductModel>? initData;
  final double? initGlobalDiscount;

  final Function(double, double) onGlobalDiscount;

  /// call when on Add and Remove item
  final Function(ProductModel) onAction;
  const ProductCard({
    super.key,
    required this.onAction,
    this.initData,
    this.initGlobalDiscount,
    required this.onGlobalDiscount,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  BtnStatus isBtnAddProductOk = BtnStatus.disabled;

  late TextStyle fieldTitleStyle;

  Timer? _debounceTimer;

  List<ProductModel> productItemList = <ProductModel>[];

  /// Product
  final TextEditingController productNameTEC = TextEditingController();
  final TextEditingController productQtyTEC = TextEditingController();
  final TextEditingController productFOCTEC = TextEditingController();
  final TextEditingController productDiscountTEC = TextEditingController();
  final TextEditingController productPriceTEC = TextEditingController();

  /// Trigger Obx proudct item table
  bool triggerProductField = false;

  /// use 'key' to clearn product key
  bool clearProductField = false;

  double pricePerUnit = 0;

  ProductModel selectedProduct = ProductModel();

  double subTotal = 0.0, total = 0.0, globalDiscount = 0.0;

  @override
  void initState() {
    fieldTitleStyle = fieldTitleStyle =
        Theme.of(AppServices.instance<NavigatorService>().getCurrentContext)
            .textTheme
            .greyS15W400;
    productItemList = widget.initData ?? [];
    globalDiscount = widget.initGlobalDiscount ?? 0.0;

    if (widget.initData != null) {
      _calculateFinalPrice();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Measurement.screenPadding.kHeight,
        _proQtyFoc(),
        Measurement.screenPadding.kHeight,
        _discPriceBtnadd(),
        Measurement.screenPadding.kHeight,
        _productTable(),
        Measurement.screenPadding.kHeight,

        ///
        OrderProductTotalPriceCard(
          subTotal: subTotal,
          discount: globalDiscount,
          total: total,
          onDiscount: (d) {
            globalDiscount = (d);

            _calculateFinalPrice();
            widget.onGlobalDiscount.call(d, total);
          },
        ),
      ],
    );
  }

  /// Product, Qty , FOC
  Widget _proQtyFoc() {
    return Row(
      children: <Widget>[
        _productReactiveWidget(),

        /// Select Product
        SizedBox(
          width: Measurement.widthPercent(context, 0.5),
          child: SelectProduct(
            key: Key(clearProductField.toString()),
            onSelected: (product) {
              selectedProduct = product;

              /// default 1
              productQtyTEC.text = "1";
              productPriceTEC.text = product.salePrice.toString();
              pricePerUnit = product.salePrice ?? 0;
              productNameTEC.text = product.name ?? "";
              productFOCTEC.clear();
              productDiscountTEC.clear();
              _triggerProduct();
              isBtnAddProductOk = (BtnStatus.ok);
            },
          ),
        ),
        16.kWidth,

        /// Product qty
        Flexible(
          child: CustomTextField(
            title: 'Qty',
            controller: productQtyTEC,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            titleTextStyle: fieldTitleStyle,
            // onChanged: (text) {
            //   _finishedTyping(1500, () {
            //     /// minum is 1
            //     if (text.isEmpty || int.parse(text) < 1) {
            //       productQtyTEC.text = "1";
            //     }
            //     productPriceTEC.text = _calculateItemPrice().toString();
            //     _triggerProduct();
            //   });
            // },
          ),
        ),
        16.kWidth,

        /// Product FOC
        Flexible(
          child: CustomTextField(
            title: 'FOC',
            titleTextStyle: fieldTitleStyle,
            controller: productFOCTEC,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
      ],
    );
  }

  /// Discount, Price, Btn add
  Widget _discPriceBtnadd() {
    return Row(
      children: <Widget>[
        _productReactiveWidget(),

        /// Discount
        SizedBox(
          width: Measurement.widthPercent(context, 0.5),
          child: CustomTextField(
            title: AppTrans.t.discount,
            titleTextStyle: fieldTitleStyle,
            controller: productDiscountTEC,
            keyboardType: TextInputType.number,
            hintText: "0",
            suffixIcon: const Icon(
              Icons.percent,
              color: AppColor.kBlackColor,
            ),
            onChanged: (text) {
              ///
              // _finishedTyping(500, () {
              //   productDiscountTEC.text = text;
              //   productPriceTEC.text = _calculateItemPrice().toString();
              //   _triggerProduct();
              // });
            },
          ),
        ),
        16.kWidth,

        /// price
        Flexible(
          child: CustomTextField(
            controller: productPriceTEC,
            title: AppTrans.t.price,
            titleTextStyle: fieldTitleStyle,
            keyboardType: TextInputType.number,
            onChanged: (text) {
              // productDiscountTEC.clear();
              _validate();
            },
          ),
        ),
        16.kWidth,
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ProductBtnAdd(
              status: isBtnAddProductOk,
              onpressed: _addProductItem,
            ),
          ),
        ),
      ],
    );
  }

  Widget _productTable() {
    return CusCard(
      background: Colors.white,
      child: Column(
        children: [
          /// Header
          const ProdcutTable(
            rowData: ["Pro", "Qty", "Pri", "FOC", "Dis"],
          ),

          for (int i = 0; i < productItemList.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: Measurement.screenPadding),
              child: ProdcutTable(
                  textStyle: Theme.of(context).textTheme.greyS14W400,
                  onDelete: () {
                    _unfocus();
                    productItemList.removeAt(i);

                    _calculateFinalPrice();

                    _callback();

                    // productItemList.refresh();
                  },
                  rowData: [
                    productItemList[i].name!,
                    productItemList[i].qty.toString(),
                    productItemList[i].salePrice.toString(),
                    productItemList[i].foc.toString(),
                    '${productItemList[i].discount}%'
                  ]),
            ),

          Measurement.screenPadding.kHeight,
        ],
      ),
    );
  }

  /// for reactive
  Text _productReactiveWidget() {
    return Text(
      triggerProductField.toString(),
      style: const TextStyle(fontSize: 0),
    );
  }

  ///******************************************************
  ///
  ///*******************************************************/

  void _triggerProduct() {
    triggerProductField = (!triggerProductField);
  }

  /// if null, return 0
  double _checkStrDouble(String? number, [double whenEmpty = 0.0]) {
    if (number == null || number.isEmpty) {
      return whenEmpty;
    }
    return double.parse(number);
  }

  /// Calculate item discount
  double _calculateItemPrice() {
    double disc = _checkStrDouble(productDiscountTEC.text);
    int qty = int.parse(productQtyTEC.text);

    /// minimum only 1
    if (qty < 1) {
      qty = 1;
    }

    return Measurement.discount(pricePerUnit * qty, disc);
  }

  _finishedTyping(int milliseconds, Function callback) {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(Duration(milliseconds: milliseconds), () {
      // Call your callback function here
      callback.call();
    });
  }

  int _checkStrInt(String? number, [int whenEmpty = 0]) {
    if (number == null || number.isEmpty) {
      return whenEmpty;
    }
    return int.parse(number);
  }

  void _unfocus() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  void _addProductItem() {
    ProductModel d = ProductModel();

    d.name = productNameTEC.text;
    d.salePrice = _checkStrDouble(productPriceTEC.text);
    d.qty = _checkStrInt(productQtyTEC.text, 1);
    d.productUomQty = d.qty;
    d.foc = _checkStrInt(productFOCTEC.text);
    d.discount = _checkStrDouble(productDiscountTEC.text);
    d.productUom = selectedProduct.productUom;
    d.productUomId = selectedProduct.productUomId;

    d.pricePerUnit = _checkStrDouble(productPriceTEC.text);
    d.id = selectedProduct.id;

    /// add to list
    productItemList.add(d);
    // productItemList.refresh();

    _calculateFinalPrice();

    _callback();

    _unfocus();

    /// clear SelectProduct field.
    clearProductField = !clearProductField;

    /// Clear
    pricePerUnit = 0;
    productQtyTEC.clear();
    productFOCTEC.clear();
    productDiscountTEC.clear();
    productPriceTEC.clear();
    selectedProduct = ProductModel();

    /// Trigger obx
    _triggerProduct();

    /// disable btn
    isBtnAddProductOk = (BtnStatus.disabled);
  }

  /// Sub Total, Total
  void _calculateFinalPrice() {
    double tt = 0;
    for (int i = 0; i < productItemList.length; i++) {
      tt += productItemList[i].getItemPrice2;
    }

    /// Subtotal
    subTotal = tt;

    /// total
    total = Measurement.discount(subTotal, globalDiscount);
  }

  void _callback() {
    ProductModel d = ProductModel();
    d.orderLines = productItemList;
    d.subTotal = subTotal;
    d.globalDiscount = globalDiscount;
    d.total = total;

    widget.onAction.call(d);
  }

  void _validate() {
    if (productNameTEC.text.isEmpty || productPriceTEC.text.isEmpty) {
      isBtnAddProductOk = (BtnStatus.disabled);
    } else {
      isBtnAddProductOk = (BtnStatus.ok);
    }
  }

  @override
  void dispose() {
    productNameTEC.dispose();
    productQtyTEC.dispose();
    productFOCTEC.dispose();
    productDiscountTEC.dispose();
    productPriceTEC.dispose();

    super.dispose();
  }
}
