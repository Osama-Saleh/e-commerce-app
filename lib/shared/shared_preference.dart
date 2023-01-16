// ignore_for_file: non_constant_identifier_names, null_check_always_fails

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:pro_shered_preference/pro_shered_preference.dart';

class SharedPreference {
  static SharedPreferences? sharedPreference;

  static Future initialSharedPreference() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {@required String? Key, @required value}) async {
    if (value is String) return await sharedPreference!.setString(Key!, value);
    return await sharedPreference!.setBool(Key!, value!);
  }

  static String? getDataSt({@required String? key}) {
    return sharedPreference?.getString(key!);
  }
  static bool? getDataBl({@required String? key}) {
    return sharedPreference?.getBool(key!);
  }

  static Future<bool?> removeData({@required key}) async {
    return await sharedPreference?.remove(key);
  }
}
