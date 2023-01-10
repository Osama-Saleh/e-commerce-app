// ignore_for_file: avoid_print, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ecommerceapp/cubit/home_state.dart';
import 'package:ecommerceapp/dio_helper/dio_helper.dart';
import 'package:ecommerceapp/module/product_model.dart';
import 'package:ecommerceapp/module/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:collection/collection.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  void userRegisteData({
    @required String? name,
    @required String? email,
    @required String? password,
  }) async {
    emit(RegisterLoadingState());
    print("RegisterLoadingState");
    try {
      // final credential = await
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          // print(credential.user);
          .then((value) {
        print(value.user);
        creatUserData(
            name: name, email: email, password: password, id: value.user!.uid);
        // getUserData(value.user!.uid);
        // emit(RegisterSuccessState());
        // print("RegisterSuccessState");
      }).catchError((onError) {
        print("RegisterErrorState ${onError.toString()}");
        emit(RegisterErrorState(onError.toString()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void SigninData({
    // @required String? name,
    @required String? email,
    @required String? password,
  }) async {
    try {
      emit(SigninLoadingState());
      print("SigninLoadingState");
      // final credential = await
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        // print("SigninSuccessState");
        print(value.user!.uid);

        emit(SigninSuccessState(uid: value.user!.uid));

        print("SigninSuccessState");
      }).catchError((onError) {
        print("SigninErrorState ${onError.toString()}");
        emit(SigninErrorState(onError.toString()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void creatUserData({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? id,
  }) {
    emit(CreateUserDataLoadinState());
    print("CreateUserDataLoadinState");
    UserModel userModel = UserModel(
      name: name,
      email: email,
      password: password,
      uid: id,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(userModel.toMap())
        .then((value) {
      print("CreateUserDataSuccessState");
      emit(CreateUserDataSuccessState());
    }).catchError((onError) {
      print("CreateUserDataErrorState ${onError}");
      emit(CreateUserDataErrorState());
    });
  }

  UserModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadinState());
    print("GetUserDataLoadinState");
    FirebaseFirestore.instance
        .collection("Users")
        .doc("sOvc8YqTzxaC18HcB3PBBtlmJRs1")
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print("getUserData ${userModel!.uid}");
      print("getUserData ${userModel!.name}");

      emit(GetUserDataSuccessState());
      print("GetUserDataSuccessState");
    }).catchError((onError) {
      emit(GetUserDataErrorState());
      print("GetUserDataErrorState");
    });
  }

  File? profileImage;
  ImagePicker picker = ImagePicker();
  void getProfileImage({
    @required String? name,
  }) async {
    emit(ProfileImageLoadingState());
    print("ProfileImageLoadingState");
    final profileimagefile =
        await picker.pickImage(source: ImageSource.gallery);
    if (profileimagefile != null) {
      profileImage = File(profileimagefile.path);
      uploadProfileImage(name: name);
      emit(ProfileImageSuccessState());
      print("ProfileImageSuccessState");
    } else {
      emit(ProfileImageErrorState());
      print("ProfileImageErrorState");
    }
  }

  Future<void> uploadProfileImage({
    @required String? name,
  }) async {
    emit(UploadProfileImageLoadingState());
    print("UploadProfileImageLoadingState");
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("images/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //URL HTTP
        print("My URL Image ${value}");
        updateUserData(name: name, profileImage: value);
        emit(UploadProfileImageSuccessState());
        print("UploadProfileImageSuccessState");
      }).catchError((Error) {
        print("getDownloadURLError ${Error}");
      });
    }).catchError((Error) {
      emit(UploadProfileImageErrorState());
      print("uploadProfileImage ${Error}");
    });
  }

  File? converImage;
  void getconverImage({
    @required String? name,
  }) async {
    emit(CoverImageLoadingState());
    print("coverImageLoadingState");
    final converimagefile = await picker.pickImage(source: ImageSource.gallery);
    if (converimagefile != null) {
      converImage = File(converimagefile.path);
      print("coverImageSuccessState");
      uploadCoverImage(name: name);
      emit(CoverImageSuccessState());
    } else {
      // print("Not Image Selected");
      emit(CoverImageErrorState());
      print("coverImageErrorState");
    }
  }

  Future<void> uploadCoverImage({
    @required String? name,
    // @required String? bio,
    // @required String? phone,
  }) async {
    emit(UploadCoverImageLoadingState());
    print("UploadCoverImageLoadingState");
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("images/${Uri.file(converImage!.path).pathSegments.last}")
        .putFile(converImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //URL HTTP
        print("My Image 2 ${value}");
        updateUserData(name: name, coverImage: value);
        emit(UploadCoverImageSuccessState());
        print("UploadCoverImageSuccessState");
      }).catchError((Error) {
        print("getDownloadURLError ${Error}");
      });
    }).catchError((Error) {
      emit(UploadCoverImageErrorState());
      print("uploadCoverImage ${Error}");
    });
  }

  void updateUserData({
    @required String? name,
    @required String? profileImage,
    @required String? coverImage,
  }) {
    emit(UpdateUserDataLoadinState());
    print("UpdateUserDataLoadinState");
    UserModel model = UserModel(
      name: userModel!.name,
      profileImage: profileImage ?? userModel!.profileImage,
      coverImage: coverImage ?? userModel!.coverImage,
      email: userModel!.email,
      password: userModel!.password,
      uid: userModel!.uid,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc("sOvc8YqTzxaC18HcB3PBBtlmJRs1")
        .update(model.toMap())
        .then((value) {
      print("UpdateUserDataSuccessState");
      emit(UpdateUserDataSuccessState());
    }).catchError((onError) {
      print("UpdateUserDataErrorState ${onError}");
      emit(UpdateUserDataErrorState());
    });
  }

  ProductsModel? model;
  // Map<String, dynamic>? list = {};
  List products = [];

  void getHomeData() {
    emit(GetHomeDataLoadinState());
    print("GetHomeDataLoadinState");
    DioHelper.getData().then((value) {
      products = value.data;

      print(products.length);

      emit(GetHomeDataSuccessState());
      print("GetHomeDataSuccessState");
    }).catchError((onError) {
      emit(GetHomeDataErrorState());
      print("GetHomeDataErrorState ${onError.toString()}");
    });
  }

  // int text = products.length;
  int? sum = 0;
  int numberText = 0;
  Map<int, bool>? istrue = {};
  void increasIcon(index) {
    istrue = {products[index]["id"]: true};
    if (products[index]["id"] == istrue) {
      sum = (1 + numberText);
      numberText++;
      emit(IncreasSuccessState());
    } else
    {
      
      print("not increas");
    }
  }

  // List num = [1, 2, 3, 5];

  // final fixedLengthList = List<int>.filled(5, 0);

  void decreasIcon() {
    if (numberText > 0) {
      numberText--;
      sum = sum! - 1;
      emit(IncreasSuccessState());
    }
  }
}
