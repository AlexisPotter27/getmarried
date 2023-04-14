import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/screens/home/chat/messaging_screen.dart';
import 'package:getmarried/widgets/home/about_chip.dart';
import 'package:getmarried/widgets/secondary_widget.dart';

import '../../di/injector.dart';
import '../../presentation/blocs/cache_cubit/cache_cubit.dart';
import '../primary_button.dart';

class MatchCard extends StatefulWidget {
  const MatchCard({Key? key, required this.user}) : super(key: key);

  // final String image;
  final UserData user;

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  // final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // _controller.addListener(() {
    //   // _controller.position.
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.indigo.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height - 170,
                          width: deviceWidth(),
                          decoration: BoxDecoration(
                              color: primaryColour,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.user.photos!.isNotEmpty
                                          ? widget.user.photos![0]
                                          : ''),
                                  fit: BoxFit.cover)
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.transparent,
                                  Colors.black26,
                                  Colors.black38,
                                  Colors.black45,
                                  Colors.black.withOpacity(0.7),
                                ],
                                    end: Alignment.bottomCenter,
                                    begin: Alignment.topCenter)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Icons.format_quote_outlined,
                                      color: Colors.white,
                                    ),
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.black26,
                                      child: Icon(
                                        Icons.file_upload_outlined,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.user.firstname!} ${widget.user.age}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.school_outlined,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.user.education ?? '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'About me',
                                style: TextStyle(color: Colors.black45),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.user.about ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'My basics',
                                style: TextStyle(color: Colors.black45),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Wrap(
                                spacing: 5,
                                children: List.generate(
                                    1,
                                    (index) => const AboutChip(
                                          label: 'Cool',
                                        )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'My Interest',
                                style: TextStyle(color: Colors.black45),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Wrap(
                                spacing: 5,
                                children: List.generate(
                                    widget.user.interests!.length,
                                    (index) => AboutChip(
                                          label: widget.user.interests![index],
                                        )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'Languages i know',
                                style: TextStyle(color: Colors.black45),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Wrap(
                                spacing: 5,
                                children: List.generate(
                                    1,
                                    (index) => const AboutChip(
                                          label: 'English',
                                        )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.user.photos!.length - 1,
                          itemBuilder: (context, index) => Image.network(
                            widget.user.photos![index + 1],
                            height: 270,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.share_location),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${getIt.get<CacheCubit>().user!.firstname.toString()}'s location",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey.shade200),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "${getIt.get<CacheCubit>().user!.location.toString()}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                            ),
                          ],
                        ),

                        /*const Text(
                          'Owerri, Imo state ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),*/
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: deviceWidth(),
                            // height: 100,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: primaryColour,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: primaryColour,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -60,
                                  child: SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: ClipPolygon(
                                      borderRadius: 8.0,
                                      sides: 6,
                                      child: Container(
                                        color: primaryColour,
                                        child: Container(
                                          color: primaryColour,
                                          child: Image.asset(
                                            'assets/superswipe.png',
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TransaparentButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => ReportWidget(),
                              );
                            },
                            child: const Text(
                              'Hide and Report',
                              style: TextStyle(color: primaryColour),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PrimaryButton(
                      onPressed: () {},
                      child: const Text('Recommend to a friend'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: SizedBox(
              height: 70,
              width: 70,
              child: ClipPolygon(
                borderRadius: 8.0,
                sides: 6,
                child: Container(
                  color: primaryColour,
                  child: Image.asset(
                    'assets/superswipe.png',
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 200);
    path.lineTo(200, 200);
    path.lineTo(260, 0);
    path.lineTo(30, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
