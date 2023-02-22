import 'package:flutter/material.dart';
import 'package:getmarried/widgets/primary_button.dart';
import 'build_profile_screen.dart';

class BuildProfileOnboard extends StatefulWidget {
  const BuildProfileOnboard({Key? key}) : super(key: key);

  @override
  State<BuildProfileOnboard> createState() => _BuildProfileOnboardState();
}

class _BuildProfileOnboardState extends State<BuildProfileOnboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/love.png',
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'You are  here for a\nRelationship!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Amazing, You are more likely to find someone really special if take time to build your profile.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              PrimaryButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuildProfileScreen(),
                      ));
                },
                child: const Text('Build my profile', style: TextStyle(color: Colors.blue)),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
