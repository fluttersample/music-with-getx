


import 'package:audioplayers/audioplayers.dart';
import 'package:music_player_getx/repository/audio_players/AudioPlayersRepo.dart';

class AudioPlayersImp extends AudioPlayersRepo
{

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<int> startAudio({required String url}) async{
    return await _audioPlayer.play(url);
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
    Future<int> stopAudio() async{
    return await _audioPlayer.stop();
    }

    @override
    Stream<PlayerState> getStateAudio() {
    return _audioPlayer.onPlayerStateChanged;
    }


}