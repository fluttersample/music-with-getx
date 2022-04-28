
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class Utils {

  Utils._();

  static final Utils instance = Utils._();

  parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }

   void showSuccess({required String message,
   IconData icon= Icons.favorite}) {
    Get.rawSnackbar(
      duration: const Duration(milliseconds:1000 ),
      padding: const EdgeInsets.only(
        top: 8,bottom: 8
      ),
      margin: const EdgeInsets.only(right: 8,left: 8,
      bottom: 8),
      borderRadius: 15,
      animationDuration: const Duration(milliseconds: 500),
      icon:  Icon(
         icon,
          color: Colors.red),
      message: message,

      backgroundColor: Colors.black.withOpacity(0.8),
    );
  }

   void showButtonSheet({ Function()? onTapItem0,Function()? onTapItem1 })
  {
    Get.bottomSheet(
      Builder(
        builder: (context) =>  SizedBox(
          height: 150,
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 5,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).disabledColor,

                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
              onTap: onTapItem0,
                leading: Icon(Icons.list),
                minLeadingWidth: 0,
                iconColor: Theme.of(context).primaryColorLight,
                title: Text('Vertical List',
                ),

                style: ListTileStyle.drawer,

              ),
              ListTile(
                onTap: onTapItem1,
                minLeadingWidth: 0,
                leading: Icon(Icons.grid_view,
                size: 21),
                iconColor: Theme.of(context).primaryColorLight,

                style: ListTileStyle.drawer,
                title: Text('Grid List'),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.
          only(topRight: Radius.circular(15),
        topLeft: Radius.circular(15))
      )
    );
  }


}