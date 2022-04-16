


import 'package:audioplayers/audioplayers.dart';

abstract class AudioManagerRepo {

  Future<int> startAudio({
    required String url,
  });

  Future<int> pauseAudio();
  Future<int> stopAudio();
  Future<int> resumeAudio();
    Future<int> seekAudio({
    required Duration duration,
  });

    Stream<PlayerState> getStateAudio ();


}