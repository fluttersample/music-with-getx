
import 'package:flutter/material.dart';
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

  static void showSuccess({required String message}) {
    Get.rawSnackbar(
      title: 'Success',
      icon: const Icon(Icons.thumb_up, color: Colors.white),
      message: message,
      backgroundColor: Colors.green.shade600,
    );
  }


}