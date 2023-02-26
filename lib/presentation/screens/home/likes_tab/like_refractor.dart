import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/widgets/likes/liker_item.dart';

class LikeRefractor extends StatefulWidget {
  const LikeRefractor({Key? key}) : super(key: key);

  @override
  State<LikeRefractor> createState() => _LikeRefractorState();
}

class _LikeRefractorState extends State<LikeRefractor> {
  int _currendIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColour,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 25,
                  )),
              elevation: 0,
              backgroundColor: primaryColour,
              pinned: true,
              floating: true,

              bottom: AppBar(
                backgroundColor: Colors.white,

                elevation: 0,
                title:  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currendIndex = 0;
                          });
                        },
                        child: Chip(
                          label: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'All 3',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: _currendIndex == 0
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          backgroundColor: _currendIndex == 0
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currendIndex = 1;
                          });
                        },
                        child: Chip(
                          label: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'New 1',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: _currendIndex == 1
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          backgroundColor: _currendIndex == 1
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currendIndex = 2;
                          });
                        },
                        child: Chip(
                          label: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Nearby',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: _currendIndex == 2
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          backgroundColor: _currendIndex == 2
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currendIndex = 3;
                          });
                        },
                        child: Chip(
                          label: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Recently active',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: _currendIndex == 3
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          backgroundColor: _currendIndex == 3
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
              actions: [
                GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.tune,
                        color: Colors.grey,
                        size: 25,
                      ),
                    )),
              ],
              expandedHeight: 350,
              collapsedHeight: 60,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 36,
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
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
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
                  )),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(16)
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [

                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => const LikerItem(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.80,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                      ),
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
