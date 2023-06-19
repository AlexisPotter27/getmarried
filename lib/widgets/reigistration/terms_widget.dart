import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/widgets/reigistration/agreement_screen.dart';

class TermsWidget extends StatefulWidget {
  final Function(bool) onAccept;

  const TermsWidget({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  @override
  State<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  var _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AgreementScreen(),
        ));
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: RichText(
          text: TextSpan(
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              children: [
                const TextSpan(
                    text: "In order to continue, please accept our ",
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                TextSpan(
                    text: "User agreements",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColour,
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.underline)),
                // const TextSpan(text: " and "),
                // TextSpan(
                //     text: "Privacy Policy",
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         color: Theme.of(context).colorScheme.secondary,
                //         decoration: TextDecoration.underline))
              ]),
        ),
        leading: Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          value: _isAccepted,
          onChanged: (val) {
            setState(() {
              _isAccepted = val!;
              widget.onAccept(val);
            });
          },
          checkColor: Colors.white,
          activeColor: primaryColour,
          side: const BorderSide(
              color: Colors.blueGrey, width: 2, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
