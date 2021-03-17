import 'package:fitting_room/l10n/l10n.dart';
import 'package:flutter/material.dart';

// 页面名称
const ERROR_PAGE_NAME = "/error";

class ErrorPage extends StatelessWidget {
  ErrorPage(String name, Object args) {
    debugPrint("Error page name: $name, args: ${args.toString}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(FrLocalizations.of(context).title),
      ),
      body: Center(
          child: Text(
        "oops! 404!",
        textScaleFactor: 2,
        style: TextStyle(color: Theme.of(context).primaryColor),
      )),
    );
  }
}
