// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, sized_box_for_whitespace, avoid_print, duplicate_ignore, unnecessary_brace_in_string_interps

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapp/Screens/bought_Screen.dart';
import 'package:ecommerceapp/Screens/login_screen.dart';
import 'package:ecommerceapp/components/components.dart';
import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/cubit/home_state.dart';
import 'package:ecommerceapp/module/user_model.dart';
import 'package:ecommerceapp/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BoughtScreen(),
                            ));
                      },
                      icon: Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                )
              ],
              elevation: 0,
            ),
            body: ConditionalBuilder(
              condition: state is GetHomeDataSuccessState,
              builder: (context) => buidItems(context),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            drawer: myDrawer(context, HomeCubit.get(context).userModel));
      },
    );
  }
}

CarouselController carouselController = CarouselController();
final controller = PageController(viewportFraction: 0.8, keepPage: true);

Widget buidItems(context) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 250,
                child: CarouselSlider(
                  carouselController: carouselController,
                  items: HomeCubit.get(context)
                      .products
                      .map((e) => Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(3, 6),
                                    color: Colors.black.withOpacity(.5)),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image(
                              image: NetworkImage("${e["image"]}"),
                              fit: BoxFit.fill,
                              height: 250,
                              width: double.infinity,
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    initialPage: 10,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                )
                //
                ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Products",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: HomeCubit.get(context).products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 3,
                  childAspectRatio: 1 / 2.05,
                ),
                itemBuilder: (context, index) {
                  var product = HomeCubit.get(context).products[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(2, 6),
                                color: Colors.black.withOpacity(.5)),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image(
                          image: NetworkImage(
                              HomeCubit.get(context).products[index]["image"]),
                          fit: BoxFit.fill,
                          height: 300,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(60),
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                                "${HomeCubit.get(context).products[index]["price"]} 💲\$\"",
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateProperty
                                                .resolveWith<Color?>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed))
                                                  return Color.fromARGB(
                                                      255,
                                                      173,
                                                      169,
                                                      169); //<-- SEE HERE
                                                return null; // Defer to the widget's default.
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            // if (HomeCubit.get(context).products[index]
                                            //     ["id"] ==
                                            // index + 1)
                                            HomeCubit.get(context).decreasIcon(
                                                // HomeCubit.get(context)
                                                //     .products[index]["id"]
                                                index+1
                                                    );
                                            print(HomeCubit.get(context).buy);
                                          },
                                          child: Icon(Icons.remove)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                              "${HomeCubit.get(context).products_numbers![product["id"]]}")),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 25,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateProperty
                                                .resolveWith<Color?>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed))
                                                  return Color.fromARGB(
                                                      255,
                                                      173,
                                                      169,
                                                      169); //<-- SEE HERE
                                                return null; // Defer to the widget's default.
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            HomeCubit.get(context).increasIcon(
                                                HomeCubit.get(context)
                                                    .products[index]["id"]);
                                            // print("increas");
                                            // print(
                                            // "lenght ${HomeCubit.get(context).isbuy.length}");
                                            // HomeCubit.get(context).getSelect(
                                            //     HomeCubit.get(context)
                                            //         .products[index]["id"]);
                                            print(HomeCubit.get(context).isbuy);

                                            print("******************");
                                            print(HomeCubit.get(context).buy);
                                            print(
                                                "lenght ${HomeCubit.get(context).isbuy.length}");
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
                  );
                }),
          ],
        ),
      ),
    );

Widget myDrawer(context, UserModel? model) {
  return Drawer(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: model?.coverImage == " "
                  ? AssetImage("assets/default.jpg")
                  : NetworkImage("${model?.coverImage}") as ImageProvider,
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
                      HomeCubit.get(context).getconverImage(name: model?.name);
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
                CircleAvatar(
                  radius: 35,
                  backgroundImage: model?.profileImage == " "
                      ? AssetImage("assets/default.jpg")
                      : NetworkImage("${model?.profileImage}") as ImageProvider,
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
                                .getProfileImage(name: model?.name);
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
      ),
      Spacer(),
      Padding(
        padding: const EdgeInsets.only(bottom: 60, left: 30),
        child: OutlinedButton.icon(
            onPressed: () {
              SharedPreference.removeData(key: "uid").then((value) {
                print(value);
                if (value!) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                }
              });
              // uid = " ";
              print("uid ${uid}");
              print("log OOOOOOUT");
            },
            icon: Icon(Icons.logout),
            label: Text("Logout")),
      )
    ],
  ));
}
