import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/widgets/white_textfield.dart';

class AddEducationScreen extends StatefulWidget {
  const AddEducationScreen({Key? key}) : super(key: key);

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final institutionController = TextEditingController();
  final authBloc = getIt.get<AuthBloc>();
  final user = getIt.get<CacheCubit>().user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: canUpdate
                  ? () {
                      user?.educationColledge?.add(institutionController.text);
                      authBloc.add(UpdateUserEvent(user!));
                    }
                  : null,
              icon: Icon(
                Icons.check,
                color: canUpdate ? primaryColour : Colors.grey,
              ))
        ],
        title: Text('Add education'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is UpdateUserLoadingState) {
            showAnimatedProgressDialog(context);
          }
          if (state is UpdateUserSuccessState) {
            getIt.get<CacheCubit>().updateUser(state.userData);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 16,
              ),
              WhiteTextField(
                hint: 'Institution',
                controller: institutionController,
                onChanged: (val) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 2,
              ),
              // InkWell(
              //   onTap: () {},
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           color: Colors.white,
              //           padding:
              //               EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              //           child: Text('Graduation year'),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }

  bool get canUpdate => institutionController.text.isNotEmpty;
}
