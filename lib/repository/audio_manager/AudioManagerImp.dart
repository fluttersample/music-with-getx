


import 'package:audioplayers/audioplayers.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';

class AudioManagerImp extends AudioManagerRepo
{
  final AudioPlayer _audioPlayer = AudioPlayer();
  var stateAudio = PlayerState.STOPPED;

  @override
  Future<int> startAudio({
    required String url,}) async{
   return await _audioPlayer.play(
        url,
       isLocal: true
         );
  }

  @override
  Future<int> pauseAudio() async{
    return await _audioPlayer.pause();
  }

  @override
  Future<int> resumeAudio() async{


    return await _audioPlayer.resume();
  }

  @override
  Future<int> seekAudio({required Duration duration}) async{
    return await _audioPlayer.seek(duration);
  }

  @override
  Future<int> stopAudio() async{
    return await _audioPlayer.stop();
  }

  @override
  Stream<PlayerState> getStateAudio() {

    return _audioPlayer.onPlayerStateChanged;
  }

}