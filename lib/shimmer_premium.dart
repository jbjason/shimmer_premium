import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as degree;
import 'package:shimmer_premium/core/util/mycolor.dart';

enum ShimmerListType { horizontalList, verticalList, gridViewList }

class ShimmerPremium extends StatefulWidget {
  const ShimmerPremium({
    super.key,
    required this.childDecoration,
    this.shimmerDecoration = const ShimmerDecoration(),
  });
  final ChildDecoration childDecoration;
  final ShimmerDecoration shimmerDecoration;
  @override
  State<ShimmerPremium> createState() => _ShimmerPremiumState();
}

class _ShimmerPremiumState extends State<ShimmerPremium>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  double _shimmerchildWidth = 0;
  double _itemSeparateHeight = 0, _itemSeparateWidth = 0;
  //final GlobalKey _sizeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initialize();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
  }

  void _initialize() {
    // setting width in case of user forget to mention
    final view = PlatformDispatcher.instance.views.first;
    _shimmerchildWidth = widget.childDecoration.childWidth ??
        view.physicalSize.width / view.devicePixelRatio;
    if (widget.shimmerDecoration.shimmerListType ==
        ShimmerListType.verticalList) {
      _itemSeparateHeight =
          widget.shimmerDecoration.verticalList.itemSeparateHeight;
    } else if (widget.shimmerDecoration.shimmerListType ==
        ShimmerListType.horizontalList) {
      _shimmerchildWidth = _shimmerchildWidth * 3 / 4;
      _itemSeparateWidth =
          widget.shimmerDecoration.horizontalList.itemSeparateWidth;
    }
    // animation controller initialize
    _controller = AnimationController(
        vsync: this, duration: widget.shimmerDecoration.duration);
    _colorAnimation = ColorTween(
            begin: widget.shimmerDecoration.highlightColor,
            end: widget.shimmerDecoration.secondaryColor)
        .animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shimmerDecoration.shimmerListType ==
        ShimmerListType.verticalList) {
      return Column(
        children: List.generate(
            widget.childDecoration.childLength, (i) => _getShimmeritem),
      );
    } else if (widget.shimmerDecoration.shimmerListType ==
        ShimmerListType.horizontalList) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              widget.childDecoration.childLength, (i) => _getShimmeritem),
        ),
      );
    } else {
      return SafeArea(
        child: SizedBox(
          height: widget.shimmerDecoration.gridList.screenHeight,
          child: GridView.count(
            crossAxisCount: widget.shimmerDecoration.gridList.crossExisCount,
            mainAxisSpacing: widget.shimmerDecoration.gridList.mainAxisSpacing,
            crossAxisSpacing:
                widget.shimmerDecoration.gridList.crossAxisSpacing,
            childAspectRatio: widget.shimmerDecoration.gridList.screenHeight /
                widget.shimmerDecoration.gridList.crossExisCount /
                widget.childDecoration.childHeight,
            clipBehavior: widget.shimmerDecoration.gridList.clipBehavior,
            scrollDirection: widget.shimmerDecoration.gridList.scrollDirection,
            reverse: widget.shimmerDecoration.gridList.reverse,
            shrinkWrap: true,
            children: List.generate(
              widget.childDecoration.childLength,
              (i) => _getShimmeritem,
            ),
          ),
        ),
      );
    }
  }

  Widget get _getShimmeritem => Container(
        height: widget.childDecoration.childHeight,
        width: _shimmerchildWidth,
        margin: EdgeInsets.only(
          bottom: _itemSeparateHeight,
          right: _itemSeparateWidth,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.childDecoration.childBackgrounColor,
                borderRadius: BorderRadius.circular(
                    widget.childDecoration.childBorderRadius),
                border: Border.all(
                  color: widget.childDecoration.childBorderColor,
                  width: widget.childDecoration.childBorderWidth,
                ),
              ),
              child: widget.childDecoration.child,
            ),
            Positioned(
              left: 20,
              top: -(widget.childDecoration.childHeight / 2),
              bottom: -(widget.childDecoration.childHeight / 2),
              width: 120,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(degree.radians(70))
                    ..translate(_shimmerchildWidth * _controller.value,
                        1 - (_shimmerchildWidth * _controller.value)),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 80,
                          color: _colorAnimation.value!,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  // void _getSize() {
  //   RenderBox renderBox =
  //       _sizeKey.currentContext!.findRenderObject() as RenderBox;
  //   Size size = renderBox.size;
  //   widget.onSizeMeasured(size);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ChildDecoration {
  final Widget child;
  final int childLength;
  final double childHeight;
  final double? childWidth;
  final Color childBackgrounColor;
  final double childBorderRadius;
  final double childBorderWidth;
  final Color childBorderColor;
  const ChildDecoration({
    required this.child,
    this.childLength = 2,
    required this.childHeight,
    this.childWidth,
    this.childBackgrounColor = MyColor.cardBackgroundColor,
    this.childBorderRadius = 12,
    this.childBorderWidth = .4,
    this.childBorderColor = MyColor.inActiveColor,
  });
}

