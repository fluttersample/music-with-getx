



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/models/AudioModel.dart';
import 'package:music_player_getx/repository/audio_players/AudioPlayersRepo.dart';
import 'package:music_player_getx/repository/audio_query/AudioQueryRepo.dart';
import 'package:music_player_getx/repository/audio_room/AudioRoomRep.dart';
import 'package:music_player_getx/utils/Utils.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart' ;
import 'package:on_audio_room/on_audio_room.dart';


class HomeViewModel extends GetxController {
  final AudioQueryRepo _audioQueryRepo;
  final AudioPlayersRepo _audioPlayersRepo;
  final AudioRoomRep _audioRoomRep;
  HomeViewModel({
    required AudioQueryRepo audioQueryRepo,
    required AudioPlayersRepo audioPlayersRepo,
  required AudioRoomRep audioRoomRep}) :
    _audioQueryRepo = audioQueryRepo,
  _audioPlayersRepo = audioPlayersRepo,
  _audioRoomRep =audioRoomRep;

  @override
  void onInit() {
    super.onInit();

    getStateAudio();


  }

  /// Variables
  int indexCurrent =0;
  Rx<bool> isGridView = true.obs;
  final searchController = TextEditingController();
  Rx<AudioModel?>? currentAudio = const AudioModel().obs;
  RxList<AudioModel>? audioModel =  <AudioModel>[].obs;
  var stateAudio = Rx<PlayerState>(PlayerState.STOPPED);







  /// Methods
  Future<List<AudioModel?>?> getAllSung()async{
    await _audioQueryRepo.requestPermission();
    final result  =await _audioQueryRepo.getAllSong();
    audioModel?.clear();
    for (var element in result) {
      final data = AudioModel(
          data: element.data,
          title: element.title,
          id: element.id,
          displayName: element.displayName,
          isAddToFavorite: await statusIsLike(element.id)
      );

      audioModel?.add(data);
    }
    return audioModel;
  }
  Future<RxBool> statusIsLike(int key) async {
    final bool z = await  _audioRoomRep.checkIn(RoomType.FAVORITES, key);
    return Future.value(z.obs);
  }
  Future<List<SongModel>> getSongWithFilter(String text)async
  {
    final result = await _audioQueryRepo.getSongWithFilter(text);
    return result.toSongModel();
  }
  Future<int> play(String url)async
  {
    return await _audioPlayersRepo.startAudio(url: url);
  }
  bool isPlayNow(int id){
    if(
     currentAudio?.value?.id ==id &&
        stateAudio.value == PlayerState.PLAYING)
    {
      return true;
    }
    return false;
  }
  Future<int> stop()async
  {
    return await _audioPlayersRepo.stopAudio();
  }
  Future<int> pause()async
  {
    return await _audioPlayersRepo.pauseAudio();
  }
  Future<int> resume()async
  {
    return await _audioPlayersRepo.resumeAudio();
  }
  void playOrPause(AudioModel data,int index)
  {
    indexCurrent = index;
    if(stateAudio.value == PlayerState.PLAYING)
    {
      if(currentAudio!.value?.id == data.id)
      {
        pause();
        return;
      }
      stop();
      updateValue(data);
      play(data.data!);
      return;
    }
    if(stateAudio.value == PlayerState.PAUSED)
    {
      if(currentAudio!.value?.id == data.id)
      {
        resume();
        return;
      }
      updateValue(data);
      play(data.data!);
      return;
    }
    updateValue(data);
    play(data.data!);


  }
  void getStateAudio ()
  {
    _audioPlayersRepo.getStateAudio().listen((event) {
      stateAudio.value = event;
    });
  }
  bool isLastItem({required int index,required int length})
  {
    if(index == length-1){
      return true;
    }
    return false;

  }
  bool isFirstItem(int index)
  {
    if(index == 0)
      {
        return true;
      }
    return false;
  }
  void seekToNext()
  {
    print(indexCurrent);
    indexCurrent = isLastItem(
        index: indexCurrent,
        length: audioModel!.length) ? 0 :indexCurrent+1;
    print(indexCurrent);
    final data = audioModel![indexCurrent];
    playOrPause(data, indexCurrent);

  }
  void seekToPrevious()
  {
    indexCurrent = isFirstItem(indexCurrent)? audioModel!.length-1 : indexCurrent-1;
    print(indexCurrent);
    final data = audioModel![indexCurrent];
    playOrPause(data, indexCurrent);
  }
  // void searchInListAudio(String query)async
  // {
  //   List<SongModel> _resultSearch = [];
  //   List<SongModel> allAudio=await getAllSung();
  //   if(query.isEmpty)
  //     {
  //       audioModel =allAudio;
  //       return;
  //     }
  //       for (var element in allAudio) {
  //         if(element.title.contains(query) )
  //         {
  //           _resultSearch.add(element);
  //         }
  //       }
  //       _setValueListSongModel =_resultSearch;
  //
  // }

  void addOrRemoveToPlayList({required AudioModel data,
    required int index})async
  {
    final liked = await statusIsLike(data.id!);

    if(liked.value == true)
      {
       removeFromFavoriteList(data.id!);
       Utils.showSuccess(message: 'Item Removed',
       icon: Icons.favorite_border);
       data.isAddToFavorite?.value = false;
       return;
      }
    _audioRoomRep.addTo(RoomType.FAVORITES, data.toMap().toFavoritesEntity());
  //  await fromFavorites(data.id);
    data.isAddToFavorite!.value = true;
    Utils.showSuccess(message: 'Item add To Favorites');
  }

  void removeFromFavoriteList(int id)
  {
    _audioRoomRep.deleteFrom(RoomType.FAVORITES,
        id);
  }

  void changeToGridView(bool value)
  {
   if(value == true)
     {
     Get.back();
     Utils.unHideOverLay();
     Future.delayed(const
     Duration(milliseconds: 100),(){
       isGridView(true);
       update();
     });


     }else {
     Get.back();
     Utils.unHideOverLay();

     Future.delayed(
         const Duration(milliseconds: 100),()
     {
       isGridView(false);
       update();
     });


   }
  }


  /// Private Methods
  void updateValue(AudioModel value)
  {
    currentAudio?.value = value;
  }
}
