

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'error_widget.dart';

class NullArtWorkWidget extends StatelessWidget {
  const NullArtWorkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: context.theme.
            primaryColorLight.withOpacity(0.5),
            borderRadius: BorderRadius.circular(25)
        ),
        child: const MyErrorWidget(size: 35,));
  }
}
