class ProductEntity {
  final String id;
  final String name;
  final String imgUrl;
  final int price;
  final String type;
  bool available;

  ProductEntity(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.price,
      required this.type,
      required this.available});
  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    final product = json['attributes'];
    final type = product['type'];
    dynamic detailProduct;
    if (type == 'drink') {
      detailProduct = product['drink'];
    } else {
      detailProduct = product['card'];
    }
    return ProductEntity(
        id: json['id'].toString(),
        name: detailProduct['data']['attributes']['name'],
        imgUrl: detailProduct['data']['attributes']['urlImage'],
        price: int.parse(product['price']),
        type: type,
        available: true);
  }
}
