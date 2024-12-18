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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Horzontal List",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5),
                // horizontal list example
                ShimmerPremium(
                  childDecoration: ChildDecoration(
                    child: ShimmerPremiumRepo().getDefaultChild,
                    childLength: 2,
                    childHeight: 95,
                  ),
                  shimmerDecoration: const ShimmerDecoration(
                      highlightColor: Colors.pink,
                      secondaryColor: Colors.pinkAccent,
                      shimmerListType: ShimmerListType.horizontalList),
                ),
                const SizedBox(height: 20),
                Text("Vertical List",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5),
                // vertical list example
                ShimmerPremium(
                  childDecoration: ChildDecoration(
                    child: ShimmerPremiumRepo().getDefaultChild,
                    childLength: 2,
                    childHeight: 95,
                  ),
                  shimmerDecoration: const ShimmerDecoration(
                      highlightColor: Colors.pink,
                      secondaryColor: Colors.pinkAccent,
                      shimmerListType: ShimmerListType.verticalList),
                ),
                const SizedBox(height: 20),
                Text("GridView List",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5),
                // gridview example
                ShimmerPremium(
                  childDecoration: ChildDecoration(
                    child: ShimmerPremiumRepo().getDefaultGridChild,
                    childLength: 4,
                    childHeight: 250,
                  ),
                  shimmerDecoration: ShimmerDecoration(
                    highlightColor: Colors.pink,
                    secondaryColor: Colors.pinkAccent,
                    shimmerListType: ShimmerListType.gridViewList,
                    gridList: ShimmerGridList(screenHeight: size.height * .85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
