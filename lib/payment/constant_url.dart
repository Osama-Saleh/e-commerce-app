class ConstantAPI {
  static const String baseURL = "https://accept.paymob.com/api";
  static const String authenticationURL = "/auth/tokens";
  static const String paymentApiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2libUZ0WlNJNkltbHVhWFJwWVd3aUxDSndjbTltYVd4bFgzQnJJam8yT0RBd05qQjkuTk5ER2J0eWpRdm8wejhfb3pZRktZeXJBQmF5d1pzM0pCcHlwWklaUGtyYnpjdXkxZFJhU0VUd3pZdV9UcUFHRlJXYi1pRXRwazNHXzJrUVMtN2x2a0E=";
  static const String orderURL = "/ecommerce/orders";
  static const String paymentURL = "/acceptance/payment_keys";
  static const String refCodeURL = "/acceptance/payments/pay";
  static String visaUrl =
      '$baseURL/acceptance/iframes/724135?payment_token=$finalToken';
  // static String visaURL =
  //     "https://accept.paymob.com/api/acceptance/iframes/724135?payment_token=$finalToken";
  static String? firsToken = " ";
  static String? finalToken = " ";
  static String? orderId = " ";
  static String? refCodeId = " ";

  // static String integrationIdKiosk = "3342618";
  static String integrationIdCard = "3322236";

  //Images
  static const String visaImage =
      "https://cdn-icons-png.flaticon.com/512/349/349221.png";
  static const String refCodeImage =
      "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";
}
