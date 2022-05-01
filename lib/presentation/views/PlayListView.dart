


import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/models/AudioModel.dart';
import 'package:music_player_getx/presentation/controller/PlayListController.dart';
import 'package:music_player_getx/widgets/not_found_data_widget.dart';
import 'package:music_player_getx/widgets/null_art_work.dart';
import 'package:music_player_getx/widgets/resuable/animated_switcher_icon.dart';
import 'package:music_player_getx/widgets/resuable/appbar_widget.dart';
import 'package:music_player_getx/widgets/resuable/circle_button_neu.dart';
import 'package:music_player_getx/widgets/resuable/current_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

        body: _buildBody(),
      ),);
  }


  Widget _buildBody()
  {

    return FutureBuilder<List<AudioModel>>(
      future: controller.getFavorites,
      builder: (context, item)
    {
      if (item.data == null) return const CircularProgressIndicator();
      if (item.data!.isEmpty) {
        return const Center(child: NotFoundDataWidget());
      }
      return ListView.builder(
        itemCount: controller.listFavorites.length,
        padding: const EdgeInsets.only(
          right: 15,
          left: 15,
          bottom: 80,
          top: 10
        ),
        itemBuilder: (context, index) {
          final data = controller.listFavorites[index];
          return _buildItem(data,context,index,item.data);
        },
      );

    }
    );
  }
  Widget _buildItem(AudioModel item,BuildContext context,int index,
      List<AudioModel>? data)
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
                  id: item.id!,
                  nullArtworkWidget: const NullArtWorkWidget(),
                  type: ArtworkType.AUDIO),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title!,
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
               controller.homeController.audioModel?.value = data!;
               controller.homeController.playOrPause(item, index);
             },
             child:  Obx(
               () => AnimatedSwitcherIcon(
                   icFalse: Icons.play_arrow,
                   icTrue: Icons.pause,
                   condition: controller.homeController.isPlayNow(item.id!)),
             )
           )
          ],
        ),
      ),
    );
  }


}