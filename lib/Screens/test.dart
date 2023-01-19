// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerceapp/cubit/home_cubit.dart';
import 'package:ecommerceapp/cubit/home_state.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
  List? list = [];
  TestScreen({
    this.list,
  });
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    TestScreen? testScreen;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: 200,
              )
            ],
          )),
        );
      },
    );
  }
}
