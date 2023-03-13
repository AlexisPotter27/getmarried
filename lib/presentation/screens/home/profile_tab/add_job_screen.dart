import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/widgets/white_textfield.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({Key? key}) : super(key: key);

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final tittleController = TextEditingController();
  final companyController = TextEditingController();
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
                      user?.occupations?.add(tittleController.text);
                      authBloc.add(UpdateUserEvent(user!));
                    }
                  : null,
              icon: Icon(
                Icons.check,
                color: canUpdate ? primaryColour : Colors.grey,
              ))
        ],
        title: Text('Add job'),
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
                hint: 'Tittle',
                controller: tittleController,
                onChanged: (val) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 2,
              ),
              WhiteTextField(
                hint: 'Company (or just industry)',
                controller: companyController,
              ),
            ],
          );
        },
      ),
    );
  }

  bool get canUpdate => tittleController.text.isNotEmpty;
}
