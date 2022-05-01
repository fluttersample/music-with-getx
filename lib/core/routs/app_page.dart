

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/presentation/bindings/play_list_bindig.dart';
import 'package:music_player_getx/presentation/bindings/home_binding.dart';
import 'package:music_player_getx/presentation/bindings/splash_binding.dart';
import 'package:music_player_getx/presentation/views/home_view.dart';
import 'package:music_player_getx/presentation/views/play_list_view.dart';
import 'package:music_player_getx/presentation/views/splash_view.dart';

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