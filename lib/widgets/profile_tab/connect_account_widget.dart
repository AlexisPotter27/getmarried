import 'package:flutter/material.dart';

class ConnectAccountWidget extends StatefulWidget {
  const ConnectAccountWidget({Key? key}) : super(key: key);

  @override
  State<ConnectAccountWidget> createState() => _ConnectAccountWidgetState();
}

class _ConnectAccountWidgetState extends State<ConnectAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(
                Icons.facebook,
                color: Colors.blueAccent,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Connect Your Facebook',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.radio_button_off,
                color: Colors.blueAccent,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Connecting your instagram will add your latest posts to your profile. Your username wont be visible.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const AccountPickerWidget(),
            ),
          )
        ],
      ),
    );
  }
}

class AccountPickerWidget extends StatefulWidget {
  const AccountPickerWidget({Key? key}) : super(key: key);

  @override
  State<AccountPickerWidget> createState() => _AccountPickerWidgetState();
}

class _AccountPickerWidgetState extends State<AccountPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
          ),
          Positioned(
              right: -8,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey.shade300,
                child: const Center(
                    child: Icon(
                  Icons.add,
                  size: 10,
                  color: Colors.white,
                )),
              ))
        ],
      ),
    );
  }
}
