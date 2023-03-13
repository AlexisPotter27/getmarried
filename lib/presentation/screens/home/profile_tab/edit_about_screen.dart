import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/widgets/profile_tab/edit_profile_item.dart';

class EditAboutScreen extends StatefulWidget {
  const EditAboutScreen({Key? key, required this.options, required this.field})
      : super(key: key);
  final List options;
  final String field;

  @override
  State<EditAboutScreen> createState() => _EditAboutScreenState();
}

class _EditAboutScreenState extends State<EditAboutScreen> {
  UserData cachedUser = getIt.get<CacheCubit>().user!;
  AuthBloc authBloc = AuthBloc(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is UpdateUserLoadingState) {
            showAnimatedProgressDialog(context);
          }
          if (state is UpdateUserSuccessState) {

            cachedUser = state.userData;
            getIt.get<CacheCubit>().updateUser(state.userData);
            Navigator.pop(context);
            Navigator.pop(context);
          }
          if (state is UpdateUserFailureState) {
            Navigator.pop(context);
            showCustomToast(state.error);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  getTittle(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.options.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              update(widget.options[index]);
                            },
                            child: EditProfileItem(
                              value: widget.options[index],
                              selected: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(16)),
                                    child: Text(
                                      'Skip',
                                      style: TextStyle(color: Colors.black38),
                                    ))),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  String getTittle() {
    switch (widget.field) {
      case 'height':
        return 'What is your height ?';
      case 'workout':
        return 'Do you workout ?';
      case 'gender':
        return 'What is your gender ?';
      case 'education':
        return 'What is your education ?';
      case 'drinking':
        return 'Do you drink ?';
      case 'smoking':
        return 'Do you smoke ?';
      case 'looking':
        return 'What do you want from your dates ?';
      case 'kids':
        return 'What are your ideal plans for children?';
      case 'star_sign':
        return 'What is your zodaic sign ?';
      case 'politics':
        return 'What are your political leanings ?';
      case 'religion':
        return 'Do you identify with a religion ?';
      default:
        return '';
    }
  }

  void update(dynamic value) {
    switch (widget.field) {
      case 'height':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(height: value)));
        break;
      case 'workout':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(workout: value)));
        break;
      case 'gender':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(gender: value)));
        break;

      case 'education':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(education: value)));
        break;

      case 'drinking':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(drinking: value)));
        break;

      case 'smoking':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(smoking: value)));
        break;

      case 'looking':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(lookingFor: value)));
        break;

      case 'kids':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(children: value)));
        break;

      case 'star_sign':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(starSign: value)));
        break;

      case 'politics':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(political: value)));
        break;

      case 'religion':
        authBloc.add(UpdateUserEvent(cachedUser.copyWith(religion: value)));
        break;

      default:
        break;
    }
  }
}
