import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nasa_app/core/resources/app_colors.dart';

void showFlutterToast(String masg) {
  Fluttertoast.showToast(
    msg: masg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.primaryColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
