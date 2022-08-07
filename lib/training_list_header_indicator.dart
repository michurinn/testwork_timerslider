import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Индикатор текущей страницы
class TrainingListHeaderIndicator extends StatelessWidget {
  const TrainingListHeaderIndicator({
    Key? key,
    this.controller,
  }) : super(key: key);

  final PageController? controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller!, // PageController
      count: 3,
      effect: WormEffect(
        spacing: 12.0,
        dotWidth: 8.0,
        dotHeight: 8.0,
        dotColor: Colors.lightGreenAccent,
        activeDotColor: Colors.orangeAccent,
      ),
    );
  }

}
