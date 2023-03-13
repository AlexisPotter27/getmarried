// import 'package:flutter/material.dart';
// import 'package:getmarried/widgets/profile_tab/add_profile_photo_box.dart';
// import 'package:getmarried/widgets/reigistration/file_upload_sheet.dart';
//
// class PhotosWidget extends StatefulWidget {
//   const PhotosWidget({Key? key, required this.photos}) : super(key: key);
//   final List photos;
//
//   @override
//   State<PhotosWidget> createState() => _PhotosWidgetState();
// }
//
// class _PhotosWidgetState extends State<PhotosWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                     backgroundColor: Colors.transparent,
//                     context: context,
//                     builder: (context) => FileUploadSheet(
//                       onImageSelected: (String? path) {},
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: 220,
//                   margin: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(16)),
//                   child: widget.photos.isNotEmpty
//                       ? Image.network(
//                           widget.photos[0],
//                           height: 220,
//                         )
//                       : const Center(
//                           child: Icon(Icons.add),
//                         ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: AddProfilePhotoBox(
//                       margin: const EdgeInsets.all(2.5),
//                       photo:
//                           widget.photos.length >= 4 ? widget.photos[3] : null,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child: AddProfilePhotoBox(
//                       margin: const EdgeInsets.all(2.5),
//                       photo:
//                           widget.photos.length >= 5 ? widget.photos[4] : null,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.all(2.5),
//           width: MediaQuery.of(context).size.width / 3 - 16,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               AddProfilePhotoBox(
//                 photo: widget.photos.length >= 2 ? widget.photos[1] : null,
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               AddProfilePhotoBox(
//                 photo: widget.photos.length >= 3 ? widget.photos[2] : null,
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               AddProfilePhotoBox(
//                 photo: widget.photos.length >= 7 ? widget.photos[6] : null,
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
