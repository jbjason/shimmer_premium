// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:shimmer_premium/config/theme/theme.dart';
import 'package:shimmer_premium/core/util/mycolor.dart';
import 'package:shimmer_premium/shimmer_premium.dart';

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
            ShimmerPremium(
              itemHeight: 95,
              length: 4,
              itemSeparateHeightWidth: 20,
              highlightColor: Colors.greenAccent,
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
