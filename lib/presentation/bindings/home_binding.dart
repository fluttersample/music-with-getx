import 'package:get/get.dart';
import 'package:music_player_getx/injection_container.dart';
import 'package:music_player_getx/presentation/controller/home_controller.dart';



class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(
        audioQueryRepo: sl(),
        audioPlayersRepo: sl(),
        audioRoomRep: sl()
      ),
    );
  }
}
