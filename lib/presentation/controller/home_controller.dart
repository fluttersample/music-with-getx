



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/models/audio_model.dart';
import 'package:music_player_getx/repository/audio_players/audio_players_repo.dart';
import 'package:music_player_getx/repository/audio_query/audio_query_repo.dart';
import 'package:music_player_getx/repository/audio_room/audio_room_repo.dart';
import 'package:music_player_getx/utils/Utils.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart' ;
import 'package:on_audio_room/on_audio_room.dart';


class HomeViewModel extends GetxController with GetSingleTickerProviderStateMixin{
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
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    _audioPlayersRepo.getStateAudio().listen((event) {
      stateAudio.value = event;
    });
    animationController =AnimationController(
        duration: const Duration(milliseconds: 10000),
        vsync: this);
  }

  /// Variables
  int indexCurrent =0;
  Rx<bool> isGridView = true.obs;
  final searchController = TextEditingController();
  Rx<AudioModel?>? currentAudio = const AudioModel().obs;
  RxList<AudioModel>? audioModel =  <AudioModel>[].obs;
  var stateAudio = Rx<PlayerState>(PlayerState.STOPPED);
  List<AudioModel?>? listFav = [];

  /// Methods
  Future<List<AudioModel>?> getAllSung()async{
    await _audioQueryRepo.requestPermission();
    final result  =await _audioQueryRepo.getAllSong();
    audioModel?.clear();
    for (var element in result) {
      final data = AudioModel(
          data: element.data,
          title: element.title,
          id: element.id,
          displayName: element.displayName,
          isAddToFavorite: await _statusIsLike(element.id)
      );

      audioModel?.add(data);
    }
    return audioModel;
  }


  Future<List<SongModel>> getSongWithFilter(String text)async
  {
    final result = await _audioQueryRepo.getSongWithFilter(text);
    return result.toSongModel();
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

  void playOrPause(AudioModel data,int index)
  {
    indexCurrent = index;
    if(stateAudio.value == PlayerState.PLAYING)
    {
      if(currentAudio!.value?.id == data.id)
      {
        _pause();
        animationController.stop();
        return;
      }
      _stop();
      updateValue(data);
      _play(data.data!);
      return;
    }
    if(stateAudio.value == PlayerState.PAUSED)
    {
      if(currentAudio!.value?.id == data.id)
      {
        _resume();
        animationController.repeat();
        return;
      }
      updateValue(data);
      _play(data.data!);
      return;
    }
    animationController.repeat();
    updateValue(data);
    _play(data.data!);


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
    if(listFav!.isNotEmpty){
      indexCurrent = isLastItem(
          index: indexCurrent,
          length: listFav!.length) ? 0 :indexCurrent+1;
      final data = listFav![indexCurrent];
      playOrPause(data!, indexCurrent);
      return;
    }
    indexCurrent = isLastItem(
        index: indexCurrent,
        length: audioModel!.length) ? 0 :indexCurrent+1;

    final data = audioModel![indexCurrent];
    playOrPause(data, indexCurrent);

  }
  void seekToPrevious()
  {
    if(listFav!.isNotEmpty){
      indexCurrent = isFirstItem(indexCurrent)? listFav!.length-1 : indexCurrent-1;
      final data = listFav![indexCurrent];
      playOrPause(data!, indexCurrent);
      return;
    }
    indexCurrent = isFirstItem(indexCurrent)? audioModel!.length-1 : indexCurrent-1;
    print(indexCurrent);
    final data = audioModel![indexCurrent];
    playOrPause(data, indexCurrent);
  }

  // void searchInListAudio(String query)async
  // {
  //   List<AudioModel> _resultSearch = [];
  //   final allAudio=await getAllSung();
  //   _resultSearch.addAll(allAudio!);
  //   if(query.isNotEmpty)
  //     {
  //       List<AudioModel> _dummyListData = [];
  //       for (var element in _resultSearch) {
  //         if(element.title!.contains(query))
  //         {
  //           _dummyListData.add(element);
  //         }
  //       }
  //       audioModel?.clear();
  //       audioModel?.addAll(_dummyListData);
  //       update();
  //     }else{
  //     audioModel?.clear();
  //     audioModel?.addAll(allAudio);
  //   }
  //
  // }

  void addOrRemoveToPlayList({required AudioModel data,
    required int index})async
  {
    final liked = await _statusIsLike(data.id!);

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
  Future<int> _stop()async
  {
    return await _audioPlayersRepo.stopAudio();
  }
  Future<int> _pause()async
  {
    return await _audioPlayersRepo.pauseAudio();
  }
  Future<int> _resume()async
  {
    return await _audioPlayersRepo.resumeAudio();
  }
  Future<RxBool> _statusIsLike(int key) async {
    final bool z = await  _audioRoomRep.checkIn(RoomType.FAVORITES, key);
    return Future.value(z.obs);
  }
  Future<int> _play(String url)async
  {
    return await _audioPlayersRepo.startAudio(url: url);
  }
}
