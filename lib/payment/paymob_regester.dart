// ignore_for_file: prefer_const_constructors, missing_required_param, sort_child_properties_last

import 'dart:ffi';

import 'package:ecommerceapp/components/components.dart';
import 'package:ecommerceapp/payment/controller/payment_cubit.dart';
import 'package:ecommerceapp/payment/controller/payment_states.dart';
import 'package:ecommerceapp/payment/toggel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PayMobRegisterScreen extends StatelessWidget {
  PayMobRegisterScreen({super.key});
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var priceController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit()..GetAuthPaymon(),
      child: BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (context, state) {
          if (state is GetPaymentRequestSuccessStates) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ToggleScreen(),
                ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orangeAccent,
              title: Text("Payment Integration"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        child: Lottie.asset("assets/delivery.json"),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: myTextFormField(
                              controller: firstNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Your data";
                                }
                                return null;
                              },
                              prefixIcon: Icon(Icons.person),
                              hintText: "First Name",
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: myTextFormField(
                              controller: lastNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Your data";
                                }
                                return null;
                              },
                              prefixIcon: Icon(Icons.person),
                              hintText: "Last Name",
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      myTextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your data";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      myTextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your data";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Phone Number",
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      myTextFormField(
                        controller: priceController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your data";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.price_change),
                        hintText: "Price \$",
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              PaymentCubit.get(context).GetOrderId(
                                  firstname: firstNameController.text,
                                  lastname: lastNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  price: priceController.text);
                            }
                          },
                          child: Text("REGISTER"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            // side: BorderSide(color: Colors.black)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
