/*import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';*/

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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
    log(file.path);
    return file.path;
//setState(() {});
  }
  return null;
}
/*static selectFiles(BuildContext context, Function(List<String>) onSelected,
    {bool allowMultiple = false,
      bool hasViewAction = false,
      String? title,
      FileType? fileType,
      List<String>? allowedExtensions,*/
    /*  VoidCallback? onViewAction}) async {
  await showMaterialModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      backgroundColor: AppColors.smokeWhite,
      builder: (context) {
        return Container(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.white,
                    child: const Text('Take a photo',
                        textAlign: TextAlign.center)),
                onTap: () {
                  Navigator.pop(context);
                  fetchImageFromCamera().then((value) {
                    if (null != value) {
                      return onSelected([value]);
                    }
                  });
                },
              ),
              const SizedBox(height: 1),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.white,
                    child: const Text('Select from Gallery',
                        textAlign: TextAlign.center)),
                onTap: () async {
                  Navigator.pop(context);
                  var list = await fetchFiles(
                      allowMultiple: allowMultiple,
                      fileType: fileType ?? FileType.image,
                      title: title,
                      allowedExtensions: allowedExtensions);
                  onSelected(list);
                },
              ),
              if (hasViewAction)
                Column(
                  children: [
                    const SizedBox(height: 1),
                    InkWell(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          color: AppColors.white,
                          child: const Text('View Photo',
                              textAlign: TextAlign.center)),
                      onTap: () {
                        Navigator.pop(context);
                        if (onViewAction != null && hasViewAction) {
                          onViewAction();
                        }
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.white,
                    child: const Text('Cancel', textAlign: TextAlign.center)),
                onTap: () {
                  Navigator.pop(context);
                  // _openCamera();
                },
              ),
            ],
          ),
        );
      });
}*/

Future<String?> pickImageFromCamera() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
  if (file != null) {
    log(file.path);
    return file.path;
//setState(() {});
  }
  return null;

/*static Future<List<Map<String, String?>>> fetchVideos(
{bool allowMultiple = false}) async {
try {
FilePicker filePicker = FilePicker.platform;
FilePickerResult? result = await filePicker.pickFiles(
type: FileType.video,
allowCompression: true,

allowMultiple: allowMultiple,
// allowedExtensions: ['mp4'],
);
if (result != null) {
return result.files
    .map((file) => {'path': file.path, 'size': file.size.toString()})
    .toList();
} else {
return [];
}
} catch (e) {
return [];
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
}*/


/*
static Future<List<PlatformFile>> fetchMedia(
{bool allowMultiple = false,
Function(FilePickerResult? result)? onSelect}) async {
try {
FilePicker filePicker = FilePicker.platform;
FilePickerResult? result = await filePicker.pickFiles(
type: FileType.custom,
allowCompression: true,
allowMultiple: allowMultiple,
allowedExtensions: [
'mp4',
'mov',
'jpg',
'jpeg',
'png',
'pdf',
'doc',
'docx'
],
);
//     .then((value) {
//   onSelect!(value);
//   return null;
// });
if (result != null) {
return result.files;
} else {
return [];
}
} catch (e) {
return [];
}
}*/
