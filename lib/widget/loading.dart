import 'package:flutter/material.dart';

/// 圆形 Loading 框
class CircularLoading {
  // 调用者上下文
  final BuildContext _callerContext;

  CircularLoading(this._callerContext);

  /// 显示 Loading 框
  ///
  /// [buildContext] 上下文
  void show() {
    debugPrint("Show loading dialog");
    showDialog(
        // 弹框外去除背景色
        barrierColor: Colors.transparent,
        context: _callerContext,
        barrierDismissible: false,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return WillPopScope(
                // 禁止 back 按键
                onWillPop: () async => false,
                child: AlertDialog(
                  // 移除阴影
                  elevation: 0.0,
                  // 弹框去除背景色
                  backgroundColor: Colors.transparent,
                  content: UnconstrainedBox(
                    child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                        )),
                  ),
                ),
              );
            }));
  }

  /// 隐藏 Loading 框
  /// 该方法使用不当可能导致副作用，如路由返回丢失
  void dismiss() {
    // 这里如果加上 isActive/canPop 检验会导致部分情况下无法 pop
    Navigator.of(_callerContext).pop();
  }
}
