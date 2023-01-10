// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, curly_braces_in_flow_control_structures

import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/module/user_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 24, 112, 70),
          actions: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: CircleAvatar(
                    radius: 12,
                    child: Text(
                      "${HomeCubit.get(context).sum}",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.grey.withOpacity(.5),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
              ],
            )
          ],
          elevation: 0,
        ),
        body: buidItems(context),
        drawer: myDrawer(context, HomeCubit.get(context).userModel));
  }
}

Widget buidItems(context) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: HomeCubit.get(context).products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.93,
            ),
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image(image: AssetImage("assets/test.jpg")),
                Container(
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(
                        HomeCubit.get(context).products[index]["image"]),
                    fit: BoxFit.fill,
                    height: 300,
                  ),
                ),
                Container(
                  color: Colors.green.withAlpha(60),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${HomeCubit.get(context).products[index]["title"]}",
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${HomeCubit.get(context).products[index]["price"]}",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              // flex: 1,
                              child: Container(
                                height: 25,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Color.fromARGB(255, 173, 169,
                                                169); //<-- SEE HERE
                                          return null; // Defer to the widget's default.
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      if (HomeCubit.get(context).products[index]
                                              ["id"] ==
                                          index + 1)
                                        HomeCubit.get(context).decreasIcon();
                                    },
                                    child: Icon(Icons.remove)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Center(
                                    child: Text(
                                        "${HomeCubit.get(context).numberText}")),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 25,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Color.fromARGB(255, 173, 169,
                                                169); //<-- SEE HERE
                                          return null; // Defer to the widget's default.
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      HomeCubit.get(context).increasIcon(index);
                                      print("increas");
                                    },
                                    child: Icon(Icons.add)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget myDrawer(context, UserModel? model) {
  return Drawer(
      child: Column(
    children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: HomeCubit.get(context).converImage != null
                  ? FileImage(HomeCubit.get(context).converImage!)
                      as ImageProvider
                  : AssetImage("assets/default.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[400],
                child: IconButton(
                    iconSize: 18,
                    color: Colors.black,
                    onPressed: () {
                      HomeCubit.get(context).getconverImage(name: model!.name);
                    },
                    icon: Icon(Icons.camera_alt_rounded)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // Stack(
                // alignment: Alignment.topCenter,
                // children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: HomeCubit.get(context).profileImage != null
                      ? FileImage(HomeCubit.get(context).profileImage!)
                          as ImageProvider
                      : AssetImage("assets/default.jpg"),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey[400],
                      child: IconButton(
                          iconSize: 15,
                          color: Colors.black,
                          onPressed: () {
                            HomeCubit.get(context)
                                .getProfileImage(name: model!.name);
                          },
                          icon: Icon(Icons.camera_alt_rounded)),
                    ),
                  ),
                ),
                // ],
                // ),
                SizedBox(
                  width: 10,
                ),
                Text("${model?.name}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      )
    ],
  ));
}
