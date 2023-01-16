import '../../domain/entity/newfeeds_entity.dart';
import '../remote_source/news_service.dart';

class NewsRepository {
  Future<List<NewsEntity>> fetchNews() async {
    return await NewsService.getNews();
  }
}
