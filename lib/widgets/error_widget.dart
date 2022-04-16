
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final IconData iconData;
  final double size;
  const MyErrorWidget({Key? key,
     this.iconData = Icons.image_not_supported_outlined,
  this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset('assets/images/no_image.png'));
  }
}
