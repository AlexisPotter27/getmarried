import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/widgets/home/matched_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

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

Future<String?> pickImage() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (file != null) {
    dev.log(file.path);
    return file.path;
//setState(() {});
  }
  return null;
}

Future<String?> pickImageFromCamera() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
  if (file != null) {
    dev.log(file.path);
    return file.path;
//setState(() {});
  }
  return null;
}

void showConfirmDialog(BuildContext context,
    {String? tittle,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onDismiss,
    VoidCallback? onConfirm}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(tittle ?? 'Are you sure you want to exit ?'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
// foregroundColor: Colors.transparent
                    ),
                    onPressed: onDismiss ??
                        () {
                          Navigator.pop(context);
                        },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    )),
                const SizedBox(),
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
// foregroundColor: Colors.transparent
                    ),
                    onPressed: onConfirm ??
                        () {
                          Navigator.pop(context);
                        },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.indigo),
                    )),
              ],
            )
          ],
        )),
  );
}

//  selectFiles(BuildContext context, Function(List<String>) onSelected,
//     {bool allowMultiple = false,
//       bool hasViewAction = false,
//       String? title,
//       FileType? fileType,
//       List<String>? allowedExtensions,
//       VoidCallback? onViewAction}) async {
//   await showMaterialModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//       ),
//       backgroundColor: AppColors.smokeWhite,
//       builder: (context) {
//         return Container(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             shrinkWrap: true,
//             children: <Widget>[
//               InkWell(
//                 child: Container(
//                     padding: const EdgeInsets.all(16),
//                     color: AppColors.white,
//                     child: const Text('Take a photo',
//                         textAlign: TextAlign.center)),
//                 onTap: () {
//                   Navigator.pop(context);
//                   fetchImageFromCamera().then((value) {
//                     if (null != value) {
//                       return onSelected([value]);
//                     }
//                   });
//                 },
//               ),
//               const SizedBox(height: 1),
//               InkWell(
//                 child: Container(
//                     padding: const EdgeInsets.all(16),
//                     color: AppColors.white,
//                     child: const Text('Select from Gallery',
//                         textAlign: TextAlign.center)),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   var list = await fetchFiles(
//                       allowMultiple: allowMultiple,
//                       fileType: fileType ?? FileType.image,
//                       title: title,
//                       allowedExtensions: allowedExtensions);
//                   onSelected(list);
//                 },
//               ),
//               if (hasViewAction)
//                 Column(
//                   children: [
//                     const SizedBox(height: 1),
//                     InkWell(
//                       child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.all(16),
//                           color: AppColors.white,
//                           child: const Text('View Photo',
//                               textAlign: TextAlign.center)),
//                       onTap: () {
//                         Navigator.pop(context);
//                         if (onViewAction != null && hasViewAction) {
//                           onViewAction();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: 16),
//               InkWell(
//                 child: Container(
//                     padding: const EdgeInsets.all(16),
//                     color: AppColors.white,
//                     child: const Text('Cancel', textAlign: TextAlign.center)),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // _openCamera();
//                 },
//               ),
//             ],
//           ),
//         );
//       });
// }
//
//  Future<List<Map<String, String?>>> fetchVideos(
// {bool allowMultiple = false}) async {
// try {
// FilePicker filePicker = FilePicker.platform;
// FilePickerResult? result = await filePicker.pickFiles(
// type: FileType.video,
// allowCompression: true,
//
// allowMultiple: allowMultiple,
// // allowedExtensions: ['mp4'],
// );
// if (result != null) {
// return result.files
//     .map((file) => {'path': file.path, 'size': file.size.toString()})
//     .toList();
// } else {
// return [];
// }
// } catch (e) {
// return [];
// }
// }
//
// static Future<List<PlatformFile>> fetchMedia(
// {bool allowMultiple = false,
// Function(FilePickerResult? result)? onSelect}) async {
// try {
// FilePicker filePicker = FilePicker.platform;
// FilePickerResult? result = await filePicker.pickFiles(
// type: FileType.custom,
// allowCompression: true,
// allowMultiple: allowMultiple,
// allowedExtensions: [
// 'mp4',
// 'mov',
// 'jpg',
// 'jpeg',
// 'png',
// 'pdf',
// 'doc',
// 'docx'
// ],
// );
// //     .then((value) {
// //   onSelect!(value);
// //   return null;
// // });
// if (result != null) {
// return result.files;
// } else {
// return [];
// }
// } catch (e) {
// return [];
// }
// }

void showMatchedDialog(BuildContext context, final UserData swipedUser,
    final UserData loggedInUser) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => MatchedDialog(
      swipedUser: swipedUser,
      loggedInUser: loggedInUser,
    ),
  );
}

Future<void> launchUrlLink(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $_url.');
  }
}

Future<void> getAddressFromLatLng(Position position) async {
  UserData? cachedUser = getIt.get<CacheCubit>().user;
  List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  print(placemark);
  Placemark place = placemark[0];
  cachedUser?.location = place.locality;
  getIt.get<CacheCubit>().updateUser(cachedUser!);
}

void requestForLocation() async {
  Position position = await _determinePosition();
  print(position.latitude);

  getAddressFromLatLng(position);
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location Service are disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
