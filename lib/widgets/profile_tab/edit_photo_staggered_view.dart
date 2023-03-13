import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getmarried/widgets/profile_tab/add_profile_photo_box.dart';

class EditPhotoStaggeredView extends StatefulWidget {
  const EditPhotoStaggeredView(
      {Key? key, required this.photos, required this.onImageSelected})
      : super(key: key);
  final List photos;
  final Function(String?) onImageSelected;

  @override
  State<EditPhotoStaggeredView> createState() => _EditPhotoStaggeredViewState();
}

class _EditPhotoStaggeredViewState extends State<EditPhotoStaggeredView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView.custom(
        semanticChildCount: 1,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.same,
          pattern: [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => AddProfilePhotoBox(
                  photo: getPhoto(index),
                  onImageSelected: widget.onImageSelected,
                ),
            childCount: 6),
      ),
    );
  }

  String? getPhoto(int index) {
    if (widget.photos.length >= index + 1) {
      return widget.photos[index];
    }

    return null;
  }
}
