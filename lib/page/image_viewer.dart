import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../util/common.dart';

// 页面名称
const PAGE_VIEWER_NAME = "/page_viewer";

class ImageViewerPage extends StatefulWidget {
  final ImageViewerPageArg _arg;

  const ImageViewerPage(this._arg);
  @override
  _ImageViewerPageState createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  int _currentIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget._arg.initIndex;
    _pageController = PageController(initialPage: widget._arg.initIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      child: Container(
          child: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget._arg.images.length,
            builder: (context, index) => PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                    sha1ToImgUrl(widget._arg.images[index])),
                initialScale: PhotoViewComputedScale.contained * 1),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                debugPrint(_currentIndex.toString());
              });
            },
            pageController: _pageController,
          ),
          // 底部中间对齐
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: Text(
                  "${_currentIndex + 1}/${widget._arg.images.length}",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      )),
      onTap: () => Navigator.of(context).pop(),
    ));
  }
}

/// 页面参数，必传
class ImageViewerPageArg {
  // 初始图片索引
  final int initIndex;
  // 图片地址列表
  final List<String> images;

  ImageViewerPageArg(this.initIndex, this.images);
}
