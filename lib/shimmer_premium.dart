// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as degree;

class ShimmerPremium extends StatefulWidget {
  const ShimmerPremium(
      {super.key,
      required this.child,
      required this.itemHeight,
      this.itemWidth,
      this.heightLightColor = Colors.white,
      this.secondaryColor = Colors.white38,
      this.length = 1,
      this.itemSeparateHeightWidth = 0,
      this.scrollDirection = Axis.vertical,
      this.duration = const Duration(milliseconds: 1300)});
  final Widget child;
  final double itemHeight;
  final double? itemWidth;
  final Color heightLightColor;
  final Color secondaryColor;
  final int length;
  final double itemSeparateHeightWidth;
  final Axis scrollDirection;
  final Duration duration;
  @override
  State<ShimmerPremium> createState() => _ShimmerPremiumState();
}

class _ShimmerPremiumState extends State<ShimmerPremium>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _isVerticalScroll = true;
  double _shimmerItemWidth = 0;
  //final GlobalKey _sizeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _colorAnimation =
        ColorTween(begin: widget.heightLightColor, end: widget.secondaryColor)
            .animate(_controller);
    _controller.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isVerticalScroll = widget.scrollDirection == Axis.vertical;
    _shimmerItemWidth = widget.itemWidth ?? MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return _isVerticalScroll
        ? SingleChildScrollView(
            child: Column(
                children: List.generate(widget.length, (i) => _getShimmeritem)),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(widget.length, (i) => _getShimmeritem)),
          );
  }

  Widget get _getShimmeritem => Container(
        height: widget.itemHeight,
        width: _shimmerItemWidth,
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
                    ..translate(_shimmerItemWidth * _controller.value,
                        1 - (_shimmerItemWidth * _controller.value)),
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
