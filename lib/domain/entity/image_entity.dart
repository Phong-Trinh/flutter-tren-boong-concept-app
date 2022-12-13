class ImageEntity {
    int id;
    String name;
    String url;

    ImageEntity({this.id = 48,this.name = 'image_0', this.url = 'https://res.cloudinary.com/dm0oa780b/image/upload/v1670740033/default_avatar_profile_icon_vector_social_media_user_image_182145777_ffabccdd80.jpg?updated_at=2022-12-11T06:27:14.181Z'});


    Map<String, dynamic> toJson() =>
        {
          'data' :{
            'images' :{
              'data':{
                'attributes':{
                  'url' : url,
                  'name' : name,
                }
              }
            }
          }
        };

    static List<ImageEntity> fromListJson(List<dynamic> json) {
      if (json.isEmpty) return [];

      return json.map((e) => ImageEntity.fromJsonImage(e)).toList();
    }

    factory ImageEntity.fromJsonImage(Map<String,dynamic> json){
      return ImageEntity(
        id: json['id'] as int,
        name: json['name'] as String,
        url:  json['url'] as String,);
    }

    factory ImageEntity.fromJson(Map<String, dynamic> json) {
      final attributes = json['data']['attributes'];
      return ImageEntity(
          id: json['data']['id'] as int,
          name: attributes['name'] as String,
          url:  attributes['url'] as String,);
    }


    @override
  String toString() {
    // TODO: implement toString
    return """
    id :$id,
    URL :$url,
    NAME :$name
    """;
  }

}