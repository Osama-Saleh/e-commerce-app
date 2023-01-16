// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static Init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://fakestoreapi.com/products",
      receiveDataWhenStatusError: true,
      // headers: {"Content-Type": "application/json"}
    ));
  }
  

  static Future<Response> getData() async{
    return await dio.get("https://fakestoreapi.com/products");
  }
}
