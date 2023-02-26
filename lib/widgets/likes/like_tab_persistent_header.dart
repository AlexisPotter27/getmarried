import 'package:flutter/material.dart';

class LikeTabPersistentHeader extends SliverPersistentHeaderDelegate {
  final double _maxExtent = 350;


  LikeTabPersistentHeader();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    debugPrint(shrinkOffset.toString());
    // log((-((deviceWidth() / 2))).toString());
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 25,
                    )),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 40,
                      width: 50,
                    ),
                    const Text(
                      'Get Married',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.tune,
                      color: Colors.black,
                      size: 25,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          const Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'See who liked you with 50% off',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            '3 people already liked you.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(

            padding:
            const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: const [
                Text(
                  'Upgrade for.',
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Text(
                  '3,950.00 NGN',
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Chip(
            label: const Text('Offer ends in 4:51:00'),
            backgroundColor: Colors.indigo.shade400,

          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxExtent;


  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant LikeTabPersistentHeader oldDelegate) {
    return oldDelegate != this;
  }
}