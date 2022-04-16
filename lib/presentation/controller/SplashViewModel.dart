

import 'package:get/get.dart';
import 'package:music_player_getx/presentation/views/HomeView.dart';

class SplashViewModel extends GetxController
{


  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1),
        (){
          Get.offAndToNamed(HomeView.id);
        });

  }


}