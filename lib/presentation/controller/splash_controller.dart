

import 'package:get/get.dart';
import 'package:music_player_getx/presentation/views/home_view.dart';

class SplashViewModel extends GetxController
{


  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds:  1500),
        (){
          Get.offAndToNamed(HomeView.id);
        });

  }


}