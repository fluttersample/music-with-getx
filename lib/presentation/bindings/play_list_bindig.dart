

import 'package:get/get.dart';
import 'package:music_player_getx/injection_container.dart';
import 'package:music_player_getx/presentation/controller/play_list_controller.dart';

class PlayListBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut<PlayListController>(() => PlayListController(
      audioRoomRep: sl(), audioPlayersRepo: sl()
    ));
  }


}