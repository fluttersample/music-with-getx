import 'package:flutter/material.dart';

class AnimatedShowUp extends StatefulWidget {
  const AnimatedShowUp({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AnimatedShowUp> createState() => _AnimatedShowUpState();
}

class _AnimatedShowUpState extends State<AnimatedShowUp>
    with SingleTickerProviderStateMixin{
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: const
        Duration(milliseconds:200));
    final curve =
    CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.10), end: Offset.zero)
            .animate(curve);

    _animController.forward();

  }
  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
