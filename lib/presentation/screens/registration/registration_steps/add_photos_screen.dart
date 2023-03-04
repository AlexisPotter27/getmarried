import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';
import 'package:getmarried/widgets/reigistration/not_sure_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../widgets/reigistration/file_upload_sheet.dart';

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({Key? key, required this.onComplete, required this.onPrev}) : super(key: key);
  final Function onComplete;
  final Function onPrev;

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
  static String image = '';

  static void pickImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = file.path;
      print('Image:: $image');
      //setState(() {});
    }
  }

  /// Get image from Camera
  static void pickImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = file.path;
      print('Image:: $image');
      //setState(() {});
    }
  }
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add your first 2 photos ?',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '2 photos are better than 1, its our science. You can change this later.',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const Text(
                'You can add more pictures later.',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 150,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => FileUploadSheet(),
                        );
                      },
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 400,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Center(
                            child: (AddPhotosScreen.image != null)
                                ? Image.file(io.File(AddPhotosScreen.image))
                                : const Icon(Icons.add),
                          ),
                          // ImagePickerCard(),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 16,
                    ),
                    //Expanded(child: ImagePickerCard()),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              //facebook
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Add from Facebook',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              //Instagram
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Add from Instagram',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Image(
                        image: AssetImage(
                          'assets/instagram.png',
                        ),
                        width: 20,
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NextButton(
                      icon: const Icon(Icons.arrow_back_ios,size: 16,color: Colors.black,),
                      onPressed: () {
                        widget.onPrev();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NextButton(onPressed: () {
                    widget.onComplete();
                  }),
                ),
              ],
            ),
            const NotSureWidget(),
          ],
        )
      ],
    );
  }

  /// Get image from Gallery
  ///

}
