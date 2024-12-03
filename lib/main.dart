// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:shimmer_premium/config/theme/theme.dart';
import 'package:shimmer_premium/core/util/mycolor.dart';
import 'package:vector_math/vector_math_64.dart' as degree;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const ShimmerLoadingScreen(),
    );
  }
}

class ShimmerLoadingScreen extends StatelessWidget {
  const ShimmerLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Shimmer Loading"), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 300, color: MyColor.skyPrimary),
            ShimmerloadingCard(
              itemHeight: 95,
              length: 4,
              itemSeparateHeightWidth: 20,
              heightLightColor: Colors.greenAccent,
              secondaryColor: Colors.green,
              scrollDirection: Axis.vertical,
              child: _getChild(size),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getChild(Size size) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(10),
        height: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColor.cardBackgroundColor,
          border: Border.all(color: MyColor.inActiveColor, width: .4),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 35,
                  width: 35,
                  child: Container(
                    color: MyColor.inActiveColor,
                    constraints: const BoxConstraints.expand(),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  width: 150,
                  height: 8,
                  color: MyColor.inActiveColor,
                ),
              ],
            ),
            const Divider(color: MyColor.inActiveColor, thickness: .5),
            Container(
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColor.bodyGreyColor,
                borderRadius: BorderRadius.circular(7.5),
              ),
            ),
          ],
        ),
      );
}

class ShimmerloadingCard extends StatefulWidget {
  const ShimmerloadingCard(
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
  State<ShimmerloadingCard> createState() => _ShimmerloadingCardState();
}

class _ShimmerloadingCardState extends State<ShimmerloadingCard>
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
