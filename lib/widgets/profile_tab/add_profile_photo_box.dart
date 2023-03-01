import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/file_upload_sheet.dart';

class AddProfilePhotoBox extends StatefulWidget {
  const AddProfilePhotoBox({Key? key, this.height, this.margin})
      : super(key: key);
  final double? height;
  final EdgeInsetsGeometry? margin;

  @override
  State<AddProfilePhotoBox> createState() => _AddProfilePhotoBoxState();
}

class _AddProfilePhotoBoxState extends State<AddProfilePhotoBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context, builder: (context) =>  FileUploadSheet(),);
      },
      child: Container(
        height: widget.height ?? 104,
        margin: widget.margin,
        decoration: BoxDecoration(
            color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
