


import 'dart:typed_data';

import 'package:music_player_getx/repository/audio_query/AudioQueryRepo.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioQueryImp extends AudioQueryRepo
{
  final OnAudioQuery _audioQuery = OnAudioQuery();


  @override
  Future<List<SongModel>> getAllSong() async{

    return await _audioQuery.querySongs(
        sortType: SongSortType.DISPLAY_NAME,
    ).onError((error, stackTrace) {
      print(error.toString());
      throw error.toString();
    });
  }

  @override
  Future<bool> requestPermission() async{
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
     return await _audioQuery.permissionsRequest();
    }

    return permissionStatus;

  }

  @override
  Future<Uint8List?> getArtWork(int id, [ArtworkType type = ArtworkType.AUDIO])
  async{
    final result = await _audioQuery.queryArtwork(id, type);
    return result;
  }






}
