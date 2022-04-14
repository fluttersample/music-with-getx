



import 'package:on_audio_query/on_audio_query.dart';

abstract class AudioQueryRepo{


  Future<List<SongModel>> getAllSong();

  Future<bool> requestPermission();
}