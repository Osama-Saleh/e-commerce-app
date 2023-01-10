// ignore_for_file: prefer_const_constructors, sort_child_properties_last, missing_required_param, avoid_print, sized_box_for_whitespace

import 'package:ecommerceapp/components/components.dart';
import 'package:ecommerceapp/Screens/home_screen.dart';
import 'package:ecommerceapp/Screens/register_screen.dart';
import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/cubit/home_state.dart';
import 'package:ecommerceapp/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isvasible = true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is SigninSuccessState) {
            SharedPreference.saveData(Key: "uid", value: "${state.uid}")
                .then((value) => {
                      Fluttertoast.showToast(
                          msg: "Login Success",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          )),
                    })
                .catchError((onError) {
              print("Error Sign in ${onError.toString()}");
            });
          } else if (state is SigninErrorState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -230,
                    right: -100,
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: Container(
                        width: 1.2 * MediaQuery.of(context).size.width,
                        height: 1.2 * MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            gradient: LinearGradient(
                                begin: Alignment(-.2, -.8),
                                end: Alignment.bottomCenter,
                                // ignore: prefer_const_literals_to_create_immutables
                                colors: [
                                  Color(0x007CBFCF),
                                  Color(0xB316BFC4),
                                ])),
                      ),
                    ),
                  ),
                  Positioned(
                    // bottom: -270,
                    // right: -150,
                    bottom: -300,
                    left: -150,
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: Container(
                        width: 1.2 * MediaQuery.of(context).size.width,
                        height: 1.2 * MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(150),
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                // begin: Alignment(.6, -1.2),
                                // end: Alignment(0.7, -.1),
                                // ignore: prefer_const_literals_to_create_immutables
                                colors: [
                                  Color(0x007CBFCF),
                                  Color(0xB316BFC4),
                                ])),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  myTextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Your mail";
                                      }
                                      return null;
                                    },
                                    hintText: "Email",
                                    // fillColor: Colors.white,
                                    // filled: true,
                                    prefixIcon: Icon(Icons.email),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  myTextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Your Password";
                                      }
                                      return null;
                                    },
                                    // fillColor: Colors.white,
                                    // filled: true,
                                    hintText: "Password",
                                    obscureText: isvasible,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isvasible = !isvasible;
                                          });
                                        },
                                        icon: isvasible
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 180,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          HomeCubit.get(context).SigninData(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           HomeScreen(),
                                          //     ));
                                          // print(
                                          //     "GetRegiste ${HomeCubit.get(context).userModel!.email}");
                                          // print(
                                          //     "GetRegiste ${HomeCubit.get(context).userModel!.uid}");
                                          // if (state is SigninSuccessState)
                                          //   print("-----------${state.uid}");
                                        }
                                      },
                                      child: Text(
                                        "Log In",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  kPrimaryColor),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide.none,
                                          ))
                                          // backgroundColor: kSecondaryColor,
                                          ),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    // crossAxisAlignment: ,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account?",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterScreen(),
                                              ));
                                        },
                                        child: Text(
                                          "Register",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 18,
                                              ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
