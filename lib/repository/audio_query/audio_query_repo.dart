



import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

abstract class AudioQueryRepo{


  Future<List<SongModel>> getAllSong();

  Future<bool> requestPermission();

  Future<bool> permissionStatus();

  Future<Uint8List?>  getArtWork(int id ,
      [ArtworkType type =ArtworkType.AUDIO]);

  Future<List<dynamic>> getSongWithFilter(String textSearch);

  Future<List<SongModel>> getSongWithWhere(Object where);

  Future<bool> addToPlayList(int playListId , int audioId);

  Future<bool> removeToPlayList(int playListId , int audioId);

  Future<List<PlaylistModel>> getPlayList();

  Future createPlayList();


}