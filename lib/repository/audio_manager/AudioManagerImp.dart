

import 'package:just_audio/just_audio.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';

class AudioManagerImp extends AudioManagerRepo
{

  final AudioPlayer _audioPlayer = AudioPlayer();



  @override
  Future<void> pauseAudio() async{
    print(_audioPlayer.duration);
    return await _audioPlayer.pause();
  }

  @override
  Future<void> resumeAudio() async{
    return await _audioPlayer.play();
  }

  @override
  Future<void> seekAudio({required Duration duration}) async{
    return await _audioPlayer.seek(duration);
  }

  @override
  Future<void> stopAudio() async{
    return await _audioPlayer.stop();
  }

  @override
  Stream<PlayerState> getStateAudio() {

    return _audioPlayer.playerStateStream;
  }

  @override
  Future<Duration?> startAudio( List<ProgressiveAudioSource> urls)
  async {
    return await _audioPlayer.setAudioSource(
        LoopingAudioSource(
            count: 2,
            child: ConcatenatingAudioSource(
              children: urls,
            )
        )
    );
  }

  @override
  Future<void> playAudio() async{
    return await _audioPlayer.play();
  }

}