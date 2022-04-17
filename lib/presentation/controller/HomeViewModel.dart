



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_player_getx/repository/audio_players/AudioPlayersRepo.dart';
import 'package:music_player_getx/repository/audio_query/AudioQueryRepo.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart' ;


class HomeViewModel extends GetxController {
  final AudioQueryRepo _audioQueryRepo;
  final AudioPlayersRepo _audioPlayersRepo;
  HomeViewModel({
                required AudioQueryRepo audioQueryRepo,
  required AudioPlayersRepo audioPlayersRepo}) :
    _audioQueryRepo = audioQueryRepo,
  _audioPlayersRepo = audioPlayersRepo;

  final searchController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    getStateAudio();

  }

  Rx<SongModel>? currentAudio = SongModel({}).obs;



  Rx<List<SongModel>> listSongsModel = Rx<List<SongModel>>([]);
  int indexCurrent =0;

  List<SongModel> get getValueListSongModel  =>listSongsModel.value;

   set _setValueListSongModel (List<SongModel> data) =>
       listSongsModel.value = data;

  Future<List<SongModel>> getAllSung()async{
   await _audioQueryRepo.requestPermission();
    _setValueListSongModel =await _audioQueryRepo.getAllSong();
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


  Future<int> playe(String url)async
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
      playe(data.data);
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
      playe(data.data);
      return;
    }
    _updateValue(data);
    playe(data.data);


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
    // if(indexCurrent == listSongsModel.length-1)
    //   {
    //     indexCurrent = 0;
    //     final data = listSongsModel[indexCurrent];
    //     playOrPause(data, indexCurrent);
    //     return;
    //   }

    indexCurrent = isLastItem() ? 0 :indexCurrent+1;
    print('Index rrent : ' + indexCurrent.toString());
    print(getValueListSongModel.length);
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



}
