class NewsEntity {
  final String title;
  final String content;
  final String dateTime;

  NewsEntity({
    required this.title,
    required this.content,
    required this.dateTime,
  });
  factory NewsEntity.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return NewsEntity(
        title: attributes['title'] ?? "",
        dateTime: attributes['date'] ?? "",
        content: attributes['content'] ?? "");
  }
  static List<NewsEntity> fromListJson(List<dynamic> json) {
    if (json.isEmpty) return [];
    return json.map((e) => NewsEntity.fromJson(e)).toList();
  }

  @override
  String toString() {
    // TODO: implement toString LastName :$dateTime}
    return """ 
    Title: $title
    Content :$content
    DateTime :$dateTime
    """;
  }
}
