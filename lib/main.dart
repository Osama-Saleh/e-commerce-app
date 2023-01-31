// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, await_only_futures, avoid_print, must_be_immutable, curly_braces_in_flow_control_structures, unused_local_variable

import 'package:ecommerceapp/Screens/border_screen.dart';
import 'package:ecommerceapp/Screens/bottombar.dart';

import 'package:ecommerceapp/components/components.dart';
import 'package:ecommerceapp/Screens/login_screen.dart';
import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/cubit/home_state.dart';
import 'package:ecommerceapp/dio_helper/dio_helper.dart';
import 'package:ecommerceapp/shared/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DioHelper.Init();
  await DioHelper.intDioPayMob();
  await SharedPreference.initialSharedPreference();

  bool? onBorder = await SharedPreference.getDataBl(key: "onBorder");
  uid = await SharedPreference.getDataSt(key: "uid");
  

  print("My uid is  ${uid}");
  print("onBorder  ${onBorder}");
  Widget? firstWidget;
  // if (onBorder == true) {
  //   firstWidget = LoginScreen();
  // }

  if (onBorder == true) {
    firstWidget = LoginScreen();
    if (uid != null) {
      firstWidget = ButtomBarScreen();
    }
  } else {
    firstWidget = BorderScreen();
  }

  runApp(MyApp(
    firstWidget: firstWidget,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.firstWidget});
  Widget? firstWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
      ..getUserData()
      ..getHomeData()
      ,
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: kBackgroundColor,
                appBarTheme: AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 24, 112, 70),
                ),
                textTheme: Theme.of(context)
                    .textTheme
                    .apply(bodyColor: kPrimaryColor)),
            home: firstWidget,
          );
        },
      ),
    );
  }
}
