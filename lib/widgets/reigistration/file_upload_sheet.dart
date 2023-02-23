import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/image_picker_card.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FileUploadSheet extends StatefulWidget {
  String? imagePath;
  FileUploadSheet({Key? key}) : super(key: key);

  @override
  State<FileUploadSheet> createState() => _FileUploadSheetState();
}

class _FileUploadSheetState extends State<FileUploadSheet> {
  //XFile? imageFile;
  String image = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /*//Facebook Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: const [
                  Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Facebook')
                ],
              ),
            ),
          ),
          const Divider(),

          //Instagram Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: const [
                  Icon(
                    Icons.whatsapp,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Instagram')
                ],
              ),
            ),
          ),*/
          const Divider(),

          // Gallery Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                pickImage();
                Navigator.pop(context);
                setState(() {});
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.photo_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Upload photo')
                ],
              ),
            ),
          ),
          const Divider(),

          // Camera Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                _getFromCamera();
                Navigator.of(context).pop();

              },
              child: Row(
                children: const [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Take photo')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get image from Gallery
  ///
  void pickImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = file.path;
      print('Image:: $image');
      //setState(() {});
    }
  }

  /// Get image from Camera
  void pickImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = file.path;
      print('Image:: $image');
      //setState(() {});
    }
  }
  _getFromCamera() async {
    PickedFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    )) as PickedFile?;
    if (pickedFile != null) {
      setState(() {
        //imageFile = File(pickedFile.path) as XFile?;
      });
    }
  }
}
