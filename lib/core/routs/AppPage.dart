

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/presentation/bindings/PlayListBindig.dart';
import 'package:music_player_getx/presentation/bindings/home_binding.dart';
import 'package:music_player_getx/presentation/bindings/splash_binding.dart';
import 'package:music_player_getx/presentation/views/HomeView.dart';
import 'package:music_player_getx/presentation/views/PlayListView.dart';
import 'package:music_player_getx/presentation/views/SplashView.dart';

class AppPage {


  static final routes = [
    GetPage(
        name: HomeView.id,
        page:()=> const HomeView(),
      binding: HomeBinding(),
      title: 'Music Player',
        transition: Transition.fade

    ),
    GetPage(
        name: SplashView.id,
        page: ()=>const SplashView(),
     binding: SplashBinding(),
        transition: Transition.fade

    ) ,
    GetPage(
        name: PlayListView.id,
      page: ()=>const PlayListView(),
     binding: PlayListBinding(),
        transition: Transition.fade
    )

  ];
}