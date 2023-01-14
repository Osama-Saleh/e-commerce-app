// ignore_for_file: prefer_const_constructors, file_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapp/Screens/test.dart';
import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/cubit/home_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BoughtScreen extends StatelessWidget {
  const BoughtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Buy"),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) {
                return Column(
                  children: [
                    Container(
                      height: 110,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestScreen(),
                                ));
                          },
                          child: Text("test")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 100,
                            width: double.infinity,
                            child: Image(
                              // height: 100,
                              // width: double.infinity,
                              image: NetworkImage(
                                  "https://thumbs.dreamstime.com/b/beautiful-landscape-dry-tree-branch-sun-flowers-field-against-colorful-evening-dusky-sky-use-as-natural-background-backdrop-48319427.jpg"),
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemCount: 5,
                      ),
                    ),
                  ],
                );
              },
              fallback: (context) =>
                  Center(child: Text("${HomeCubit.get(context).isbuy.length}")),
            ));
        ;
      },
    );
  }
}
