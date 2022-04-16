



import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

abstract class AudioQueryRepo{


  Future<List<SongModel>> getAllSong();

  Future<bool> requestPermission();

  Future<bool> permissionStatus();

  Future<Uint8List?>  getArtWork(int id ,
      [ArtworkType type =ArtworkType.AUDIO]);
}