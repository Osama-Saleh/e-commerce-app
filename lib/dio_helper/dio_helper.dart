// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:ecommerceapp/payment/constant_url.dart';

class DioHelper {
  static Dio dio = Dio();

  static Init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://fakestoreapi.com/products",
      receiveDataWhenStatusError: true,
      // headers: {"Content-Type": "application/json"}
    ));
  }

  static Future<Response> getData() async {
    return await dio.get("https://fakestoreapi.com/products");
  }

  static Dio dioPayMob = Dio();
  static intDioPayMob() {
    dioPayMob = Dio(
      BaseOptions(
          baseUrl: ConstantAPI.baseURL,
          receiveDataWhenStatusError: true,
          headers: {"Content-Type": "application/json"}),
    );
  }

  static Future<Response> postdata(
      String url, Map<String, dynamic> data) async {
    // Options(headers: {"Content-Type": "application/json"});
    return await dioPayMob.post(
      url,
      data: data,
    );
  }
}
