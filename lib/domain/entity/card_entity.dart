class CardEntity {
  final String id;
  final String name;
  final String urlImage;

  CardEntity({required this.id, required this.name, required this.urlImage});

  factory CardEntity.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return CardEntity(
      id: json['id'].toString(),
      name: attributes['name'],
      urlImage: attributes['urlImage'],
    );
  }
}
