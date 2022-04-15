
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final IconData iconData;
  const MyErrorWidget({Key? key,
     this.iconData = Icons.image_not_supported_outlined}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(iconData));
  }
}
