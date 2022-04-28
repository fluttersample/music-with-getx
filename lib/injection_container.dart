import 'package:get_it/get_it.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerImp.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';
import 'package:music_player_getx/repository/audio_players/AudioPlayersImp.dart';
import 'package:music_player_getx/repository/audio_players/AudioPlayersRepo.dart';
import 'package:music_player_getx/repository/audio_query/AudioQueryImp.dart';
import 'package:music_player_getx/repository/audio_query/AudioQueryRepo.dart';
import 'package:music_player_getx/repository/audio_room/AudioRoomImp.dart';
import 'package:music_player_getx/repository/audio_room/AudioRoomRep.dart';



 final sl = GetIt.instance;

Future<void> init() async {


  /// Repository
  sl.registerLazySingleton<AudioQueryRepo>(
    () => AudioQueryImp());

  sl.registerLazySingleton<AudioPlayersRepo>(() => AudioPlayersImp());

  sl.registerLazySingleton<AudioRoomRep>(() => AudioRoomImp());

}
