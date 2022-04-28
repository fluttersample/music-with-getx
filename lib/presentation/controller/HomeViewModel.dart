



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

  final searchController = TextEditingController();

  Rx<List<SongModel>> listSongsModel = Rx<List<SongModel>>([]);
  int indexCurrent =0;

  List<SongModel> get getValueListSongModel  =>listSongsModel.value;
  set _setValueListSongModel (List<SongModel> data) =>
      listSongsModel.value = data;


  @override
  void onInit() {
    super.onInit();
    getStateAudio();
 //   getAllFavorites();
  }
  RxList<AudioModel>? audioModel =  <AudioModel>[].obs;
  Rx<SongModel>? currentAudio = SongModel({}).obs;


  Future<RxBool> statusIsLike(int key) async {
    final bool z = await  _audioRoomRep.checkIn(RoomType.FAVORITES, key);
    return Future.value(z.obs);
  }



  Future<List<SongModel>> getAllSung()async{
   await _audioQueryRepo.requestPermission();
    _setValueListSongModel =await _audioQueryRepo.getAllSong();
    for (var element in getValueListSongModel) {
      final data = AudioModel(
        data: element.data,
        title: element.title,
        id: element.id,
        displayName: element.displayName,
        isAddToFavorite: await statusIsLike(element.id)
      );
      audioModel?.add(data);
      print(audioModel?.value);
    }
    return getValueListSongModel;
  }

  void _updateValue(SongModel value)
  {
    currentAudio?.value = value;
  }

  Future<List<SongModel>> getSongWithFilter(String text)async{
    final result = await _audioQueryRepo.getSongWithFilter(text);
    return result.toSongModel();
  }


  Future<int> play(String url)async
  {
    return await _audioPlayersRepo.startAudio(url: url);
  }
  bool isPlayNow(int id){
    if(stateAudio.value == PlayerState.PLAYING &&
        currentAudio?.value.id ==id)
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
  void playOrPause(SongModel data,int index)
  {
    indexCurrent = index;
    if(stateAudio.value == PlayerState.PLAYING)
    {
      if(currentAudio!.value.id == data.id)
      {
        pause();
        return;
      }
      stop();
      _updateValue(data);
      play(data.data);
      return;
    }
    if(stateAudio.value == PlayerState.PAUSED)
    {
      if(currentAudio!.value.id == data.id)
      {
        resume();
        return;
      }
      _updateValue(data);
      play(data.data);
      return;
    }
    _updateValue(data);
    play(data.data);


  }
  var stateAudio = Rx<PlayerState>(PlayerState.STOPPED);
  void getStateAudio ()
  {
    _audioPlayersRepo.getStateAudio().listen((event) {
      stateAudio.value = event;
    });
  }
  bool isLastItem()
  {
    if(indexCurrent == getValueListSongModel.length-1){
      return true;
    }
    return false;

  }
  bool isFirstItem()
  {
    if(indexCurrent == 0)
      {
        return true;
      }
    return false;
  }
  void sinSeekToNext()
  {

    indexCurrent = isLastItem() ? 0 :indexCurrent+1;
    final data = getValueListSongModel[indexCurrent];
    playOrPause(data, indexCurrent);

  }
  void sinSeekToPrevious()
  {
    indexCurrent = isFirstItem()? getValueListSongModel.length-1 : indexCurrent-1;
    print(indexCurrent);
    final data = getValueListSongModel[indexCurrent];
    playOrPause(data, indexCurrent);
  }
  void searchInListAudio(String query)async
  {
    List<SongModel> _resultSearch = [];
    List<SongModel> allAudio=await getAllSung();
    if(query.isEmpty)
      {
        _setValueListSongModel =allAudio;
        return;
      }
        for (var element in allAudio) {
          if(element.title.contains(query) )
          {
            _resultSearch.add(element);
          }
        }
        _setValueListSongModel =_resultSearch;

  }

  void addOrRemoveToPlayList({required AudioModel data,
    required int index})async
  {
    final liked = await statusIsLike(data.id!);

    if(liked.value == true)
      {
       removeFromFavoriteList(data.id!);
       Utils.instance.showSuccess(message: 'Item Removed',
       icon: Icons.favorite_border);
       data.isAddToFavorite?.value = false;
       return;
      }
    _audioRoomRep.addTo(RoomType.FAVORITES, data.toMap().toFavoritesEntity());
  //  await fromFavorites(data.id);
    data.isAddToFavorite!.value = true;
    Utils.instance.showSuccess(message: 'Item add To Favorites');
  }

  void removeFromFavoriteList(int id)
  {
    _audioRoomRep.deleteFrom(RoomType.FAVORITES,
        id);
  }


}
