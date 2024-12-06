
import 'package:flutter/material.dart';

class CustomCPI extends StatelessWidget {
  final Color? color;
  final double? widthCPI;
  final double? heightCPI;
  final double? width;
  final double? height;
  final double strokeWidth;
  const CustomCPI({
    Key? key,
    this.color,
    this.widthCPI = 40.0,
    this.heightCPI = 40.0,
    this.width = 40.0,
    this.height = 40.0,
    this.strokeWidth = 4.0,
  })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: SizedBox(
            width: widthCPI,
            height: heightCPI,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.orange),
              strokeWidth: strokeWidth,
            )));
  }
}