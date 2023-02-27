import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CardFormScreen extends StatelessWidget {
  const CardFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      title:  Center(child: Image.asset('assets/ilogo.png', width: 50, height: 50,)),
      elevation: 0,
      backgroundColor: Colors.indigoAccent,
    ),
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.w,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text('Subscription',
                style: Theme.of(context).textTheme.headline5,

              ),
            ),
            const SizedBox(height: 20,),
            CardFormField(controller: CardFormEditController(),
              enablePostalCode: true,
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: (){

                },
                child: const Text('Pay'),
            )
          ],
        ),
      ),
    );
  }
}
