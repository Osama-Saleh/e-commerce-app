// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerceapp/Screens/login_screen.dart';
import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/cubit/home_state.dart';
import 'package:ecommerceapp/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BorderScreen extends StatelessWidget {
  BorderScreen({super.key});

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Column(
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Willcome',
                      textStyle: TextStyle(
                        fontSize: 30,
                      )),
                  ScaleAnimatedText(
                    'To',
                    duration: Duration(milliseconds: 4000),
                    textStyle: const TextStyle(fontSize: 30.0),
                  ),
                  TyperAnimatedText('fashion',
                      textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3)),
                ],
              ),
              // Text(
              //   "fashion",
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              Expanded(
                flex: 3,
                child: Container(
                  // height: MediaQuery.of(context).size.height / 1.2,
                  child: PageView.builder(
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HomeCubit.get(context).borderImage[index];
                    },
                    onPageChanged: (index) {
                      HomeCubit.get(context).borderScreen(index);

                      print("${HomeCubit.get(context).islast}");
                    },
                    itemCount: HomeCubit.get(context).borderImage.length,
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: HomeCubit.get(context).borderImage.length,
                effect: SlideEffect(
                    spacing: 8.0,
                    // radius: 2.0,
                    // dotWidth: 24.0,
                    // dotHeight: 16.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Color.fromARGB(255, 252, 101, 13)),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn);
                          if (HomeCubit.get(context).islast == true) {
                            SharedPreference.saveData(
                                    Key: "onBorder", value: true)
                                .then((value) => {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ))
                                    })
                                .catchError((onError) {
                              print("SharedPref saveData ${onError}");
                            });
                          }
                        },
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 248, 106, 12))),
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 25),
                        )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
