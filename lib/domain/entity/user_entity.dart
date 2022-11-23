class UserEntity {
  final String id;
  final String name;
  final String phoneNumber;
  final String countryCode;

  UserEntity(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.countryCode});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return UserEntity(
      id: json['id'].toString(),
      name: attributes['name'] as String,
      phoneNumber: attributes['phoneNumber'] as String,
      countryCode: attributes['name'] as String,
    );
  }
}
