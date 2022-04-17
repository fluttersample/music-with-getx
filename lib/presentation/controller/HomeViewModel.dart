



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



  List<SongModel> listSongsModel = [];
  int indexCurrent =0;


  Future<List<SongModel>> getAllSung()async{
   await _audioQueryRepo.requestPermission();
    listSongsModel =await _audioQueryRepo.getAllSong();
    return listSongsModel;
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
    if(StateAudio.value == PlayerState.PLAYING &&
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
    if(StateAudio.value == PlayerState.PLAYING)
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
    if(StateAudio.value == PlayerState.PAUSED)
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
  var StateAudio = Rx<PlayerState>(PlayerState.STOPPED);
  void getStateAudio ()
  {
    _audioPlayersRepo.getStateAudio().listen((event) {
      StateAudio.value = event;
    });
  }
  void sinSeekToNext()
  {
    indexCurrent = indexCurrent+1;
    print(indexCurrent);
    final data = listSongsModel[indexCurrent];
    playOrPause(data, indexCurrent);

  }
  void sinSeekToPrevious()
  {
    indexCurrent = indexCurrent-1;
    print(indexCurrent);
    final data = listSongsModel[indexCurrent];
    playOrPause(data, indexCurrent);
  }



}
