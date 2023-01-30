// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapp/Screens/border_screen.dart';
import 'package:ecommerceapp/Screens/test.dart';
import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/cubit/home_state.dart';
import 'package:ecommerceapp/payment/paymob_regester.dart';
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
              condition: HomeCubit.get(context).isbuy.length > 0,
              builder: (context) {
                return buildBuyItems(context);
              },
              fallback: (context) => Center(child: Text("No Item Selceted")),
            ));
      },
    );
  }
}

Widget buildBuyItems(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Expanded(
          // color: Colors.red,
          // height: 100,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: NetworkImage(
                          "${HomeCubit.get(context).isbuy[index]["image"]}"),
                      fit: BoxFit.fill,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "${HomeCubit.get(context).isbuy[index]["title"]}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "${HomeCubit.get(context).isbuy[index]["price"]} 💲"),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: IconButton(
                            onPressed: () {
                              HomeCubit.get(context).removeData(index);
                            },
                            icon: Icon(Icons.close))),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => Container(
              color: Colors.grey[600],
              height: 1,
            ),
            itemCount: HomeCubit.get(context).isbuy.length,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 9,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PayMobRegisterScreen(),
                  ));
            },
            child: Text("BUY"),
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
  );
}
