import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';

class ConnectionMenuItem extends StatefulWidget {
  ConnectionMenuItem(
      {Key? key,
      this.isSelected = false,
      required this.tittle,
      required this.subtittle, required this.onTap})
      : super(key: key);
  bool isSelected;
  final String tittle;
  final String subtittle;
  final VoidCallback onTap;

  @override
  State<ConnectionMenuItem> createState() => _ConnectionMenuItemState();
}

class _ConnectionMenuItemState extends State<ConnectionMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: widget.isSelected ? Colors.grey.shade200 : Colors.white,
            borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        duration: const Duration(milliseconds: 300),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: primaryColour,
              child: Icon(Icons.format_align_center,color: Colors.white,size: 16,),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tittle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.subtittle,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
            widget.isSelected
                ? const Icon(
                    Icons.check_circle,
                    color: primaryColour,
                  )
                : Icon(
                    Icons.radio_button_off,
                    color: Colors.grey.shade300,
                  )
          ],
        ),
      ),
    );
  }
}
