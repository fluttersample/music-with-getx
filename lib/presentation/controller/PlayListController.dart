

import 'package:audioplayers/audioplayers_api.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/models/AudioModel.dart';
import 'package:music_player_getx/presentation/controller/HomeViewModel.dart';
import 'package:music_player_getx/repository/audio_players/AudioPlayersRepo.dart';
import 'package:music_player_getx/repository/audio_room/AudioRoomRep.dart';
import 'package:on_audio_room/on_audio_room.dart';


class PlayListController extends GetxController
{
  final AudioRoomRep _audioRoomRep;
  final AudioPlayersRepo _audioPlayersRepo;
  PlayListController({
    required AudioRoomRep audioRoomRep,
    required AudioPlayersRepo audioPlayersRepo,
  }) : _audioRoomRep = audioRoomRep, _audioPlayersRepo = audioPlayersRepo;

  final homeController = Get.find<HomeViewModel>();

  int indexCurrent =0;



  /// variables
  RxList<AudioModel> listFavorites =<AudioModel>[].obs;



  /// methods
  Future<List<AudioModel>> get getFavorites async {
    final result = await _audioRoomRep.queryFavorites();
    listFavorites.clear();
    for (var d in result) {
      final data = AudioModel(
          data: d.lastData,
          id: d.id,
          displayName: d.displayName,
          title: d.title
      );
      listFavorites.add(data);
    }
    return listFavorites;
  }










}