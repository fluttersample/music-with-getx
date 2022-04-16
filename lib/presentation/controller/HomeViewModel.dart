


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';
import 'package:music_player_getx/repository/audio_query/AudioQueryRepo.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeViewModel extends GetxController {
  final AudioQueryRepo _audioQueryRepo;
  final AudioManagerRepo _audioManagerRepo;

  HomeViewModel({required AudioManagerRepo audioManagerRepo,
                required AudioQueryRepo audioQueryRepo}) :
  _audioManagerRepo = audioManagerRepo , _audioQueryRepo = audioQueryRepo;

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _listenToStateAudio();
  }

  Rx<SongModel>? currentAudio = SongModel({}).obs;
  Rx<PlayerState> currentState = Rx<PlayerState>(PlayerState(
    false,ProcessingState.idle
  ));
  List<ProgressiveAudioSource> listSongs = [];
  void _listenToStateAudio (){
    _audioManagerRepo.getStateAudio().listen((event) {
      print(event.toString());
      currentState.value = PlayerState(event.playing,
          event.processingState);

    });
  }
  Future<List<SongModel>> getAllSung()async{
   await _audioQueryRepo.requestPermission();
    final result =await _audioQueryRepo.getAllSong();
    return result;
  }
  bool playNow(int id){
    if(currentState.value.playing && currentAudio?.value.id ==id)
    {
      return true;
    }
    return false;
  }


  void playOrPauseAudio(SongModel data)
  {
    if(currentState.value.playing )
      {

        if( currentAudio?.value.id == data.id)
          {
            _pauseAudio();
            return;
          }
        _stopAudio();
        _updateValue(data);
        //_startAudio();
        _playAudio();
        return;
      }
    if(currentState.value.processingState
    ==ProcessingState.ready
        &&
        currentAudio?.value.id == data.id)
      {
        print("SDADADADADADADADADADADA");
        _resumeAudio();
        return;
      }

    _updateValue(data);
   _startAudio();
    _playAudio();

  }
  void _updateValue(SongModel value)
  {
    currentAudio?.value = value;
  }
  void _stopAudio()
  {
    _audioManagerRepo.stopAudio();
  }
  void _startAudio()
  {
    print("DSAAAAAAAAAAAAAAA");
    _audioManagerRepo.startAudio(listSongs);
  }
  void _pauseAudio()
  {
    _audioManagerRepo.pauseAudio();
  }
  void _resumeAudio()
  {
    _audioManagerRepo.resumeAudio();
  }

  void _playAudio()
  {
    _audioManagerRepo.playAudio();
  }



}
