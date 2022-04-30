


import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/presentation/controller/PlayListController.dart';
import 'package:music_player_getx/widgets/error_widget.dart';
import 'package:music_player_getx/widgets/not_found_data_widget.dart';
import 'package:music_player_getx/widgets/null_art_work.dart';
import 'package:music_player_getx/widgets/resuable/animated_switcher_icon.dart';
import 'package:music_player_getx/widgets/resuable/appbar_widget.dart';
import 'package:music_player_getx/widgets/resuable/circle_button_neu.dart';
import 'package:music_player_getx/widgets/resuable/current_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlayListView extends GetView<PlayListController>
{
  const PlayListView({Key? key}) : super(key: key);
  static const String id ='/playList';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder(
      init: controller,
      builder: (controller) =>
      Scaffold(
        appBar: const AppbarWidget(
          text: 'Favorite',
          height: 70,
          showRightBtn: false,
          showLeftBtn: false,
          elevation: 0,
        ),
        bottomSheet: _buildBottomSheet(theme),
        body: _buildBody(),
      ),);
  }


  Widget _buildBody()
  {

    return FutureBuilder<List<FavoritesEntity>>(
      future: controller.getFavorites,
      builder: (context, item)
    {
      if (item.data == null) return const CircularProgressIndicator();
      if (item.data!.isEmpty) {
        return const Center(child: NotFoundDataWidget());
      }
      return ListView.builder(
        itemCount: controller.listFavorites.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10
        ),
        itemBuilder: (context, index) {
          final data = controller.listFavorites[index];
          return _buildItem(data,context,index);
        },
      );

    }
    );
  }
  Widget _buildItem(FavoritesEntity item,BuildContext context,int index)
  {

    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 15),
      child: Neumorphic(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: QueryArtworkWidget(
                  id: item.id,
                  nullArtworkWidget: const NullArtWorkWidget(),
                  type: ArtworkType.AUDIO),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                  style: context.theme.textTheme.button,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
                  Text(item.displayName!,
                      style: context.theme.textTheme.caption,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ],
              ),
            ),
           const SizedBox(
             width: 8,
           ),
           CircleButtonNeu(
             onPress: (){
               //controller.playOrPause(item, index);
             },
             child: AnimatedSwitcherIcon(
                 icFalse: Icons.play_arrow,
                 icTrue: Icons.pause,
                 condition: false)
           )
          ],
        ),
      ),
    );
  }
  Widget _buildBottomSheet(ThemeData theme) {
    return StreamBuilder<FavoritesEntity?>(
      stream: controller.currentAudio?.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return CurrentAudioWidget(
              dataFav: data!,
              seekToPrevious: (){controller.sinSeekToPrevious();},
              seekToNext: (){controller.sinSeekToNext();},
              widget: Obx(() => AnimatedSwitcherIcon(
                  icFalse: Icons.play_arrow,
                  colorFalseButton: theme.colorScheme.surface,
                  colorTrueButton: theme.colorScheme.surface,
                  icTrue: Icons.pause,
                  condition: controller.isPlayNow(data.id))),
              playOrPause: (){
                controller.playOrPause(data,controller.indexCurrent);
              });
        }
        return const SizedBox();
      },
    );

  }

}