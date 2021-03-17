import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// Swiper 自定义 Pagination
class Pagination extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(80),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          "${config.activeIndex + 1}/${config.itemCount}",
        ));
  }
}
