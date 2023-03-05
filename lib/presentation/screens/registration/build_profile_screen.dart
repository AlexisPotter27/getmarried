import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/helper/storage_helper.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/about_you_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/ambitious.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/athletic.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/attractive.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/body_type.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/children_concent_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/creativity.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/drinking_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/drugs.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/education_status_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/ethnic_group.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/height_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/interest.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/monogamy.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/outgoing.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/partners_body_type.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/partners_ethnicity.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/partners_height.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/partners_religion.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/planning_event.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/polotical_leanings.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/relationship.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/religion_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/smoking_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/star_sign_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/starting_and_finishing.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/understanding.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/work_out.dart';

class BuildProfileScreen extends StatefulWidget {
  const BuildProfileScreen({Key? key}) : super(key: key);

  @override
  State<BuildProfileScreen> createState() => _BuildProfileScreenState();
}

class _BuildProfileScreenState extends State<BuildProfileScreen> {
  final _pageController = PageController();
  double progress = 0.09;
  UserData? userData = getIt.get<CacheCubit>().user;
  AuthBloc authBloc = getIt.get<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Image.asset(
          'assets/ilogo.png',
          width: 50,
          height: 50,
        )),
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigoAccent,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is UpdateUserLoadingState) {
            showAnimatedProgressDialog(context);
          }
          if (state is UpdateUserSuccessState) {
            updateCache();
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const HomeScreen(),
            //     ));
          }
          if (state is UpdateUserFailureState) {
            Navigator.pop(context);
            showCustomToast(state.error);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  LinearProgressIndicator(
                    minHeight: 5,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.black),
                    backgroundColor: Colors.black.withOpacity(0.3),
                    value: progress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      InterestScreen(
                        onComplete: (interests) {
                          userData?.interests = interests;
                          switchPage(1);
                        },
                      ),
                      HeightScreen(
                        onComplete: (height) {
                          if (height != null) {
                            userData?.height = height;
                          }
                          userData?.height = null;
                          switchPage(2);
                        },
                        onPrev: () {
                          prevPage(0);
                        },
                      ),
                      PartnersHeight(onPrev: () {
                        prevPage(1);
                      }, onComplete: (height) {
                        userData?.idealPartnerHeight = height;
                        switchPage(3);
                      }),
                      WorkoutScreen(onPrev: () {
                        prevPage(2);
                      }, onComplete: (workout) {
                        userData?.workout = workout;
                        switchPage(4);
                      }),
                      Athletic(onPrev: () {
                        prevPage(3);
                      }, onComplete: (athletic) {
                        userData?.athletic = athletic;
                        switchPage(5);
                      }),
                      BodyType(onPrev: () {
                        prevPage(4);
                      }, onComplete: (bodyType) {
                        userData?.bodyType = bodyType;
                        switchPage(6);
                      }),
                      PartnersBodyType(onPrev: () {
                        prevPage(5);
                      }, onComplete: (pBodyType) {
                        userData?.partnerBodyType = pBodyType;
                        switchPage(7);
                      }),
                      Attractive(onPrev: () {
                        prevPage(6);
                      }, onComplete: (attractive) {
                        userData?.partnerAttractiveness = attractive;
                        switchPage(8);
                      }),
                      StarSignScreen(onPrev: () {
                        prevPage(7);
                      }, onComplete: (starSign) {
                        userData?.starSign = starSign;
                        switchPage(9);
                      }),
                      EducationStatus(onPrev: () {
                        prevPage(8);
                      }, onComplete: (education) {
                        userData?.education = education;
                        switchPage(10);
                      }),
                      DrinkingScreen(onPrev: () {
                        prevPage(9);
                      }, onComplete: (drinking) {
                        switchPage(11);
                      }),
                      SmokingScreen(onPrev: () {
                        prevPage(10);
                      }, onComplete: (smoking) {
                        userData?.smoking = smoking;
                        switchPage(12);
                      }),
                      DrugsScreen(onPrev: () {
                        prevPage(11);
                      }, onComplete: (drugs) {
                        userData?.drugs = drugs;
                        switchPage(13);
                      }),
                      ChildrenConsentScreen(onPrev: () {
                        prevPage(12);
                      }, onComplete: (children) {
                        userData?.children = children;
                        switchPage(14);
                      }),
                      ReligionScreen(onPrev: () {
                        prevPage(13);
                      }, onComplete: (religion) {
                        userData?.religion = religion;
                        switchPage(15);
                      }),
                      PartnersReligion(onPrev: () {
                        prevPage(14);
                      }, onComplete: (pReligion) {
                        userData?.partnerReligion = pReligion;
                        switchPage(16);
                      }),
                      PoliticalLeaningsscreen(onPrev: () {
                        prevPage(15);
                      }, onComplete: (politics) {
                        userData?.political = politics;
                        switchPage(17);
                      }),
                      EthnicGroup(onPrev: () {
                        prevPage(16);
                      }, onComplete: (ethnicGroup) {
                        userData?.ethnicity = ethnicGroup;
                        switchPage(18);
                      }),
                      PartnersEthnicity(onPrev: () {
                        prevPage(17);
                      }, onComplete: (pEthnicity) {
                        userData?.partnerEthnicity = pEthnicity;
                        switchPage(19);
                      }),
                      PlanningEvent(onPrev: () {
                        prevPage(18);
                      }, onComplete: (eventType) {
                        switchPage(20);
                        userData?.potentialEvent = eventType;
                      }),
                      Understanding(onPrev: () {
                        prevPage(19);
                      }, onComplete: (understanding) {
                        userData?.understanding = understanding;
                        switchPage(21);
                      }),
                      Outgoing(onPrev: () {
                        prevPage(20);
                      }, onComplete: (outgoing) {
                        userData?.outgoing = outgoing;
                        switchPage(22);
                      }),
                      Ambitious(onPrev: () {
                        prevPage(21);
                      }, onComplete: (ambitious) {
                        userData?.ambitious = ambitious;
                        switchPage(23);
                      }),

                      // Athletic(onPrev: () {
                      //   prevPage(22);
                      // }, onComplete: () {
                      //   switchPage(24);
                      // }),

                      StartingAndFinishing(onPrev: () {
                        prevPage(22);
                      }, onComplete: (startingFinishing) {
                        userData?.startingAndFinishing = startingFinishing;
                        switchPage(24);
                      }),
                      Relationship(onPrev: () {
                        prevPage(23);
                      }, onComplete: (relationShip) {
                        userData?.sexInRelationship = relationShip;
                        switchPage(25);
                      }),
                      Monogamy(onPrev: () {
                        prevPage(24);
                      }, onComplete: (monogamy) {
                        userData?.monogamy = monogamy;
                        switchPage(26);
                      }),
                      Creativity(onPrev: () {
                        prevPage(25);
                      }, onComplete: (creativity) {
                        userData?.creativity = creativity;
                        switchPage(27);
                      }),
                      AboutYouScreen(onPrev: () {
                        prevPage(26);
                      }, onComplete: (about) {
                        userData?.about = about;
                        authBloc.add(UpdateUserEvent(userData!));
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const WelcomeScreen(),
                        // ));
                      })
                    ],
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void switchPage(int to) {
    setState(() {
      _pageController.jumpToPage(to);
      progress += 0.036;
    });
  }

  void prevPage(int to) {
    setState(() {
      _pageController.jumpToPage(to);
      progress -= 0.036;
    });
  }

  void updateCache() {
    StorageHelper.setString(StorageKeys.regStatus, '2');
  }
}
