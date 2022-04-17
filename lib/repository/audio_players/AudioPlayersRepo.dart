
import 'package:audioplayers/audioplayers.dart';

abstract class AudioPlayersRepo{



  Future<int> startAudio({
  required String url,
  });

  Future<int> pauseAudio();
  Future<int> stopAudio();
  Future<int> resumeAudio();

  Stream<PlayerState> getStateAudio ();
}