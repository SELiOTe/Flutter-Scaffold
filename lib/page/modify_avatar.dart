import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../model/provider/global_model.dart';
import '../util/common.dart';
import '../util/io.dart';

// 页面名称
const MODIFY_AVATAR_PAGE_NAME = "/home/modify_info/modify_avatar";

class ModifyAvatarPage extends StatefulWidget {
  @override
  _ModifyAvatarPageState createState() => _ModifyAvatarPageState();
}

class _ModifyAvatarPageState extends State<ModifyAvatarPage> {
  final _imagePicker = ImagePicker();
  // 头像 SHA1
  String _img;

  @override
  void initState() {
    super.initState();
    _img = Provider.of<GlobalModel>(context, listen: false).avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(FrLocalizations.of(context).modifyAvatarAppBarTitle),
        ),
        body: Container(color: Colors.black, child: _getCotentWidget()));
  }

  /// 获取内容组件
  ///
  /// return 内容组件
  Widget _getCotentWidget() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: Center(
        child: getCachedNetworkImage(
          _img,
          // 正方形头像，宽度充满应用
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      )),
      Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: TextButton(
              child: Text(FrLocalizations.of(context).modifyAvatarModifyButton,
                  style: TextStyle(color: Colors.grey)),
              onPressed: () async => _modifyOnPressed())),
    ]);
  }

  /// 修改按钮响应
  /// 选择图片并完成裁剪后会自动 POP 该页，未更换成功不会 POP
  void _modifyOnPressed() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      debugPrint("Pick avatar finish");
      var toolbarTitle = FrLocalizations.of(context).cropAvatarPageAppBarTitle;
      var toolbarColor = Theme.of(context).primaryColor;
      var backgroundColor = Colors.black;
      var statusBarColor = Colors.grey;
      var toolbarWidgetColor = Colors.white;
      var doneButtonTitle = FrLocalizations.of(context).confirmButtonText;
      var cancelButtonTitle = FrLocalizations.of(context).cancelButtonText;
      var croppedFile = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressFormat: ImageCompressFormat.png,
          compressQuality: 90,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: toolbarTitle,
              toolbarColor: toolbarColor,
              backgroundColor: backgroundColor,
              statusBarColor: statusBarColor,
              toolbarWidgetColor: toolbarWidgetColor),
          iosUiSettings: IOSUiSettings(
              title: toolbarTitle,
              doneButtonTitle: doneButtonTitle,
              cancelButtonTitle: cancelButtonTitle));
      if (croppedFile != null) {
        debugPrint("Crop avatar finish");
        Navigator.of(context).pop(readFileAsBytes(croppedFile.path));
      }
    }
  }
}
