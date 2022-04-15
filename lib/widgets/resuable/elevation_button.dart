import 'package:flutter/material.dart';




class ElevationButtonWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  final Widget widget;
  final VoidCallback onPress;
   const ElevationButtonWidget({
    required this.onPress,
    required this.widget ,
    Key? key,
    this.height = 40,
    this.width = 50,
    this.color,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          primary: color,
          minimumSize: Size(width, height),

          shape: const CircleBorder(),
        ),
        child: widget);
  }
}
