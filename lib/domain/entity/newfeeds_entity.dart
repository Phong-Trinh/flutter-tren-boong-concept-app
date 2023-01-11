class NewsEntity {
  final String title;
  final String content;
  final DateTime dateTime;

  NewsEntity({
    required this.title,
    required this.content,
    required this.dateTime,
    required enable,
  });
  factory NewsEntity.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final news = attributes['newfeed'];
    var k = news['data']['attributes']['tittle']['content'];
    print(news['data']['attributes']['tittle']['content']);
    return NewsEntity(
        title: news['data']['attributes']['tittle'],
        enable: attributes['available'],
        dateTime: DateTime(2022),
        content: news['content']);
  }
}
