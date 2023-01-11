import 'dart:convert';
import '../../domain/entity/newfeeds_entity.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static Future<List<NewsEntity>> getNews(String id) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}/user-coupons?filters[app_user][id][\$eq]=${id}&populate=*');
      var response = await http.get(url);
      print(url);
      if (response.statusCode == 200) {
        print(response.body);
        List<NewsEntity> news = praseNewsFromJson(response.body);
        return news;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  static List<NewsEntity> praseNewsFromJson(String json) {
    Map<String, dynamic> parsed = jsonDecode(json);
    final newsJson = parsed['data'];
    List<NewsEntity> news = [];
newsJson.forEach((news) => news.add(NewsEntity.fromJson(news)));
    return news;
  }
}
