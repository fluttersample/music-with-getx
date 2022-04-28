

 import 'package:on_audio_room/on_audio_room.dart';

abstract class AudioRoomRep {


  Future<bool> deleteFrom(RoomType roomType,int entityKey);
  Future<int?> addTo(RoomType roomType, dynamic entity);
  Future<bool> deleteAll(RoomType roomType, List<int> keys);
  Future<bool> checkIn(RoomType roomType,int entityKey);
  Future<List<FavoritesEntity>> queryFavorites();
  Future<FavoritesEntity?> queryFromFavorites(int entityKey);

}