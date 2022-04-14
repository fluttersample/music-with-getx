
import 'package:flutter/material.dart';
class MyErrorWidget extends StatelessWidget {
  final String textError;
  const MyErrorWidget({Key? key,required this.textError}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(textError,
        ));
  }
}
