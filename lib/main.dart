import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/core/routs/app_page.dart';
import 'package:music_player_getx/core/theme/app_theme_dark.dart';
import 'package:music_player_getx/core/theme/app_theme_light.dart';
import 'package:music_player_getx/injection_container.dart';
import 'package:music_player_getx/presentation/views/splash_view.dart';
import 'package:on_audio_room/on_audio_room.dart';


void main() async{
  init();
  await OnAudioRoom().initRoom(RoomType.FAVORITES);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Evo Music',
      debugShowCheckedModeBanner: false,
      darkTheme: AppThemeDark.instance.theme,
      theme: AppThemeLight.instance.theme,

      initialRoute: SplashView.id,

      getPages: AppPage.routes,
    );
  }
}
