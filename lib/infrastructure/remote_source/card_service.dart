import 'dart:convert';
import 'dart:developer';
import 'package:tren_boong_concept/domain/entity/card_entity.dart';
import '../../domain/entity/product_entity.dart';
import '../../utility/save_data.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

class CardService {
  static Future<List<CardEntity>> getCardsByUser(String id) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}/user-cards?populate=deep,2&filters[app_user][id][\$eq]=${id}');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<CardEntity> card = praseCardsFromJson(response.body);
        print(card.length);
        return card;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  static Future<CardEntity?> getLastedCardByUser(String id) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.usersEndpoint}?populate=deep,2&filters[app_user][id][\$eq]=$id');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        //CardEntity? card = praseCardFromJson(response.body);
        //return card;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<void> checkCardAvailable(String id, ProductEntity item) async {
    var url = Uri.parse(
        '${ApiConstant.baseUrl}/user-cards?filters[\$and][0][card][id][\$eq]=${id}&filters[\$and][1][app_user][id][\$eq]=${SaveData.userId}');
    var response = await http.get(url);
    if (SaveData.selectedCardProducts.contains(item.id)) {
      item.available = false;
    }
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['data'].length != 0) {
          print(data['data'].length.toString());
          item.available = false;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> createUserCard() async {}

  static List<CardEntity> praseCardsFromJson(String json) {
    Map<String, dynamic> parsed = jsonDecode(json);
    final data = parsed['data'];
    List<CardEntity> cards = [];
    data.forEach((card) =>
        cards.add(CardEntity.fromJson(card['attributes']['card']['data'])));
    return cards;
  }
}
