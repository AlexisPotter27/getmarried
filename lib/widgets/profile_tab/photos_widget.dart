import 'package:flutter/material.dart';
import 'package:getmarried/widgets/profile_tab/add_profile_photo_box.dart';
import 'package:getmarried/widgets/reigistration/file_upload_sheet.dart';

class PhotosWidget extends StatefulWidget {
  const PhotosWidget({Key? key}) : super(key: key);

  @override
  State<PhotosWidget> createState() => _PhotosWidgetState();
}

class _PhotosWidgetState extends State<PhotosWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => FileUploadSheet(
                      onImageSelected: (String? path) {},
                    ),
                  );
                },
                child: Container(
                  height: 220,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Center(
                    child: Icon(Icons.add),
                  ),
                ),
              ),
              Row(
                children: const [
                  Expanded(
                    child: AddProfilePhotoBox(
                      margin: EdgeInsets.all(2.5),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: AddProfilePhotoBox(
                      margin: EdgeInsets.all(2.5),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(2.5),
          width: MediaQuery.of(context).size.width / 3 - 16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              AddProfilePhotoBox(),
              SizedBox(
                height: 8,
              ),
              AddProfilePhotoBox(),
              SizedBox(
                height: 8,
              ),
              AddProfilePhotoBox(),
            ],
          ),
        )
      ],
    );
  }
}
