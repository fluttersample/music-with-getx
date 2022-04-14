


import 'package:audio_manager/audio_manager.dart';
import 'package:music_player_getx/repository/audio_manager/AudioManagerRepo.dart';

class AudioManagerImp extends AudioManagerRepo
{
  final audio = AudioManager.instance;

  @override
  Future startAudio({
    required String url,
    required String title,
    required String desc,
    required String urlCover}) async{

    await audio.start(
        url,
        title,
        desc: desc,
        cover: urlCover).then((value) {
          print(value);
    });

  }

}