class ShimmerDecoration {
  final ShimmerListType shimmerListType;
  final Color highlightColor;
  final Color secondaryColor;
  final Duration duration;
  final ShimmerVerticalList verticalList;
  final ShimmerHorizontalList horizontalList;
  final ShimmerGridList gridList;

  const ShimmerDecoration({
    this.shimmerListType = ShimmerListType.verticalList,
    this.highlightColor = Colors.white,
    this.secondaryColor = Colors.white38,
    this.duration = const Duration(milliseconds: 1300),
    this.verticalList = const ShimmerVerticalList(itemSeparateHeight: 15),
    this.horizontalList = const ShimmerHorizontalList(itemSeparateWidth: 15),
    this.gridList = const ShimmerGridList(),
  });
}

class ShimmerGridList {
  const ShimmerGridList({
    this.screenHeight = 350,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.crossExisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.childAspectRatio = 1.0,
    this.clipBehavior = Clip.hardEdge,
  });
  final double screenHeight;
  final Axis scrollDirection;
  final bool reverse;
  final int crossExisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final Clip clipBehavior;
}

class ShimmerVerticalList {
  final double itemSeparateHeight;
  const ShimmerVerticalList({this.itemSeparateHeight = 15});
}

class ShimmerHorizontalList {
  final double itemSeparateWidth;
  const ShimmerHorizontalList({this.itemSeparateWidth = 15});
}

class ShimmerPremiumRepo {
  Widget getCircle({double radius = 15, Color color = MyColor.inActiveColor}) {
    return CircleAvatar(radius: 15, backgroundColor: color);
  }

  Widget getImage({
    double height = 35,
    double width = 35,
    Color color = MyColor.inActiveColor,
    double borderRadius = 2,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return Container(
      width: height,
      height: width,
      decoration: shape == BoxShape.rectangle
          ? BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(borderRadius),
            )
          : BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget getTitle({
    double height = 8,
    double width = 125,
    Color color = MyColor.inActiveColor,
    double borderRadius = 2,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  Widget getSubTitle({
    double height = 4,
    double width = 140,
    Color color = MyColor.inActiveColor,
    double borderRadius = 2,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  Widget getDivider({
    Color color = MyColor.inActiveColor,
    double thickness = .5,
    double width = 20,
    Axis shape = Axis.horizontal,
  }) {
    return shape == Axis.horizontal
        ? Divider(color: color, thickness: thickness)
        : VerticalDivider(color: color, thickness: thickness);
  }

  Widget getBodyTitle({
    double height = 20,
    double? width,
    Color color = MyColor.bodyGreyColor,
    double borderRadius = 7.5,
  }) {
    final view = PlatformDispatcher.instance.views.first;
    return Container(
      width: width ?? view.physicalSize.width / view.devicePixelRatio,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  Widget get getDefaultChild => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                ShimmerPremiumRepo().getImage(height: 35, width: 35),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerPremiumRepo().getTitle(),
                    const SizedBox(height: 5),
                    ShimmerPremiumRepo().getSubTitle(),
                  ],
                ),
              ],
            ),
            ShimmerPremiumRepo().getDivider(),
            FittedBox(child: ShimmerPremiumRepo().getBodyTitle()),
          ],
        ),
      );
  Widget get getDefaultGridChild => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                ShimmerPremiumRepo().getImage(height: 35, width: 35),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerPremiumRepo().getTitle(width: 40),
                    const SizedBox(height: 5),
                    ShimmerPremiumRepo().getSubTitle(width: 50),
                  ],
                ),
              ],
            ),
            ShimmerPremiumRepo().getDivider(),
            FittedBox(child: ShimmerPremiumRepo().getBodyTitle()),
            const SizedBox(height: 10),
            FittedBox(child: ShimmerPremiumRepo().getBodyTitle()),
          ],
        ),
      );
}
