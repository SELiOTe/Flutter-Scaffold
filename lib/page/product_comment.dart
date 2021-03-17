import 'package:fitting_room/l10n/l10n.dart';
import 'package:fitting_room/util/common.dart';
import 'package:flutter/material.dart';

import '../model/backend/goods/comment.dart';
import '../util/backend.dart';
import '../model/backend/page.dart';
import '../model/backend/user/others_info_batch.dart';
import '../util/text.dart';
import 'image_viewer.dart';

// 页面名称
const PRODUCT_COMMENT_PAGE_NAME = "/product/product_comment";

class ProductCommentPage extends StatefulWidget {
  final int _productId;

  ProductCommentPage(this._productId);

  @override
  _ProductCommentPageState createState() => _ProductCommentPageState();
}

class _ProductCommentPageState extends State<ProductCommentPage> {
  int _howMany = 0;
  List<_Comment> _comments = List<_Comment>();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _getCommentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(FrLocalizations.of(context).productCommentTitle(_howMany)),
      ),
      body: _comments.length == 0 ? _getNoComment() : _getHaveComment(),
    );
  }

  Widget _getNoComment() {
    return Center(
      child: Text(FrLocalizations.of(context).productCommentNoComment),
    );
  }

  Widget _getHaveComment() {
    var divider = Container(
      height: 4,
      color: Colors.grey[300],
    );
    return ListView.separated(
      itemCount: _comments.length,
      separatorBuilder: (context, index) => divider,
      itemBuilder: (context, index) {
        if (_comments[index] == null) {
          // 加载完了
          return _getNoMoreCommentWidget();
        } else if (index == _comments.length - 1) {
          // 请求新的
          ++_currentPage;
          _getCommentData();
          return _getMoreCommentWidget();
        } else {
          // 构建当前
          return _getCommentWidget(index);
        }
      },
    );
  }

  Future<void> _getCommentData() async {
    var uri = "goods/comment";
    var commentResp = await postObject(
        uri, CommentReq(_currentPage, 10, 1, widget._productId));
    if (commentResp == null) {
      return;
    }
    var page = PageResp.fromJson(commentResp.data);
    if (page.page == null ||
        page.page.length == 0 ||
        _currentPage > page.totalPage) {
      // 最后添加一个 null 表示已经没数据了
      _comments.add(null);
      return;
    }
    _howMany = page.totalCount;
    var tmpComments = List<CommentResp>();
    for (var comment in page.page) {
      tmpComments.add(CommentResp.fromJson(comment));
    }
    if (tmpComments.length == 0) {
      _comments.add(null);
      return;
    }
    // 时间倒序，别忘了 - 号
    tmpComments.sort((f, s) => -f.createdAt.compareTo(s.createdAt));
    var othersInfoReq = List<OthersInfoBatchReq>();
    for (var comment in tmpComments) {
      othersInfoReq.add(OthersInfoBatchReq(comment.userId));
    }
    uri = "user/others_info_batch";
    var userResp = await postArray(uri, othersInfoReq);
    if (userResp == null) {
      return;
    }
    var tmpUsers = List<OthersInfoBatchResp>();
    for (var user in userResp.data) {
      tmpUsers.add(OthersInfoBatchResp.fromJson(user));
    }
    for (var c in tmpComments) {
      var u = tmpUsers.firstWhere((user) => user.id == c.userId,
          orElse: () => null);
      if (u != null) {
        var comment =
            _Comment(u.id, u.avatar, u.nickname, c.createdAt, c.text, c.images);
        _comments.add(comment);
      }
    }
    if (_currentPage == page.totalPage) {
      _comments.add(null);
    }
    setState(() {});
  }

  Widget _getNoMoreCommentWidget() {
    // 这个用 ListTile 中间的分割感会很明显，直接加个 Padding 吧
    return _getCommentBlockWidget(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(FrLocalizations.of(context).productCommentNoMore)]));
  }

  Widget _getMoreCommentWidget() {
    return _getCommentBlockWidget(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(FrLocalizations.of(context).productCommentLoading)],
    ));
  }

  Widget _getCommentWidget(int index) {
    var _comment = _comments[index];
    return _getCommentBlockWidget(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getCommentHeaderWidget(_comment),
        dividerWidget(vertical: 8),
        _getCommentTextWidget(_comment),
        dividerWidget(vertical: 8),
        _getCommentImageWidget(_comment),
      ],
    ));
  }

  Widget _getCommentBlockWidget(Widget child) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        title: child);
  }

  Widget _getCommentHeaderWidget(_Comment _comment) {
    var commentDaysAgo =
        DateTime.now().difference(timestamp2DateTime(_comment.createAt)).inDays;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipOval(
              child: getCachedNetworkImage(_comment.userAvatar,
                  width: 40, height: 40)),
          dividerWidget(horizontal: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_comment.userNickname),
              // dividerWidget(vertical: 2),
              Text(FrLocalizations.of(context)
                  .productCommentHowManyDaysAgo(commentDaysAgo))
            ],
          )
        ],
      ),
    );
  }

  Widget _getCommentTextWidget(_Comment _comment) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Text(_comment.text));
  }

  Widget _getCommentImageWidget(_Comment _comment) {
    if (_comment.images.length == 0) {
      return SizedBox.shrink();
    } else {
      var images = new List<CommentImageResp>();
      for (var i in _comment.images) {
        images.add(CommentImageResp.fromJson(i));
      }
      images.sort((f, s) => f.imageOrder.compareTo(s.imageOrder));
      var imagesSha1 = new List<String>();
      images.forEach((element) => imagesSha1.add(element.image));
      var internalSpace = 4.0;
      return GridView.builder(
          // 解决嵌套问题
          shrinkWrap: true,
          // 解决嵌套滚动问题
          physics: NeverScrollableScrollPhysics(),
          itemCount: imagesSha1.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: internalSpace,
              crossAxisSpacing: internalSpace),
          itemBuilder: (context, index) => GestureDetector(
              child:
                  getCachedNetworkImage(imagesSha1[index], fit: BoxFit.cover),
              onTap: () => Navigator.of(context).pushNamed(PAGE_VIEWER_NAME,
                  arguments: ImageViewerPageArg(index, imagesSha1))));
    }
  }
}

class _Comment {
  int userId = 0;
  String userAvatar = "0000000000000000000000000000000000000000";
  String userNickname = "";
  double createAt = 0;
  String text = "";
  List<dynamic> images = List<dynamic>();

  _Comment(this.userId, this.userAvatar, this.userNickname, this.createAt,
      this.text, this.images);
}
