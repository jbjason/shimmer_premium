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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // vertical list example
              ShimmerPremium(
                childDecoration: ChildDecoration(
                  child: ShimmerPremiumRepo().getDefaultChild,
                  childLength: 8,
                  childHeight: 95,
                ),
                shimmerDecoration: const ShimmerDecoration(
                    shimmerListType: ShimmerListType.verticalList),
              ),
              const SizedBox(height: 30),
              // horizontal list example
              ShimmerPremium(
                childDecoration: ChildDecoration(
                  child: ShimmerPremiumRepo().getDefaultChild,
                  childLength: 8,
                  childHeight: 95,
                ),
                shimmerDecoration: const ShimmerDecoration(
                    shimmerListType: ShimmerListType.horizontalList),
              ),
              const SizedBox(height: 30),
              // gridview example
              ShimmerPremium(
                childDecoration: ChildDecoration(
                  child: ShimmerPremiumRepo().getDefaultGridChild,
                  childLength: 8,
                  childHeight: 250,
                ),
                shimmerDecoration: ShimmerDecoration(
                  shimmerListType: ShimmerListType.gridViewList,
                  gridList: ShimmerGridList(screenHeight: size.height * .85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
