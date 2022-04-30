

import 'package:flutter/material.dart';

class NotFoundDataWidget extends StatelessWidget {
  final String title;
   const NotFoundDataWidget(
      {Key? key,
       this.title='Not Found Data'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/images/no_image.png',
            height: 300,),
          Text(title,
          style: Theme.of(context).textTheme.headline6,),
        ],
      ),
    );
  }
}
