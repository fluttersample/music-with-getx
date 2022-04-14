import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/core/routs/AppPage.dart';
import 'package:music_player_getx/core/theme/AppThemeDark.dart';
import 'package:music_player_getx/core/theme/AppThemeLight.dart';
import 'package:music_player_getx/injection_container.dart';
import 'package:music_player_getx/presentation/views/SplashView.dart';


void main() {
  init();
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
