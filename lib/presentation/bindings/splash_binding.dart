
import 'package:get/get.dart';
import 'package:music_player_getx/presentation/controller/SplashViewModel.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(() =>
        SplashViewModel());
  }

}