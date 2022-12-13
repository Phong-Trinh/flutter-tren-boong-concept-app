import 'dart:convert';

class ApiConstant {
  static String baseUrl = 'http://192.168.1.9:1337/api';
  static String usersEndpoint = '/app-users';
  static String drinkCategoryEndpoint = '/drink-categories';
  static String productsEndpoint = '/products';
  static String populateParam = 'populate';

  static Map<String, dynamic> praseJsonFromBody(String body) {
    Map<String, dynamic> parsed = jsonDecode(body);
    return parsed;
  }
}
