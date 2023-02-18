import 'package:flutter/material.dart';

import 'file_upload_sheet.dart';

class ImagePickeCard extends StatefulWidget {
  const ImagePickeCard({Key? key}) : super(key: key);

  @override
  State<ImagePickeCard> createState() => _ImagePickeCardState();
}

class _ImagePickeCardState extends State<ImagePickeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => const FileUploadSheet(),
        );
      },
      child: Container(


        decoration:  BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
