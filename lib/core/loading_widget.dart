import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

// ignore: must_be_immutable
class LoadingWidget extends StatelessWidget {
  Color bgColor;
  LoadingWidget({super.key, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: LoadingIndicator(
        indicatorType: Indicator.ballScaleMultiple,
        colors: [
          Color.fromARGB(255, 222, 65, 170),
          Color.fromARGB(255, 97, 42, 104)
        ],
        strokeWidth: 2,
        backgroundColor: bgColor,
        pathBackgroundColor: Colors.white,
      ),
    );
  }
}
