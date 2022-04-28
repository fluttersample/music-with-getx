import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/models/AudioModel.dart';
import 'package:music_player_getx/presentation/controller/HomeViewModel.dart';
import 'package:music_player_getx/presentation/views/PlayListView.dart';
import 'package:music_player_getx/utils/Utils.dart';
import 'package:music_player_getx/widgets/error_widget.dart';
import 'package:music_player_getx/widgets/loading_widget.dart';
import 'package:music_player_getx/widgets/not_found_data_widget.dart';
import 'package:music_player_getx/widgets/resuable/animated_show_up.dart';
import 'package:music_player_getx/widgets/resuable/animated_switcher_icon.dart';
import 'package:music_player_getx/widgets/resuable/appbar_widget.dart';
import 'package:music_player_getx/widgets/resuable/current_audio.dart';
import 'package:music_player_getx/widgets/resuable/elevation_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);
  static const String id = '/home_view';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder(
      init: controller,
      builder: (_) => Scaffold(
          appBar: AppbarWidget(
            text: 'Evo Music',

            onPressLeftBtn: () {
              print(controller.currentAudio?.value.getMap);
              Utils.instance.showButtonSheet(
                onTapItem0: (){},
                onTapItem1: (){}
              );
            },
            onPressRightBtn: () {

              Get.toNamed(PlayListView.id);
            //  print(controller.currentAudio!.value.getMap);
            },
          ),
          bottomSheet: _buildBottomSheet(theme),
          body: Column(
            children: [_buildSearchWidget(), _buildBody(theme)],
          )),
    );
  }
  Widget _buildSearchWidget() {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      style: const NeumorphicStyle(
        color: Colors.white,
        boxShape: NeumorphicBoxShape.stadium(),
        depth: 1,
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
      child: SizedBox(
        height: 30,
        child: TextField(
          controller: controller.searchController,
          decoration: const InputDecoration(
              hintText: "search music",
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  )),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.none,
                ),
              )),
          onChanged: controller.searchInListAudio,

        ),
      ),
    );

  }

  Widget _buildBottomSheet(ThemeData theme) {
    return StreamBuilder<SongModel>(
      stream: controller.currentAudio?.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return CurrentAudioWidget(
              data: data!,
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


  Widget _buildBody(ThemeData theme) {
    return Expanded(
      child: FutureBuilder<List<SongModel>>(
        future: controller.getAllSung(),
        builder: (context, AsyncSnapshot<List<SongModel>> snp) {
          if (snp.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snp.hasError) {
            return const MyErrorWidget();
          }
          if (!snp.hasData) {
            return const NotFoundDataWidget();
          }
          return Obx(
            () {
              if(controller.audioModel!.isEmpty)
                {
                  return const NotFoundDataWidget();
                }
              return GridView.builder(
              physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6)
                +const EdgeInsets.only(bottom: 50),
                itemCount: controller.getValueListSongModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) {

                  final data = controller.audioModel![index];
                  final dataSongModel = controller.getValueListSongModel[index];
                  return _buildItemMusic(
                    data: data,
                    index: index,
                    theme: theme,
                    dataSongModel: dataSongModel

                  );
                });
            },
          );
        },
      ),
    );
  }

  Widget _buildItemMusic({
    required AudioModel data,
    required ThemeData theme,
    required int index,
    required SongModel dataSongModel
   }) {


    return GestureDetector(
      onTap: () => print(data.id),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Neumorphic(
              style: const NeumorphicStyle(depth: 4, intensity: 0.8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  QueryArtworkWidget(
                    id: data.id!,
                    artworkFit: BoxFit.fill,
                    artworkBorder: BorderRadius.circular(0),
                    type: ArtworkType.AUDIO,
                      errorBuilder: (_,ob,st){
                        return const MyErrorWidget();
                      },
                    nullArtworkWidget: Container(
                      color: theme.primaryColorLight.withOpacity(0.5),
                        child: MyErrorWidget(size: 45,)),
                  ),
                  _buildPlaySound(dataSongModel,index),

                  _buildBtnPlayList(
                    index: index,
                    data: data
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title!,
                  style: theme.textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  data.displayName!,
                  style: theme.textTheme.subtitle2!.copyWith(color: Colors.grey).
                  copyWith(
                    fontSize: 12
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildPlaySound(SongModel data,int index) {
    return Positioned(
      bottom: 15,
      right: 12,
      child: InkWell(
        onTap: (){
          controller.playOrPause(data,index);

        },
        child: Container(
          height: 35,
          width: 35,

          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Obx(() => AnimatedSwitcherIcon(
                  icFalse: Icons.play_arrow,
                  icTrue: Icons.pause,
                  condition: controller.isPlayNow(data.id)),
          ),

        ),
      ),
    );
  }

  Widget _buildBtnPlayList({
    required AudioModel data,
    required int index,
  })
  {
    return Positioned(
      left: 0,
      top: 0,
      child: IconButton(
        splashRadius: 15,
          iconSize: 15,
          onPressed: (){
           controller.addOrRemoveToPlayList(
             data: data,
             index: index,
           );
          },
           icon: Obx(
                 () {
               if(data.isAddToFavorite!.value)
               {
                 return const Icon(Icons.favorite,
                   color: Colors.red,
                 );
               }
               return const Icon(Icons.favorite_border,
                 color: Colors.white,
               );
             },
           )
           //const Icon(Icons.favorite_border,
          //   color: Colors.white,
          // )

      ),
    );
  }

}


