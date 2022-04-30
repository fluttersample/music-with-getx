


import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_player_getx/models/AudioModel.dart';
import 'package:music_player_getx/widgets/error_widget.dart';
import 'package:music_player_getx/widgets/null_art_work.dart';
import 'package:music_player_getx/widgets/resuable/animated_show_up.dart';
import 'package:music_player_getx/widgets/resuable/animated_switcher_icon.dart';
import 'package:music_player_getx/widgets/resuable/elevation_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
class CurrentAudioWidget<T> extends StatelessWidget {

  final void Function() seekToPrevious;
  final void Function() seekToNext;
  final void Function() playOrPause;
  final AudioModel? data;
  final FavoritesEntity? dataFav;
  final Widget widget;
  const CurrentAudioWidget({
    Key? key,
    this.dataFav,
    this.data,
    required this.seekToPrevious,
    required this.widget,
    required this.seekToNext,
    required this.playOrPause}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  AnimatedShowUp(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 8.0,
              left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: QueryArtworkWidget(
                  id: data?.id ?? dataFav!.id,
                  artworkFit: BoxFit.cover,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const NullArtWorkWidget(),
                  errorBuilder: (_,ob,st){
                    return const MyErrorWidget();
                  },),),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data?.title?? dataFav!.title,
                      style: theme.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data?.displayName ?? dataFav!.displayName!,
                      style: theme.textTheme.subtitle2!.copyWith(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              ElevationButtonWidget(
                  onPress: seekToPrevious,
                  widget: const Icon(
                      Icons.skip_previous_sharp
                  )),

              ElevationButtonWidget(
                color: theme.primaryColorLight,
                onPress: playOrPause,
                widget: widget,
                ),

              ElevationButtonWidget(
                  onPress: seekToNext,
                  widget: const Icon(
                      Icons.skip_next_sharp
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
