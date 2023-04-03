import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage{

  static void showToast(String msg) => Fluttertoast.showToast(
      msg: msg,
      fontSize: 18,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.black
  );

  string(){
    String photo = 'ABS';
    String ma = photo;
  }
}
