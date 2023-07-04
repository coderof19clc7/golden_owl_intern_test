import 'package:code/constants/colors.dart';
import 'package:code/constants/dimens.dart';
import 'package:code/product_cart_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golden Sneaker',
      theme: ThemeData(
        fontFamily: 'Rubik',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _bgDecorController;
  late Animation<double> _bgDecorAnimation;

  @override
  void initState() {
    super.initState();
    _bgDecorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
      lowerBound: 0.3,
      upperBound: 0.5,
    );

    _bgDecorAnimation = CurvedAnimation(
      parent: _bgDecorController,
      curve: Curves.easeInOut,
    );

    _bgDecorController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgDecorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgDecorController,
        builder: (context, child) => Stack(
          children: [
            Positioned(
              top: Dimens.getScreenHeightByPercent(context, 0.5),
              left: -_bgDecorAnimation.value * Dimens.getScreenWidth(context),
              child: Container(
                height: Dimens.getScreenHeight(context),
                width: Dimens.getScreenWidthByPercent(context, 3),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(
                      Dimens.getScreenWidthByPercent(context, 3),
                      Dimens.getScreenHeight(context),
                    ),
                  ),
                ),
              ),
            ),

            const ProductCartView(),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
