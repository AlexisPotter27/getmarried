import 'package:flutter/material.dart';
import 'dart:io';
import '../../presentation/screens/registration/registration_steps/add_photos_screen.dart';

class FileUploadSheet extends StatefulWidget {
  String? imagePath;
  FileUploadSheet({Key? key}) : super(key: key);

  @override
  State<FileUploadSheet> createState() => _FileUploadSheetState();
}

class _FileUploadSheetState extends State<FileUploadSheet> {
  //XFile? imageFile;

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
                AddPhotosScreen.pickImage();
                Navigator.of(context).pop();
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
                AddPhotosScreen.pickImageFromCamera();
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
}