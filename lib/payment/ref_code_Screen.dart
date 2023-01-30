// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers

import 'package:ecommerceapp/payment/constant_url.dart';
import 'package:ecommerceapp/payment/controller/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefCodeScreen extends StatelessWidget {
  const RefCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reference Code"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "You Should go To any market to pay",
              style: TextStyle(fontSize: 23, color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Text("This is reference code"),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Center(
                child: Text(
                  "${ConstantAPI.refCodeId.toString()}",
                  style: TextStyle(fontSize: 30, letterSpacing: 6),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
