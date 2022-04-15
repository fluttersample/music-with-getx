

import 'package:flutter/material.dart';
class AnimatedSwitcherIcon extends StatelessWidget {
  final IconData icTrue;
  final IconData icFalse;
  final bool condition;
  final int duration;
  const AnimatedSwitcherIcon({
    Key? key,
  required this.icFalse,
  required this.icTrue,
  this.condition=false,
  this.duration = 300}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: duration),
    transitionBuilder: (widget , anim) {
      return RotationTransition(
          turns: widget.key == const ValueKey('i1') ?
          Tween<double>(begin: 0.75 , end: 1).animate(anim) :
          Tween<double>(begin: 0.75, end: 1).animate(anim),
          child: ScaleTransition(
            scale: anim,
            child: widget,
          ),
      );
    },
      child: condition? Icon(icTrue,
      key: const ValueKey('i1'),) : Icon(icFalse,
      key: const ValueKey('i2')),
    );
  }
}
