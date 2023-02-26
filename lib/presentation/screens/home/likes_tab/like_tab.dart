import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/widgets/likes/liker_item.dart';

class LikeTab extends StatefulWidget {
  const LikeTab({Key? key}) : super(key: key);

  @override
  State<LikeTab> createState() => _LikeTabState();
}

class _LikeTabState extends State<LikeTab> {
  int _currendIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              decoration: const BoxDecoration(color: primaryColour),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 25,
                            )),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/ilogo.png',
                              height: 40,
                              width: 50,
                            ),
                            /*const Text(
                              'Get Married',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),*/
                          ],
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '3 people already liked you.',
                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
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
                              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        Text(
                          '8.59 USD',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Chip(
                    label: Text('Offer ends in 4:51:00'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _currendIndex = 0;
                            });
                          },
                          child: Chip(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'All 3',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: _currendIndex == 1
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                            backgroundColor: _currendIndex == 0
                                ? Colors.black
                                : Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _currendIndex = 1;
                            });
                          },
                          child: Chip(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                : Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _currendIndex = 2;
                            });
                          },
                          child: Chip(

                            label: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                : Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _currendIndex = 3;
                            });
                          },
                          child: Chip(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                : Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => const LikerItem(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.80,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
