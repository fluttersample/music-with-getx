

import 'package:flutter/material.dart';
import 'package:music_player_getx/core/GetController/GetController.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';
import 'package:music_player_getx/repository/audio_query/AudioQueryRepo.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeViewModel extends GetController {

  final AudioQueryRepo audioQueryRepo;
  final AudioManagerRepo audioManagerRepo;

  HomeViewModel({required this.audioManagerRepo,
    required this.audioQueryRepo});

  final searchController = TextEditingController();

  Future<List<SongModel>> getAllSung()async{
   await audioQueryRepo.requestPermission();

    final result =await audioQueryRepo.getAllSong();


    return result;
  }


}
