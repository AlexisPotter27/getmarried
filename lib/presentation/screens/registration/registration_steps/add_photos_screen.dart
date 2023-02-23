import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/image_picker_card.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';
import 'package:getmarried/widgets/reigistration/not_sure_widget.dart';


class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({Key? key, required this.onComplete}) : super(key: key);
 final Function onComplete;

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add your first 2 photos ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '2 photos are better than 1, its our science. You can change this later.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 150,
                child: Row(
                  children:  [
                    Expanded(child: ImagePickerCard()),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(child: ImagePickerCard()),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Add from Facebook',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: NextButton(onPressed: (){
                widget.onComplete();
            }),
              ),),
            const NotSureWidget(),
          ],
        )
      ],
    );
  }
}
