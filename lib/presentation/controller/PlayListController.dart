

import 'package:audioplayers/audioplayers_api.dart';
import 'package:get/get.dart';
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


  @override
  void onInit() {
    super.onInit();
    print(homeController.stateAudio.value);
  }

  /// variables

  List<FavoritesEntity> listFavorites = <FavoritesEntity>[];

  Future<List<FavoritesEntity>> get getFavorites async {
    final result = await _audioRoomRep.queryFavorites();
    listFavorites = result;
    return result;
  }

  Rx<FavoritesEntity?>? currentAudio =FavoritesEntity(0).obs;

  int indexCurrent =0;


  /// methods
  void _updateValue(FavoritesEntity value)
  {
    currentAudio?.value = value;
  }

  void playOrPause(FavoritesEntity data,int index)
  {
    indexCurrent = index;
    if(homeController.stateAudio.value == PlayerState.PLAYING)
    {
      if(currentAudio!.value?.id == data.id)
      {
        homeController.pause();
        return;
      }
      homeController.stop();
      _updateValue(data);
     homeController.play(data.lastData);
      return;
    }
    if(homeController.stateAudio.value == PlayerState.PAUSED)
    {
      if(currentAudio!.value?.id == data.id)
      {
        homeController.resume();
        return;
      }
      _updateValue(data);
      homeController.play(data.lastData);
      return;
    }
    _updateValue(data);
    homeController.play(data.lastData);
  }

  void sinSeekToNext()
  {

    indexCurrent = homeController.isLastItem(
      index: indexCurrent,
        length: listFavorites.length) ? 0 :indexCurrent+1;
    final data = listFavorites[indexCurrent];
    playOrPause(data, indexCurrent);

  }
  void sinSeekToPrevious()
  {
    indexCurrent = homeController.isFirstItem(indexCurrent)?
    listFavorites.length-1 : indexCurrent-1;
    print(indexCurrent);
    final data = listFavorites[indexCurrent];
    playOrPause(data, indexCurrent);
  }

  bool isPlayNow(int id){
    if(homeController.stateAudio.value ==
        PlayerState.PLAYING &&
        currentAudio?.value?.id ==id)
    {
      return true;
    }
    return false;
  }







}