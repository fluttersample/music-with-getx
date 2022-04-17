
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:music_player_getx/widgets/resuable/circle_button_neu.dart';

class AppbarWidget extends StatelessWidget
    implements PreferredSize{
  final String text;
  final bool centerTitle;
  final double elevation;
  final bool showLeftBtn;
  final bool showRightBtn;
  final IconData iconLeft;
  final IconData iconRight;
  final void Function()? onPressLeftBtn;
  final void Function()? onPressRightBtn;
  const AppbarWidget(
  {Key? key,
  required this.text,
  this.centerTitle=true,
  this.elevation =1,
  this.showLeftBtn=true,
  this.showRightBtn=true,
  this.iconLeft = Icons.filter_list_alt,
  this.iconRight = Icons.favorite,
  this.onPressRightBtn,
  this.onPressLeftBtn,
  })

      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return   Material(
      elevation: elevation,
      color: theme.primaryColor,
      child: SizedBox(
        height: 90,

        child: Container(
          margin: EdgeInsets.only(left: 12,
          right: 15,top: MediaQuery.of(context).padding.top),
          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [

              showLeftBtn?CircleButtonNeu(
                  onPress: onPressLeftBtn!,
                  child: Icon(
                    iconLeft,
                    size: 20,
                    color: Colors.grey.shade800,
                  ),) : SizedBox(
                height: 45,
                    width: 45,
                    child: CircleButtonNeu(
                    onPress: () {

                    },
                    child:  PopupMenuButton(
                      onSelected: (index){
                        print(index);
                      },
                      initialValue: 0,

                      itemBuilder: (context) => [
                        PopupMenuItem(child: Row(
                          children: [
                            Icon(Icons.vertical_align_bottom_sharp),
                            Text('Vertical')
                          ],
                        )),
                        PopupMenuItem(child: Row(
                          children: [
                            Icon(Icons.horizontal_split_sharp),
                            Text('Horizontal')
                          ],
                        )),
                      ],)),
                  ),

              const Spacer(),
              Text(text,
              style: Theme.of(context).textTheme.headline5!.
              copyWith(
                fontFamily: 'WetPaint',
                color: theme.primaryColorLight
              )),
              const Spacer(),
              if(showRightBtn)
              CircleButtonNeu(
                  onPress: onPressRightBtn!,
                  child: Icon(
                    iconRight,
                    size: 18,
                    color: Colors.grey.shade800,
                  ),)


            ],
          ),
        ),

      ),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const
  Size(double.infinity, 80);
}
