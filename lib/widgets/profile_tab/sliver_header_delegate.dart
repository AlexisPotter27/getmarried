
import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';

class MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _maxExtent = 200;
  final VoidCallback onActionTap;

  MySliverHeaderDelegate({
    required this.onActionTap,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    debugPrint(shrinkOffset.toString());
    // log((-((deviceWidth() / 2))).toString());
    return Container(
      color: Colors.cyanAccent,
      child: Transform.translate(
        offset: Offset(
          -shrinkOffset <= (-(deviceWidth() / 2) + 50)
              ? (-(deviceWidth() / 2) + 50)
              : (shrinkOffset/(-deviceWidth()/2))*(-shrinkOffset),
          0,
        ),
        child: Transform.scale(
          scale: 1,
          child: const CircleAvatar(),
        ),
      ),
    );
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant MySliverHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
