import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/chip_choice_mode.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/languages_screen.dart';
import 'package:getmarried/widgets/profile_tab/basics_section.dart';
import 'package:getmarried/widgets/profile_tab/connect_account_widget.dart';
import 'package:getmarried/widgets/profile_tab/chips_box.dart';
import 'package:getmarried/widgets/profile_tab/edit_photo_staggered_view.dart';
import 'package:getmarried/widgets/profile_tab/more_about_section.dart';
import 'package:getmarried/widgets/profile_tab/profile_list_tile.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  UserData cachedUser = getIt.get<CacheCubit>().user!;
  AuthBloc authBloc = AuthBloc(getIt.get());

  final bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bioController.text = cachedUser.about ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png',
          height: 40,
          width: 50,
        ),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: BlocListener<CacheCubit, CacheState>(
        bloc: getIt.get<CacheCubit>(),
        listener: (context, state) {
          if (state is ProfileUpdatedState) {
            setState(() {
              cachedUser = state.userData;
            });
          }
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) {
            if (state is UpdateUserSuccessState) {
              Navigator.pop(context);
              showCustomToast('Updated');
              setState(() {
                cachedUser.photos = state.userData.photos;
                getIt.get<CacheCubit>().updateUser(cachedUser);
              });
            }
            if (state is UpdateUserLoadingState) {
              showAnimatedProgressDialog(context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile Strength',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(width: 0.5))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '8% complete',
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey.shade300,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'My photos',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, height: 2),
                    ),
                    const Text(
                      'Pick some that show the true you',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // PhotosWidget(
                    //   photos: cachedUser.photos ?? [],
                    // ),
                    EditPhotoStaggeredView(
                      photos: cachedUser.photos!,
                      onImageSelected: (image) {
                        if (image != null) {
                          Navigator.pop(context);
                          authBloc.add(UpdateUserEvent(cachedUser,
                              images: [XFile(image)]));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ProfileListTile(
                      preffix: const Icon(
                        Icons.image,
                        size: 20,
                      ),
                      tittle: 'Best Photo',
                      value: 'On',
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ProfileListTile(
                      preffix: const Icon(
                        Icons.shield_moon,
                        size: 20,
                        color: Colors.blueAccent,
                      ),
                      tittle: 'Verify my profile',
                      value: 'Verified',
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'My interests',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Get specific about the things you love',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ChipsBox(
                          items: cachedUser.interests!
                              .map((e) => ChipChoiceModel(
                                  label: e.toString(),
                                  icon: Icons.sports_score))
                              .toList(),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    // const Text(
                    //   'Profile prompts',
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                    // const Text(
                    //   'Make your personality stand out from the crowd',
                    //   style: TextStyle(fontSize: 13),
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // OutlinedButton(
                    //   onPressed: () {},
                    //   style: OutlinedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(16),
                    //           side: const BorderSide(width: 0.5))),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 16),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         const Text(
                    //           'Add new',
                    //           style:
                    //               TextStyle(fontSize: 16, color: Colors.black),
                    //         ),
                    //         Icon(
                    //           Icons.arrow_forward_ios,
                    //           color: Colors.grey.shade300,
                    //           size: 20,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    const Text(
                      'My bio',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Write a fun and punchy intro',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      maxLines: 3,
                      controller: bioController,
                      onSubmitted: (val) {
                        cachedUser.about = val;
                        authBloc.add(UpdateUserEvent(cachedUser));
                      },
                      textInputAction: TextInputAction.go,
                      decoration: inputDecoration(context).copyWith(
                          filled: false,
                          hintText: 'A little bit about you',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 13),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(16)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(16)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300))),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BasicsSection(
                      user: cachedUser,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MoreAboutSection(
                      user: cachedUser,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LanguagesScreen(
                            onLanguagesSelected: (languages) {
                              setState(() {
                                cachedUser.languages = languages;
                              });
                              // authBloc.add(UpdateUserEvent(cachedUser))
                            },
                          ),
                        ));
                      },
                      child: _LanguagesWidget(
                        user: cachedUser,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const ConnectAccountWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LanguagesWidget extends StatelessWidget {
  const _LanguagesWidget({Key? key, required this.user}) : super(key: key);
  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Language i know',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ChipsBox(
              items: user.languages!
                  .map((e) => ChipChoiceModel(
                      label: e.toString(), icon: Icons.language))
                  .toList(),
            )),
      ],
    );
  }
}
