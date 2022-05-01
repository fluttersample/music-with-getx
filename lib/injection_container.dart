import 'package:get_it/get_it.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerImp.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';
import 'package:music_player_getx/repository/audio_players/audio_players_imp.dart';
import 'package:music_player_getx/repository/audio_players/audio_players_repo.dart';
import 'package:music_player_getx/repository/audio_query/audio_query_imp.dart';
import 'package:music_player_getx/repository/audio_query/audio_query_repo.dart';
import 'package:music_player_getx/repository/audio_room/audio_room_imp.dart';
import 'package:music_player_getx/repository/audio_room/audio_room_repo.dart';



 final sl = GetIt.instance;

Future<void> init() async {


  /// Repository
  sl.registerLazySingleton<AudioQueryRepo>(
    () => AudioQueryImp());

  sl.registerLazySingleton<AudioPlayersRepo>(() => AudioPlayersImp());

  sl.registerLazySingleton<AudioRoomRep>(() => AudioRoomImp());

}
