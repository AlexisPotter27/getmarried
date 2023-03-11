import 'package:flutter/material.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      itemBuilder: (context, index) => EditProfileItem(
                        value: widget.options[index],
                        selected: true,
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
      ),
    );
  }

  String getTittle() {
    switch (widget.field) {
      case 'height':
        return 'What is your height ?';
      case 'workout':
        return 'Do you workout ?';
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
}
