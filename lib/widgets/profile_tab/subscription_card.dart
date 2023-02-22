import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/widgets/upgrade_button.dart';

class SubscriptionCard extends StatefulWidget {
  const SubscriptionCard(
      {Key? key,
      required this.tittle,
      required this.description,
      required this.buttonText,
      this.gradient})
      : super(key: key);
  final String tittle;
  final String description;
  final String buttonText;
  final Gradient? gradient;

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: widget.gradient ??
            LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                colors: [
                  Colors.orangeAccent.shade200,
                  Colors.orangeAccent.shade400,
                  Colors.orange,
                  Colors.orange,
                ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.tittle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child:
                UpgradeButton(onPressed: () {}, child: Text(widget.buttonText)),
          )
        ],
      ),
    );
  }
}
