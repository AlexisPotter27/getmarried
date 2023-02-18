import 'package:flutter/material.dart';

class FileUploadSheet extends StatefulWidget {
  const FileUploadSheet({Key? key}) : super(key: key);

  @override
  State<FileUploadSheet> createState() => _FileUploadSheetState();
}

class _FileUploadSheetState extends State<FileUploadSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        ],
      ),
    );
  }
}
