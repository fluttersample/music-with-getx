

import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Rx<SongModel>? currentAudio = SongModel({}).obs ;
  Rx<PlayerState> currentState = Rx<PlayerState>(PlayerState.STOPPED) ;
  void _listenToStateAudio (){
    _audioManagerRepo.getStateAudio().listen((event) {
      print(event.toString() );
      currentState.value = event;
    });
  }
  Future<List<SongModel>> getAllSung()async{
   await _audioQueryRepo.requestPermission();
    final result =await _audioQueryRepo.getAllSong();
    return result;
  }
  bool playNow(int id){
    if(currentState.value == PlayerState.PLAYING && currentAudio?.value.id ==id)
    {
      return true;
    }
    return false;
  }


  void playOrPauseAudio(int id)
  {
    print(id);
    print(currentAudio?.value.id);
    if(currentState.value == PlayerState.PLAYING )
      {
        if( currentAudio?.value.id == id)
          {
            _pauseAudio();
            return;
          }
        _stopAudio();
        return;
      }
    if(currentState.value == PlayerState.PAUSED &&
        currentAudio?.value.id == id)
      {
        _resumeAudio();
        return;
      }
    _startAudio();

  }
  void _stopAudio()
  {
    _audioManagerRepo.stopAudio();
  }
  void _startAudio()
  {

    _audioManagerRepo.startAudio(
      url: currentAudio!.value.data,
    );
  }
  void _pauseAudio()
  {
    _audioManagerRepo.pauseAudio();
  }
  void _resumeAudio()
  {
    _audioManagerRepo.resumeAudio();
  }

//   Future<String> _getUrlCover ()async{
//       final result = await _audioQueryRepo.getArtWork(39);
// //      print(String.fromCharCodes(result!));
//
//
//        return String.fromCharCodes(result!);
//
//
//   }


}
