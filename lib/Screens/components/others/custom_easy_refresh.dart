import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class CustomEasyRefresh extends StatelessWidget {
  final EasyRefreshController? controller;
  final FutureOr Function()? onRefresh;
  final FutureOr Function()? onLoad;
  final Widget? child;
  const CustomEasyRefresh({
    super.key,
    this.controller,
    this.onRefresh,
    this.onLoad,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: controller,
      header: const ClassicHeader(
        showMessage: false,
      ),
      footer: const ClassicFooter(showMessage: false),
      onRefresh: onRefresh,
      onLoad: onLoad,
      child: child,
    );
  }
}
