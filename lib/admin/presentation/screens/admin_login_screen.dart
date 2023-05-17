import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getmarried/admin/presentation/bloc/admin/admin_bloc.dart';
import 'package:getmarried/admin/presentation/screens/admin_home.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/filled_textfield.dart';
import 'package:getmarried/widgets/primary_button.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AdminBloc adminBloc = AdminBloc(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AdminBloc, AdminState>(
        bloc: adminBloc,
        listener: _listenToAdminEvents,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        FilledTextField(
                          hint: 'Enter email',
                          controller: emailController,
                          validator: MultiValidator([
                            EmailValidator(errorText: 'Enter a valid email'),
                            RequiredValidator(errorText: 'Enter your email')
                          ]),
                        ),
                        SizedBox(
                          height: 16,
                        ),

                        FilledTextField(
                          hint: 'Enter password',
                          controller: passwordController,
                          validator: RequiredValidator(
                              errorText: 'Enter your password'),

                        ),
                        SizedBox(
                          height: 20,
                        ),

                        PrimaryButton(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              loginAdmin();
                            })

                        // TextFormField(s)
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  void loginAdmin() {
    if (_formKey.currentState!.validate()) {
      adminBloc
          .add(AdminSigninEvent(emailController.text, passwordController.text));
    }
  }

  void _listenToAdminEvents(BuildContext context, AdminState state) {
    if (state is AdminSigninLoadingState) {
      showAnimatedProgressDialog(context);
    }
    if (state is AdminSigninSuccessState) {
      // StorageHelper.setBoolean(StorageKeys.adminLoggedIn, true);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHome(),
          ));
    }
    if (state is AdminSigninFailureState) {
      Navigator.pop(context);
      showCustomToast(state.error, Colors.red);
    }
  }
}
