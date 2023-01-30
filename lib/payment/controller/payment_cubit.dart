// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:ecommerceapp/dio_helper/dio_helper.dart';
import 'package:ecommerceapp/payment/constant_url.dart';
import 'package:ecommerceapp/payment/controller/payment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(IntPaymentState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  Future<void> GetAuthPaymon() async {
    emit(AuthLoadigStates());
    print("AuthLoadigStates");
    return DioHelper.postdata(ConstantAPI.authenticationURL, {
      "api_key": ConstantAPI.paymentApiKey,
    }).then((value) {
      print(value);
      print("********************************");
      // print(value.data["token"]);
      ConstantAPI.firsToken = value.data["token"];
      // print("${ConstantAPI.firsToken}");
      print("AuthSuccessStates");
      emit(AuthSuccessStates());
    }).catchError((error) {
      print(error);
      emit(AuthErrorStates());
      print("AuthErrorStates");
    });
  }

  Future<void> GetOrderId({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? price,
  }) async {
    emit(OrderLoadigStates());
    print("OrderLoadigStates");
    print("${ConstantAPI.firsToken}");
    return DioHelper.postdata(ConstantAPI.orderURL, {
      "auth_token": ConstantAPI.firsToken,
      "delivery_needed": "false",
      "amount_cents": "100",
      "currency": "EGP",
      "items": [],
    }).then((value) {
      // print(value);
      // print("********************************");
      print("Order ID : ${value.data["id"]}");
      ConstantAPI.orderId = value.data["id"].toString();
      print("OrderSuccessStates");
      getPaymentRequest(
          firstname: firstname,
          lastname: lastname,
          email: email,
          phone: phone,
          price: price);
      emit(OrderSuccessStates());
    }).catchError((error) {
      print(error);
      emit(OrderErrorStates());
      print("OrderErrorStates ${error.toString()}");
    });
  }

  Future<void> getPaymentRequest({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? price,
  }) async {
    emit(GetPaymentRequestLoadiGetStates());
    print("GetPaymentRequestLoadiGetStates");
    DioHelper.postdata(ConstantAPI.paymentURL, {
      "auth_token": ConstantAPI.firsToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": ConstantAPI.orderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstname,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastname,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": ConstantAPI.integrationIdCard,
      "lock_order_when_paid": "false"
    })
        .then((value) => {
              // print(value.data),
              print("Final Token : ${value.data["token"]}"),
              ConstantAPI.finalToken = value.data["token"],
              // print("====================="),
              getRefCode(),
              print("GetPaymentRequestSuccessStates "),
              emit(GetPaymentRequestSuccessStates()),
            })
        .catchError((error) {
      print("GetPaymentRequestErrorStates ${error.toString()}");
      emit(GetPaymentRequestErrorStates());
    });
  }

  Future<void> getRefCode() async {
    print("GetRefCodeLoadiGetStates");
    emit(GetRefCodeLoadiGetStates());
    DioHelper.postdata(ConstantAPI.refCodeURL, {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": ConstantAPI.finalToken
    })
        .then((value) => {
              print("////////////////////////////////////////"),
              print(value.data),
              print(value.data["id"]),
              ConstantAPI.refCodeId = value.data["id"].toString(),
              print("GetRefCodeSuccessStates"),
              emit(GetRefCodeSuccessStates()),
            })
        .catchError((error) {
      print("GetRefCodeErrorStates ${error.toString()}");
      emit(GetRefCodeErrorStates());
    });
  }
}
