

import 'package:get/get.dart';
import 'package:music_player_getx/core/GetController/GetController.dart';
import 'package:music_player_getx/presentation/views/HomeView.dart';

class SplashViewModel extends GetController
{


  @override
  void onInit() {
    super.onInit();
    print('asdsadsad');
    Future.delayed(const Duration(seconds: 2),
        (){
          Get.offAndToNamed(HomeView.id);
        });

  }

  @override
  void onReady() {
    print('asdsadsad');

    super.onReady();

  }
}