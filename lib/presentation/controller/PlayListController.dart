

import 'package:get/get.dart';
import 'package:music_player_getx/repository/audio_room/AudioRoomRep.dart';
import 'package:on_audio_room/on_audio_room.dart';


class PlayListController extends GetxController
{
  final AudioRoomRep _audioRoomRep;
  PlayListController({
    required AudioRoomRep audioRoomRep}) : _audioRoomRep = audioRoomRep;


  Future<List<FavoritesEntity>> get getFavorites async=>
      await _audioRoomRep.queryFavorites();







}