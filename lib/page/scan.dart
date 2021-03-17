import 'package:flutter/material.dart';
import 'package:scan/scan.dart';

import '../l10n/l10n.dart';

// 页面名称
const SCAN_PAGE_NAME = "/scan";

/// 二维码扫描页面
class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  ScanController _scanController = ScanController();

  @override
  Widget build(BuildContext context) {
    debugPrint("Build scan");
    return Scaffold(
      appBar: _getAppBar(context),
      // WillPopScope 用于拦截返回键停止摄像头
      body: WillPopScope(
        child: Container(
          color: Colors.black,
          child: ScanView(
            controller: _scanController,
            scanAreaScale: .7,
            scanLineColor: Theme.of(context).primaryColor,
            onCapture: (data) {
              debugPrint("Scan data: $data");
              _scanController.pause();
              Navigator.of(context).pop(data);
            },
          ),
        ),
        onWillPop: () async {
          debugPrint("Pop scan");
          _scanController.pause();
          return true;
        },
      ),
    );
  }

  /// 获取 AppBar
  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(FrLocalizations.of(context).scanAppBarTitle),
    );
  }
}
