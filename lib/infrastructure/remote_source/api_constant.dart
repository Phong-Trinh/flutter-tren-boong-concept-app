import 'dart:convert';

class ApiConstant {
  static String baseUrl = 'https://boiling-waters-91078.herokuapp.com/api';
  static String usersEndpoint = '/app-users';
  static String drinkCategoryEndpoint = '/drink-categories';
  static String productsEndpoint = '/products';
  static String populateParam = 'populate';

  static Map<String, dynamic> praseJsonFromBody(String body) {
    Map<String, dynamic> parsed = jsonDecode(body);
    return parsed;
  }
}
