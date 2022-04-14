
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/presentation/controller/HomeViewModel.dart';
import 'package:music_player_getx/widgets/error_widget.dart';
import 'package:music_player_getx/widgets/not_found_data_widget.dart';
import 'package:music_player_getx/widgets/resuable/appbar_widget.dart';
import 'package:music_player_getx/widgets/resuable/circle_button_neu.dart';
import 'package:on_audio_query/on_audio_query.dart';



class HomeView extends GetView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);
  static const String id = '/home_view';


  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    return GetBuilder(
      init: controller,
      builder: (controller) =>  Scaffold(
        appBar:  AppbarWidget(
          text: 'Evo Music',
          onPressLeftBtn: (){
            print('');
          },
          onPressRightBtn: (){
            print("SAD");
          },
        ),
        body: Column(
          children: [
            _buildSearchWidget(context),
            _buildBody(theme)

          ],
        )
      ),
    );
  }

  Widget _buildBody(ThemeData theme)
  {

    return Expanded(
      child: FutureBuilder<List<SongModel>>(
        future: controller.getAllSung(),
          builder: (context, AsyncSnapshot<List<SongModel>> snp) {
            print(snp.data?.length);
            if(snp.hasError)
              {
                return const
                MyErrorWidget(textError:
                'Error Data');
              }
            if(!snp.hasData || snp.data!.isEmpty)
              {
                return const NotFoundDataWidget();
              }
            return GridView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12
                ),
                itemCount: snp.data?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1/1.3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12
                ),
                itemBuilder: (context , index){
                  final model = snp.data![index];
                  return _buildItemMusic(model,theme);
                });
          },),
    );
  }
  Widget _buildItemMusic(SongModel data, ThemeData theme){
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1/1,
          child: Neumorphic(
            style: const NeumorphicStyle(
                depth: 4,
                intensity: 0.8
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                QueryArtworkWidget(
                  id: data.id,
                  artworkFit: BoxFit.fill,
                  artworkBorder: BorderRadius.circular(0),
                  type: ArtworkType.AUDIO,
                ),
                _buildPlaySound()
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title,
              style: theme.textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,),
              Text(data.displayName,
                style: theme.textTheme.subtitle2!.copyWith(
                    color: Colors.grey
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,)
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildSearchWidget(BuildContext context){
    return  Neumorphic(
      margin: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25
      ),

      style:  NeumorphicStyle(color: Colors.white,
        boxShape: const NeumorphicBoxShape.stadium(),
        depth: NeumorphicTheme.embossDepth(context),

      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
      child: SizedBox(
        height: 35,
        child:  TextField(
          controller: controller.searchController,
          decoration: const InputDecoration(
              hintText: "Search Music",
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.none,
                ),
              )

          ),
        ),
      ),
    );
  }

  Widget _buildPlaySound()
  {
    return Positioned(
      bottom: 15,
      right: 4,
      child: CircleButtonNeu(
        color: Colors.white,
          onPress: (){

          },
          child: Center(child:
          Icon(Icons.play_arrow,
          ),),
      depth: 0,),
    );
  }
}
