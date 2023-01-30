// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:ecommerceapp/payment/constant_url.dart';
import 'package:ecommerceapp/payment/controller/payment_cubit.dart';
import 'package:ecommerceapp/payment/controller/payment_states.dart';
import 'package:ecommerceapp/payment/ref_code_Screen.dart';
import 'package:ecommerceapp/payment/visa_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit()..getRefCode(),
      child: BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (context, state) {
          if (state is GetRefCodeSuccessStates) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RefCodeScreen(),
                ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Toogle Screen"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (ConstantAPI.refCodeId != null) {
                          // PaymentCubit.get(context).getRefCode();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RefCodeScreen(),
                              ));
                        }
                        print("ink1 ${ConstantAPI.refCodeId}");
                        // PaymentCubit.get(context).getRefCode();
                      },
                      child: Container(
                        width: double.infinity,
                        child: Image.network(ConstantAPI.refCodeImage),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey,
                          border: Border.all(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        print("ink2");
                        print("${ConstantAPI.finalToken}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisaScreen(),
                            ));
                        // PaymentCubit.get(context).getPaymentRequest();
                      },
                      child: Container(
                        width: double.infinity,
                        child: Image.network(ConstantAPI.visaImage),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey,
                          border: Border.all(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
