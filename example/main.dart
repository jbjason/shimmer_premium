// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:shimmer_premium/config/theme/theme.dart';
import 'package:shimmer_premium/shimmer_premium.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer Premium',
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
            ShimmerPremium(
              childHeight: 95,
              length: 4,
              itemSeparateHeightWidth: 20,
              highlightColor: Colors.greenAccent,
              secondaryColor: Colors.green,
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
        child: Column(
          children: [
            Row(
              children: [
                ShimmerPremiumRepo().getImage(
                  height: 35,
                  width: 35,
                ),
                // SizedBox(
                //   height: 35,
                //   width: 35,
                //   child: Container(
                //     color: MyColor.inActiveColor,
                //     constraints: const BoxConstraints.expand(),
                //   ),
                // ),
                const SizedBox(width: 15),
                ShimmerPremiumRepo().getTitle(),
                // Container(
                //   width: 150,
                //   height: 8,
                //   color: MyColor.inActiveColor,
                // ),
              ],
            ),
            ShimmerPremiumRepo().getDivider(),
            // const Divider(color: MyColor.inActiveColor, thickness: .5),
            ShimmerPremiumRepo().getBodyTitle(),
            // Container(
            //   width: size.width,
            //   padding: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     color: MyColor.bodyGreyColor,
            //     borderRadius: BorderRadius.circular(7.5),
            //   ),
            // ),
          ],
        ),
      );
}
