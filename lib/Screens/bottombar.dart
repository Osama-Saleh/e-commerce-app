// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ecommerceapp/Screens/bought_Screen.dart';
import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtomBarScreen extends StatelessWidget {
  ButtomBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is GetHomeDataSuccessState,
            builder: (context) {
              return HomeCubit.get(context)
                  .buttomBarScreens[HomeCubit.get(context).currentIndex];
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: Color.fromARGB(226, 32, 27, 100),
            // cornerRadius: 20,
            height: 50,
            curveSize: 70,
            color: Colors.amber,
            // style: TabStyle.flip,

            // ignore: prefer_const_literals_to_create_immutables
            items: [
              TabItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.amber,
                  ),
                  title: "Home"),
              TabItem(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.amber,
                  ),
                  title: "buy"),
            ],
            onTap: (index) {
              HomeCubit.get(context).changeButtomBar(index);
            },
            initialActiveIndex: HomeCubit.get(context).currentIndex,
          ),
        );
      },
    );
  }
}
