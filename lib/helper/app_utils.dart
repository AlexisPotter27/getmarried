import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomToast(String msg, [Color? bgColor, Color? textColor]) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor ?? Colors.black,
        textColor: textColor ?? Colors.white,
        fontSize: 16);

void showAnimatedProgressDialog(BuildContext context, {String? title}) {
  showGeneralDialog(
    useRootNavigator: false,
    context: context,
    barrierDismissible: false,
    barrierLabel: 'label',
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) => Dialog(
      backgroundColor: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Colors.blueGrey,
                ),
                const SizedBox(width: 30),
                Flexible(
                  child: Text(
                    title ?? 'Please wait...',
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim),
        child: child,
      );
    },
  );
}
