import 'dart:convert';
import '../../domain/entity/product_entity.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

import 'card_service.dart';

class ProductService {
  static Future<List<ProductEntity>> getProductsByCategoryId(String id) async {
    try {
      //url sort by category
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.productsEndpoint}?filters[drink][drink_category][id][\$eq]=${id}&populate=deep,3');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ProductEntity> products = praseProductFromJson(response.body);
        return products;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List<ProductEntity>> getAllCardProducts() async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.productsEndpoint}?filters[type][\$eq]=card&populate=deep,3');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ProductEntity> products = praseProductFromJson(response.body);
        List<String> ids = getListCardIdFromProductJson(response.body);
        await Future.wait(products.map((element) =>
            CardService.checkCardAvailable(
                ids[products.indexOf(element)], element)));
        return products;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  static List<String> getListCardIdFromProductJson(String json) {
    Map<String, dynamic> parsed = jsonDecode(json);
    final productsJson = parsed['data'];
    List<String> ids = [];

    productsJson.forEach((product) =>
        ids.add(product['attributes']['card']['data']['id'].toString()));
    return ids;
  }

  static List<ProductEntity> praseProductFromJson(String json) {
    Map<String, dynamic> parsed = jsonDecode(json);
    final productsJson = parsed['data'];
    List<ProductEntity> products = [];
    productsJson
        .forEach((product) => products.add(ProductEntity.fromJson(product)));
    return products;
  }
}
