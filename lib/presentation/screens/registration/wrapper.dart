import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/registration/signin_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    getIt.get<AuthBloc>().add(ListenToUserAccountEvent(getIt.get<CacheCubit>().user!.uid.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        log('EVENT RECEIVED');
      },
      bloc: getIt.get<AuthBloc>(),
      buildWhen: (prevState, currentState) {
        return currentState is AuthStateChangedState ||
            currentState is AccountDeletedState &&
                (prevState is! AccountDeletedState &&
                    prevState is! AuthInitial);
      },
      builder: (context, state) {
        // if (state is AuthStateChangedState) {
        //   if (state.uid == null) {
        //     return SigninScreen();
        //   } else {
        //     return const HomeScreen();
        //   }
        // }

        if (state is AccountDeletedState) {
          return SigninScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
