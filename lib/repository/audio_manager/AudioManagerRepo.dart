




import 'package:just_audio/just_audio.dart';

abstract class AudioManagerRepo {

  Future<Duration?> startAudio(
  List<ProgressiveAudioSource> urls
  );

  Future<void> pauseAudio();
  Future<void> playAudio();

  Future<void> stopAudio();

  Future<void> resumeAudio();

    Future<void> seekAudio({
    required Duration duration,
  });

    Stream<PlayerState> getStateAudio ();


}