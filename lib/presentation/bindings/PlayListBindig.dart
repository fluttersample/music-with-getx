

import 'package:get/get.dart';
import 'package:music_player_getx/injection_container.dart';
import 'package:music_player_getx/presentation/controller/PlayListController.dart';

class PlayListBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut<PlayListController>(() => PlayListController(
      audioRoomRep: sl()
    ));
  }


}