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
    return Scaffold(
      appBar: AppBar(title: const Text("Shimmer Loading"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ShimmerPremium(
                childDecoration: ChildDecoration(
                  child: ShimmerPremiumRepo().getDefaultChild,
                  childLength: 5,
                  childHeight: 95,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
