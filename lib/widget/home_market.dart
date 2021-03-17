import 'package:flutter/material.dart';

import '../page/product.dart';
import '../l10n/l10n.dart';
import '../page/scan.dart';
import '../util/common.dart';

/// 首页商场
class HomeMarket extends StatefulWidget {
  @override
  _HomeMarketState createState() => _HomeMarketState();
}

class _HomeMarketState extends State<HomeMarket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(context),
        body: Center(
            child: OutlineButton(
          child: Text("Click Me"),
          onPressed: () => (Navigator.of(context)
              .pushNamed(PRODUCT_PAGE_NAME, arguments: ProductPageArg(1, 1))),
        )));
  }

  /// 获取 AppBar
  ///
  /// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
  ///
  /// return AppBar
  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(FrLocalizations.of(context).homeMarketBottomBarText),
      actions: [
        IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () => _scanButtonOnPressed(context))
      ],
    );
  }

  /// 扫描二维码按钮响应
  ///
  /// param [context] BuildContext 对象，必须为 Scaffold 子组件的 BuildContext
  void _scanButtonOnPressed(BuildContext context) async {
    var content = await Navigator.of(context).pushNamed(SCAN_PAGE_NAME);
    if (content is String) {
      snackBar(context, content);
      return;
    } else {
      snackBar(context, FrLocalizations.of(context).homeScanQrCodeFailed);
      return;
    }
  }
}
