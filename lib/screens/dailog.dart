import 'package:flutter/material.dart';


class Dialog extends StatelessWidget {
  final String number;

  const Dialog({Key? key, required this.number, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      height: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 5, color: Colors.black45)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              const Text('We need to verify your number'),
              const SizedBox(height: 10,),
              const Text('We need to make sure that'),
              Text('$number is your number')
            ],
          ),
        ),
      ),
    );
  }
}

