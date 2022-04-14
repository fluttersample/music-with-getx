

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/presentation/controller/SplashViewModel.dart';


class SplashView extends GetView<SplashViewModel> {
  const SplashView({Key? key}) : super(key: key);
  static const String id ='/splash_view';

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) =>  Scaffold(
        body: Center(
          child: NeumorphicText(
            "Evo Music",
            style:  NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12)),
              depth: 8,
              intensity: 0.8,
              lightSource: LightSource.topLeft,
              color: Colors.pinkAccent,

            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 50,
              fontFamily: 'WetPaint'
            ),
          ),
        ),
      ),
    );
  }


}