import '../../domain/entity/category_entity.dart';
import '../../domain/entity/category_products_entity.dart';
import '../remote_source/card_service.dart';
import '../remote_source/drink_category_service.dart';
import '../remote_source/product_service.dart';
import 'card_repository.dart';

class ProductRepository {
  Future<List<CategoryProductsEntity>> getAllProduct() async {
    List<CategoryProductsEntity> products = [];
    List<CategoryEntity> categories =
        await DrinkCategoryService.getAllCategory();

    await Future.wait(categories.map((category) async => {
          products.add(CategoryProductsEntity(
              category: category,
              products:
                  await ProductService.getProductsByCategoryId(category.id)))
        }));

    products.add(CategoryProductsEntity(
        category: CategoryEntity(
            id: '1000',
            name: 'Thẻ bài',
            imageUrl:
                'https://en.onepiece-cardgame.com/images/beginners/cards/card_leader.png'),
        products: await ProductService.getAllCardProducts()));
    return products;
  }
}
