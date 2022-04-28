
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
  final double height;
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
  this.height=90,
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
        height: height,

        child: Container(
          margin: EdgeInsets.only(left: 12,
          right: 15,top: MediaQuery.of(context).padding.top),
          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [

              Visibility(
                visible: showLeftBtn,
                child: CircleButtonNeu(
                    onPress: onPressLeftBtn,
                    child: Icon(
                      iconLeft,
                      size: 20,
                      color: Colors.grey.shade800,
                    ),),
              ),

              const Spacer(),
              Text(text,
              style: Theme.of(context).textTheme.headline5!.
              copyWith(
                fontFamily: 'WetPaint',
                color: theme.primaryColorLight
              )),
              const Spacer(),

              Visibility(
                visible: showRightBtn,
                child: CircleButtonNeu(
                    onPress: onPressRightBtn,
                    child: Icon(
                      iconRight,
                      size: 18,
                      color: Colors.grey.shade800,
                    ),),
              )


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
