


import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_player_getx/models/audio_model.dart';
import 'package:music_player_getx/widgets/error_widget.dart';
import 'package:music_player_getx/widgets/null_art_work.dart';
import 'package:music_player_getx/widgets/resuable/animated_rotate.dart';
import 'package:music_player_getx/widgets/resuable/animated_show_up.dart';
import 'package:music_player_getx/widgets/resuable/elevation_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
class CurrentAudioWidget extends StatelessWidget {

  final void Function() seekToPrevious;
  final void Function() seekToNext;
  final void Function() playOrPause;
  final AudioModel? data;
  final Widget widget;
  final bool stopAnim;
  final AnimationController controllerRotate;
  const CurrentAudioWidget({
    Key? key,
    this.data,
    required this.seekToPrevious,
    required this.widget,
    required this.seekToNext,
    required this.playOrPause,
    required this.stopAnim,
    required this.controllerRotate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Material(
      color: Colors.white,
      child: AnimatedShowUp(
        child: Padding(
          padding: const EdgeInsets.only(
              right: 8.0,
              left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedRotateWidget(
                stopAnimation: stopAnim,
                controller: controllerRotate,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: QueryArtworkWidget(
                    id: data!.id!,
                    artworkFit: BoxFit.cover,
                    type: ArtworkType.AUDIO,
                    keepOldArtwork: false,
                    nullArtworkWidget: const NullArtWorkWidget(),
                    ),),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data!.title!,
                      style: theme.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data!.displayName!,
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
