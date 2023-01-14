import 'dart:convert';
import '../../domain/entity/newfeeds_entity.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static Future<List<NewsEntity>> getNews() async {
    try {
      var url = Uri.parse('${ApiConstant.baseUrl}/new-feeds');
      var response = await http.get(url);
      print(url);
      if (response.statusCode == 200) {
        print(response.body);
        List<NewsEntity> news = praseNewsFromJson(response.body);
        print("hello world :${news.toString()}");
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
    List<NewsEntity> news = NewsEntity.fromListJson(newsJson);
    return news;
  }
}
