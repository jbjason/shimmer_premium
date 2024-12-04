// ignore_for_file: depend_on_referenced_packages, deprecated_member_use
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shimmer_premium/core/util/mycolor.dart';
import 'package:vector_math/vector_math_64.dart' as degree;

enum ShimmerListType { horizontalList, verticalList, gridViewList }

class ShimmerPremiumRepo {
  Widget getImage({
    double height = 35,
    double width = 35,
    Color color = MyColor.inActiveColor,
    double borderRadius = 2,
    BoxShape shape = BoxShape.rectangle,
  }) =>
      Container(
        width: height,
        height: width,
        constraints: const BoxConstraints.expand(),
        decoration: shape == BoxShape.rectangle
            ? BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget getTitle({
    double height = 150,
    double width = 8,
    Color color = MyColor.inActiveColor,
    double borderRadius = 2,
  }) =>
      Container(
        width: height,
        height: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );

  Widget getSubTitle({
    double height = 200,
    double width = 4,
    Color color = MyColor.inActiveColor,
    double borderRadius = 2,
  }) =>
      Container(
        width: height,
        height: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );

  Widget getDivider({
    Color color = MyColor.inActiveColor,
    double thickness = .5,
    double height = 16,
    double width = 20,
    Axis shape = Axis.horizontal,
  }) =>
      shape == Axis.horizontal
          ? Divider(color: color, height: height, thickness: thickness)
          : VerticalDivider(color: color, width: width, thickness: thickness);
  Widget getBodyTitle({
    double height = 20,
    double? width,
    Color color = MyColor.bodyGreyColor,
    double borderRadius = 7.5,
  }) =>
      Container(
        width: height,
        height: width ?? window.physicalSize.width / window.devicePixelRatio,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
}

class ShimmerPremium extends StatefulWidget {
  const ShimmerPremium(
      {super.key,
      required this.child,
      this.childBackgrounColor = MyColor.cardBackgroundColor,
      this.childBorderRadius = 12,
      this.childBorderWidth = .4,
      this.childBorderColor = MyColor.inActiveColor,
      required this.childHeight,
      this.childWidth,
      this.highlightColor = Colors.white,
      this.secondaryColor = Colors.white38,
      this.length = 1,
      this.itemSeparateHeightWidth = 0,
      this.shimmerListType = ShimmerListType.verticalList,
      this.duration = const Duration(milliseconds: 1300)});
  final Widget child;
  final Color childBackgrounColor;
  final double childHeight;
  final double? childWidth;
  final double childBorderRadius;
  final double childBorderWidth;
  final Color childBorderColor;
  final Color highlightColor;
  final Color secondaryColor;
  final int length;
  final double itemSeparateHeightWidth;
  final ShimmerListType shimmerListType;
  final Duration duration;
  @override
  State<ShimmerPremium> createState() => _ShimmerPremiumState();
}

class _ShimmerPremiumState extends State<ShimmerPremium>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _isVerticalScroll = true;
  double _shimmerchildWidth = 0;
  //final GlobalKey _sizeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _colorAnimation =
        ColorTween(begin: widget.highlightColor, end: widget.secondaryColor)
            .animate(_controller);
    _controller.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isVerticalScroll = widget.shimmerListType == ShimmerListType.verticalList;
    _shimmerchildWidth = widget.childWidth ?? MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_isVerticalScroll) {
      return SingleChildScrollView(
        child: Column(
            children: List.generate(widget.length, (i) => _getShimmeritem)),
      );
    } else if (widget.shimmerListType == ShimmerListType.horizontalList) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
            Row(children: List.generate(widget.length, (i) => _getShimmeritem)),
      );
    } else {
      return SizedBox(
        height: size.height,
        child: GridView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: widget.childWidth ?? size.width / 2,
            childAspectRatio: 1.07,
            crossAxisSpacing: widget.itemSeparateHeightWidth,
            mainAxisSpacing: widget.itemSeparateHeightWidth,
          ),
          children: List.generate(8, (i) => _getShimmeritem),
        ),
      );
    }
  }

  Widget get _getShimmeritem => Container(
        height: widget.childHeight,
        width: _shimmerchildWidth,
        margin: EdgeInsets.only(
          bottom: _isVerticalScroll ? widget.itemSeparateHeightWidth : 0,
          right: _isVerticalScroll ? 0 : widget.itemSeparateHeightWidth,
        ),
        child: Stack(
          children: [
            widget.child,
            Positioned(
              left: 20,
              top: -100,
              bottom: -50,
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
