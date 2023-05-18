import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getmarried/constants/constant.dart';

class AppPromptWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final VoidCallback? onTap;
  final String? imagePath;
  final bool? isSvgResource;
  final bool? canTryAgain;
  final String? buttonText;

  const AppPromptWidget(
      {Key? key,
      this.message = 'Oops an error occured',
      this.title,
      this.onTap,
      this.imagePath,
      this.isSvgResource = false,
      this.canTryAgain = true,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

            isSvgResource!
                ? SvgPicture.asset(
                    imagePath ?? 'assets/svgs/server_error.svg',
                    width: 150,
                  )
                : Image.asset(
                   imagePath?? 'assets/sorry.png',
                    height: 150,
                  ),

          if (title != null)
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          if (message != null)
            Column(
              children: [
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.blueGrey),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          if (canTryAgain!)
            Column(
              children: [
                OutlinedButton(
                    onPressed: onTap,

                    style: OutlinedButton.styleFrom(

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        side:
                            BorderSide(color: primaryColour)),
                    child: Text(
                      buttonText ?? "Try again",
                      style: TextStyle(color: primaryColour,)
                    )),
              ],
            )
        ],
      )),
    );
  }
}
