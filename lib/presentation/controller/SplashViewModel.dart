

import 'package:get/get.dart';
import 'package:music_player_getx/presentation/views/HomeView.dart';

class SplashViewModel extends GetxController
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