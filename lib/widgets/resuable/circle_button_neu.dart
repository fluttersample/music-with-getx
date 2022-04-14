
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CircleButtonNeu extends StatelessWidget {
  final double depth;
  final void Function() onPress;
  final Widget child;
  final Color? color;
  // final NeumorphicBoxShape shape;


  const CircleButtonNeu({
    Key? key,
    required this.onPress,
    required this.child,
    this.depth=4,
    this.color

      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: NeumorphicButton(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          color: color,
          boxShape: const NeumorphicBoxShape.circle(),
          depth: depth,
          lightSource: LightSource.topLeft,
        ),
        onPressed: onPress,
        child: child
      ),
    );
  }
}

