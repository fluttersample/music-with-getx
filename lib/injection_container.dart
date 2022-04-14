import 'package:get_it/get_it.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerImp.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';
import 'package:music_player_getx/repository/audio_query/AudioQueryImp.dart';
import 'package:music_player_getx/repository/audio_query/AudioQueryRepo.dart';



 final sl = GetIt.instance;

Future<void> init() async {


  /// Repository
  sl.registerLazySingleton<AudioManagerRepo>(
    () => AudioManagerImp());

  sl.registerLazySingleton<AudioQueryRepo>(
    () => AudioQueryImp());


  // Use cases
  // sl.registerLazySingleton(() => WeatherUseCase(wikiRepository: sl()));
  //
  // // Repository
  // sl.registerLazySingleton<WikiRepository>(
  //   () => WikiRepositoryImpl(
  //     wikiRemoteDataSource: sl(),
  //   ),
  // );
  //
  // sl.registerLazySingleton<IWeatherUseCase>(
  //   () => WeatherUseCase(
  //     wikiRepository: sl(),
  //   ),
  // );
  //
  // // Data sources
  // sl.registerLazySingleton<WikiRemoteDataSource>(
  //   () => WikiRemoteDataSourceImpl(),
  // );
}
