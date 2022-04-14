


import 'package:music_player_getx/repository/audio_query/AudioQueryRepo.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioQueryImp extends AudioQueryRepo
{
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Future<List<SongModel>> getAllSong() async{
    return await _audioQuery.querySongs(
        sortType: SongSortType.DATE_ADDED,
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


}
