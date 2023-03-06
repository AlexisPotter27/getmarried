import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/file_upload_sheet.dart';

import 'dart:io' as io;

class ImagePickerCard extends StatefulWidget {
  ImagePickerCard({Key? key}) : super(key: key);

  @override
  _ImagePickerCardState createState() => _ImagePickerCardState();
  String? imageF;
}

class _ImagePickerCardState extends State<ImagePickerCard> {
  String? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) =>  FileUploadSheet(onImageSelected: (String? path) {  },),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: (image != null)
              ? Image.file(io.File(image!))
              : const Icon(Icons.add),
        ),
      ),
    );
  }
}
