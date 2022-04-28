


import 'package:music_player_getx/repository/audio_room/AudioRoomRep.dart';
import 'package:on_audio_room/on_audio_room.dart';

class AudioRoomImp extends AudioRoomRep
{

  final _audioRoom =OnAudioRoom();

  @override
  Future<int?> addTo( RoomType roomType, dynamic entity,) async{
    return await _audioRoom.addTo(
        roomType,
        entity);
  }

  @override
  Future<bool> checkIn(RoomType roomType, int entityKey) async{
   return await _audioRoom.checkIn(roomType, entityKey);
  }

  @override
  Future<bool> deleteAll(RoomType roomType, List<int> keys) async{

   return await _audioRoom.deleteAllFrom(roomType, keys);
  }

  @override
  Future<bool> deleteFrom(RoomType roomType, int entityKey) async{
    return await _audioRoom.deleteFrom(roomType, entityKey);
  }

  @override
  Future<List<FavoritesEntity>> queryFavorites() async{
    return await _audioRoom.queryFavorites();
  }

  @override
  Future<FavoritesEntity?> queryFromFavorites(int entityKey) async{
    return await _audioRoom.queryFromFavorites(entityKey);
  }

}