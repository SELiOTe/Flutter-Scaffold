import 'package:fitting_room/model/backend/cart/add.dart';
import 'package:fitting_room/model/backend/page.dart';
import 'package:fitting_room/util/text.dart';
import 'package:fitting_room/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../model/backend/goods/info.dart';
import '../util/backend.dart';
import '../widget/swiper.dart';
import '../util/common.dart';
import '../page/home.dart';
import '../l10n/l10n.dart';
import '../model/backend/goods/comment.dart';
import 'image_viewer.dart';
import 'product_comment.dart';

// 页面名称
const PRODUCT_PAGE_NAME = "/product";

class ProductPageArg {
  // 商品 ID
  int _productId;
  // 跳转来源，即从哪里点击获取商品信息页的
  int _jumpFrom;

  ProductPageArg(this._productId, this._jumpFrom);

  int get productId => _productId;

  int get jumpFrom => _jumpFrom;
}

/// 商品页
class ProductPage extends StatefulWidget {
  final ProductPageArg _arg;

  ProductPage(this._arg);

  ProductPageArg get arg => _arg;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  InfoResp _infoResp;
  _CommentInfo _commentInfo;

  // 所选颜色与尺码
  int _selectedColor;
  int _selectedSize;

  @override
  void initState() {
    super.initState();
    _initInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 状态栏置于 Body 之上且透明
        extendBodyBehindAppBar: true,
        appBar: _getAppBar(),
        body: _getBodyWidget());
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Container(
        margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(80), shape: BoxShape.circle),
        child: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
          decoration: BoxDecoration(
              color: Colors.grey.withAlpha(80), shape: BoxShape.circle),
          child: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            color: Colors.black,
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(HOME_PAGE_NAME, (route) => false),
          ),
        )
      ],
    );
  }

  void _initInfo() async {
    await _productInfo();
    await _commnetInfo();
    setState(() {});
  }

  Future<void> _productInfo() async {
    final uri = "goods/info";
    var resp = await postObject(
        uri, InfoReq(widget.arg.productId, widget.arg.jumpFrom));
    if (resp == null) {
      return;
    }
    _infoResp = InfoResp.fromJson(resp.data);
    _infoResp.images.sort((f, s) => f.imageOrder.compareTo(s.imageOrder));
    _infoResp.skus.sort((f, s) => f.colorId.compareTo(s.colorId));
  }

  Future<void> _commnetInfo() async {
    final uri = "goods/comment";
    var resp = await postObject(uri, CommentReq(1, 1, 1, 1));
    if (resp == null) {
      return;
    }
    var page = PageResp.fromJson(resp.data);
    if (page.page.length != 0) {
      _commentInfo = _CommentInfo();
      var comment = CommentResp.fromJson(page.page[0]);
      // 这里没有用评论图片
      _commentInfo.userId = comment.userId;
      _commentInfo.createAt = timestamp2DateTime(comment.createdAt);
      _commentInfo.commentText = comment.text;
      var commentUserInfo = await getUserInfo(_commentInfo.userId);
      _commentInfo.nickname = commentUserInfo.nickname;
      _commentInfo.avatar = commentUserInfo.avatar;
      _commentInfo.commentCount = page.totalCount;
    }
  }

  Widget _getBodyWidget() {
    return Container(
        color: Colors.grey[200],
        child: Column(
          children: [Expanded(child: _getContentWidget()), _getBottomBar()],
        ));
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getImageSwiper(),
          dividerWidget(vertical: 8),
          _getIntroductionWidget(),
          _getSelectingWidget(),
          _getCommentWidget()
        ],
      ),
    );
  }

  Widget _getBottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
      color: Colors.white,
      child: Column(children: [
        Row(
          children: [
            Expanded(child: Container()),
            Builder(
                builder: (context) => _getButtomButton(
                    FrLocalizations.of(context).productAddToCartText,
                    () => _add2Cart(context))),
            dividerWidget(horizontal: 8),
            _getButtomButton(
                FrLocalizations.of(context).productBuyNowText, () {})
          ],
        ),
      ]),
    );
  }

  Widget _getButtomButton(String text, Function callback) {
    return FlatButton(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.redAccent,
        highlightColor: Colors.orange[300],
        splashColor: Colors.orange[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: callback);
  }

  void _add2Cart(BuildContext context) async {
    final uri = "cart/add";
    int productId = widget._arg.productId;
    var colorId = _selectedColor;
    var sizeId = _selectedSize;
    if (productId == null) {
      snackBar(context, FrLocalizations.of(context).productAddToCartFailed);
      return;
    }
    if (colorId == null ||
        sizeId == null ||
        colorId2String(colorId) == null ||
        sizeId2String(sizeId) == null) {
      snackBar(context, FrLocalizations.of(context).productAddToCartNotSelect);
      return;
    }
    var addResp;
    var loading = CircularLoading(context);
    loading.show();
    try {
      var resp = await postObject(uri, AddReq(productId, colorId, sizeId));
      addResp = AddResp.fromJson(resp.data);
    } finally {
      loading.dismiss();
    }
    if (addResp == null || addResp.status != 0) {
      snackBar(context, FrLocalizations.of(context).productAddToCartFailed);
      return;
    } else {
      snackBar(context, FrLocalizations.of(context).productAddToCartSuccess);
      return;
    }
  }

  Widget _getImageSwiper() {
    final size = MediaQuery.of(context).size;
    var height = size.width;
    var imgSwiper;
    if (_infoResp == null ||
        _infoResp.images == null ||
        _infoResp.images.length == 0) {
      imgSwiper = _getSwiperPlaceHolder(height);
    } else {
      var imgs = new List<String>();
      _infoResp.images.forEach((element) {
        imgs.add(element.image);
      });
      imgSwiper = Container(
          height: height,
          child: Swiper(
            itemCount: _infoResp.images.length,
            itemBuilder: (context, index) => getCachedNetworkImage(
                _infoResp.images[index].image,
                width: height,
                height: height,
                fit: BoxFit.cover),
            pagination: SwiperPagination(
                margin: EdgeInsets.all(8), builder: Pagination()),
            loop: false,
            onTap: (index) => Navigator.of(context).pushNamed(PAGE_VIEWER_NAME,
                arguments: ImageViewerPageArg(index, imgs)),
          ));
    }
    return imgSwiper;
  }

  Widget _getIntroductionWidget() {
    String listPrice;
    String dealerWillEarn;
    String moneySymbol = FrLocalizations.of(context).moneySymbol;
    String dealerEarnPrompt = FrLocalizations.of(context).productDealerWillEarn;
    if (_infoResp == null ||
        _infoResp.price == null ||
        _infoResp.listPriceMethod == null) {
      listPrice = "";
      dealerWillEarn = "";
    } else {
      listPrice = "${(_infoResp.price / 100).toStringAsFixed(2)} $moneySymbol";
      dealerWillEarn =
          "$dealerEarnPrompt${(_infoResp.price / 1000).toStringAsFixed(2)} $moneySymbol";
    }
    return _getCardWidget(Column(children: [
      _getPriceWidget(listPrice, dealerWillEarn),
      dividerWidget(vertical: 8),
      _getProductNameWidget(),
    ]));
  }

  Widget _getSelectingWidget() {
    if (_selectedColor == null || _selectedSize == null) {
      return _getSelectingPromptWidget(FrLocalizations.of(context).none);
    } else {
      var color = colorId2String(_selectedColor);
      var size = sizeId2String(_selectedSize);
      return _getSelectingPromptWidget("$color $size");
    }
  }

  Widget _getCommentWidget() {
    return GestureDetector(
        child: _getCardWidget(
          _commentInfo == null
              ? _getNoneCommentWidget()
              : _getHaveCommentWidget(),
        ),
        onTap: () => Navigator.of(context).pushNamed(PRODUCT_COMMENT_PAGE_NAME,
            arguments: widget._arg._productId));
  }

  Widget _getPriceWidget(String listPrice, String dealerWillEarn) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(
        listPrice,
        textScaleFactor: 1.3,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
      ),
      dividerWidget(horizontal: 8),
      GestureDetector(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Icon(Icons.help_outline, size: 16),
            dividerWidget(vertical: 4)
          ]),
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => Center(
                    child: Text("Show calculate method"),
                  ))),
      Expanded(child: Container()),
      Text(dealerWillEarn)
    ]);
  }

  Widget _getProductNameWidget() {
    String productName;
    if (_infoResp == null ||
        _infoResp.images == null ||
        _infoResp.images.length == 0) {
      productName = "";
    } else {
      productName = _infoResp.name;
    }
    return Row(
      children: [
        Text(
          productName,
          textScaleFactor: 1.1,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _getSwiperPlaceHolder(double size) {
    return Container(
        height: size,
        child: Swiper(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
            );
          },
          pagination: SwiperPagination(
              margin: EdgeInsets.all(8), builder: Pagination()),
          loop: false,
        ));
  }

  Widget _getSelectingPromptWidget(String text) {
    return Builder(
      builder: (context) => GestureDetector(
          child: _getCardWidget(
            Row(children: [
              Text(
                "${FrLocalizations.of(context).productSelecting}$text",
                // textScaleFactor: 1.1,
              ),
              Expanded(child: Container()),
              Icon(Icons.chevron_right)
            ]),
          ),
          onTap: _infoResp == null
              ? null
              : () async {
                  await _selectingOnTap(context);
                  setState(() {});
                }),
    );
  }

  Future<int> _selectingOnTap(BuildContext context) async {
    return showModalBottomSheet<int>(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
            builder: (_, innerSetstate) => Container(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                height: MediaQuery.of(context).size.height / 3,
                color: Colors.grey[150],
                child: Column(
                  children: [
                    dividerWidget(vertical: 8),
                    _getSelectingOnTapHeader(),
                    Divider(),
                    Expanded(child: _getSelectingOnTapContent(innerSetstate))
                  ],
                ))));
  }

  Widget _getNoneCommentWidget() {
    return Column(
      children: [
        Row(
          children: [
            Text(FrLocalizations.of(context).productCommentTitle(0)),
            Expanded(child: Container()),
            Icon(Icons.chevron_right)
          ],
        )
      ],
    );
  }

  Widget _getHaveCommentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getHaveCommentHeader(),
        dividerWidget(vertical: 8),
        _getHaveCommentUserInfo(),
        dividerWidget(vertical: 8),
        _getCommentText()
      ],
    );
  }

  Widget _getHaveCommentHeader() {
    return Row(
      children: [
        Text(FrLocalizations.of(context)
            .productCommentTitle(_commentInfo.commentCount)),
        Expanded(child: Container()),
        Icon(Icons.chevron_right)
      ],
    );
  }

  Widget _getHaveCommentUserInfo() {
    var commentDaysAgo =
        DateTime.now().difference(_commentInfo.createAt).inDays;
    return IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipOval(
            child: getCachedNetworkImage(_commentInfo.avatar,
                width: 40, height: 40)),
        dividerWidget(horizontal: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_commentInfo.nickname),
            dividerWidget(vertical: 4),
            Text(FrLocalizations.of(context)
                .productCommentHowManyDaysAgo(commentDaysAgo))
          ],
        )
      ],
    ));
  }

  Widget _getCommentText() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          _commentInfo.commentText,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Widget _getSelectingOnTapHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(FrLocalizations.of(context).productColorPrompt)],
            )),
        dividerWidget(horizontal: 8),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(FrLocalizations.of(context).productSizePrompt)
                    ])),
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(FrLocalizations.of(context).productStockPrompt)
                    ]))
              ],
            )),
      ],
    );
  }

  Widget _getSelectingOnTapContent(Function innerSetstate) {
    return Row(children: [
      Expanded(flex: 1, child: _getColorListView(innerSetstate)),
      dividerWidget(horizontal: 8),
      Expanded(flex: 2, child: _getSizeAndStockListView(innerSetstate)),
    ]);
  }

  Widget _getColorListView(Function innerSetstate) {
    int selected;
    var colors = List<int>();
    _infoResp.skus.forEach((element) {
      if (!colors.contains(element.colorId)) colors.add(element.colorId);
    });
    if (_selectedColor != null) {
      selected = colors.indexOf(_selectedColor);
    }
    return Container(
      child: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (_, i) => ListTile(
          tileColor: (selected != null && selected == i)
              ? Colors.grey[350]
              : Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("${colorId2String(colors[i])}")],
          ),
          onTap: () {
            innerSetstate(() {
              // 同时要设置一下外面的
              _selectedColor = colors[i];
              _selectedSize = null;
            });
          },
        ),
      ),
    );
  }

  Widget _getSizeAndStockListView(Function innerSetstate) {
    int selected;
    var sizes = List<int>();
    var stocks = List<int>();
    if (_selectedColor != null) {
      _infoResp.skus.forEach((element) {
        if (element.colorId == _selectedColor &&
            !sizes.contains(element.sizeId)) {
          sizes.add(element.sizeId);
          stocks.add(element.stock);
        }
      });
    }
    if (_selectedColor != null && _selectedSize != null) {
      selected = sizes.indexOf(_selectedSize);
    }
    return _getSizeAndStockListViewWidget(
        innerSetstate, selected, sizes, stocks);
  }

  Widget _getSizeAndStockListViewWidget(
      Function innerSetstate, int selected, List<int> sizes, List<int> stocks) {
    return Container(
      child: ListView.builder(
        itemCount: sizes.length,
        itemBuilder: (_, i) => ListTile(
          contentPadding: EdgeInsets.all(0),
          tileColor: (selected != null && selected == i)
              ? Colors.grey[350]
              : Colors.transparent,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "${sizeId2String(sizes[i])}",
                style: _getSizeAndStockTextStyle(stocks[i]),
              )
            ])),
            Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "${stocks[i]}",
                style: _getSizeAndStockTextStyle(stocks[i]),
              )
            ]))
          ]),
          onTap: (stocks[i] == null || stocks[i] <= 0)
              ? null
              : () {
                  innerSetstate(() {
                    _selectedSize = sizes[i];
                  });
                },
        ),
      ),
    );
  }

  TextStyle _getSizeAndStockTextStyle(int stock) {
    if (stock == null || stock <= 0) {
      return TextStyle(color: Colors.grey[350]);
    }
    return TextStyle();
  }

  Widget _getCardWidget(Widget child) {
    return Container(
      child: child,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }
}

/// 用户评论信息，只有这个页面用的，没图
class _CommentInfo {
  int userId;
  String nickname;
  String avatar;
  DateTime createAt;
  String commentText;
  int commentCount;
}
