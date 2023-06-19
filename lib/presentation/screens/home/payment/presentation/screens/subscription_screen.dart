import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/presentation/cubits/in_app_payment/in_app_payment_cubit.dart';
import 'package:getmarried/widgets/error_widget.dart';
import 'package:getmarried/widgets/profile_tab/new_subscription_card.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
  }

  final InAppPaymentCubit _appPaymentCubit = InAppPaymentCubit(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upgrade Plans',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<InAppPaymentCubit, InAppPaymentState>(
        bloc: _appPaymentCubit..fetchOfferings(),
        builder: (context, state) {
          if (state is OfferingsFetched) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.offerings.all.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          height: 150,
                          child: NewSubscriptionCard(
                            tittle: 'Premium',
                            description: 'Free for first 500 users',
                            // bgImage: 'assets/upgrade_bg.jpeg',

                            offering: state.offerings.current!,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
            );
          }

          return AppPromptWidget();
        },
      ),
    );
  }
}
