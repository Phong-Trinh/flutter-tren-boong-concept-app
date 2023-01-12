class NewsEntity {
  final String title;
  final String content;
  //final DateTime dateTime;

  NewsEntity({
    required this.title,
    required this.content,
  //  required this.dateTime,
  });
  factory NewsEntity.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final newfeed = attributes['newfeed'];
    var k = newfeed['data']['attributes']['tittle']['content'];
    print(newfeed['data']['attributes']['tittle']['content']);
    //print(' day la K'+k.toString());
    return NewsEntity(
        title: newfeed['data']['attributes']['tittle'],
      //  dateTime: DateTime(2022),
        content: newfeed['content']);
  }
  @override
  String toString() {
    // TODO: implement toString LastName :$dateTime}
    return """ 
    Title: $title
    FirstName :$content
    
    """;
  }
}
