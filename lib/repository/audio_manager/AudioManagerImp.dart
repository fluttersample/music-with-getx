//
//
// import 'package:just_audio/just_audio.dart';
// import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';
//
// class AudioManagerImp extends AudioManagerRepo
// {
//
//   final AudioPlayer _audioPlayer = AudioPlayer();
//
//
//
//   @override
//   Future<void> pauseAudio() async{
//     print('Current Index '+_audioPlayer.currentIndex.toString());
//     print('Next Index '+_audioPlayer.nextIndex.toString());
//     print('Preview Index '+_audioPlayer.previousIndex.toString());
//     print(_audioPlayer.position);
//     return await _audioPlayer.pause();
//   }
//
//
//
//   @override
//   Future<void> seekAudio({Duration duration = Duration.zero,required int index}) async{
//     return await _audioPlayer.seek(duration,index: index);
//   }
//
//   @override
//   Future<void> stopAudio() async{
//
//     return await _audioPlayer.stop();
//   }
//
//   @override
//   Stream<PlayerState> getStateAudio() {
//     return _audioPlayer.playerStateStream;
//   }
//
//   @override
//   Future<Duration?> startAudio( List<AudioSource> urls, int index)
//   async {
//     return await _audioPlayer.setAudioSource(
//       LoopingAudioSource(child:
//       ConcatenatingAudioSource(
//         children: urls,
//
//       ), count: 4),
//
//       initialIndex: index,
//         preload: true
//     );
//   }
//
//   @override
//   Future<void> playAudio() async{
//     return await _audioPlayer.play();
//   }
//
//   @override
//   Future<void> seekToNext() async{
//     return _audioPlayer.seekToNext();
//   }
//
//   @override
//   Future<void> seekToPrevious() {
//     return _audioPlayer.seekToPrevious();
//   }
//
//   @override
//   Duration getPosition() {
//    return _audioPlayer.position;
//   }
//
//   @override
//   int? currentIndex() {
//     return _audioPlayer.currentIndex;
//   }
//
//   @override
//   int? nextIndex() {
//     return _audioPlayer.nextIndex;
//   }
//
//   @override
//   int? previousIndex() {
//     return _audioPlayer.previousIndex;
//   }
//
// }