

import 'package:flutter/material.dart';

class NotFoundDataWidget extends StatelessWidget {
  final String title;
   const NotFoundDataWidget(
      {Key? key,
       this.title='Not Found Data'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(title,
        style: Theme.of(context).textTheme.headline5,) );
  }
}
