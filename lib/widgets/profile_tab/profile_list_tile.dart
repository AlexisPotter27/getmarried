import 'package:flutter/material.dart';

class ProfileListTile extends StatefulWidget {
  const ProfileListTile(
      {Key? key,
      required this.preffix,
      required this.tittle,
       this.value,
      required this.onTap})
      : super(key: key);
  final Widget preffix;
  final String tittle;
  final String? value;
  final VoidCallback onTap;

  @override
  State<ProfileListTile> createState() => _ProfileListTileState();
}

class _ProfileListTileState extends State<ProfileListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.preffix,
                const SizedBox(
                  width: 10,
                ),
                Text(widget.tittle,style: const TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
            Row(
              children: [
                Text(
                  widget.value?? 'Add',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey.shade300,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
