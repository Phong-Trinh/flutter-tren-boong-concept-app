import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/entity/category_entity.dart';
import 'package:tren_boong_concept/domain/entity/category_products_entity.dart';
import 'package:tren_boong_concept/domain/entity/product_entity.dart';

import '../../../infrastructure/repository/product_repository.dart';
import 'menu_event.dart';
import 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(MenuInitialState()) {
    on<LoadMenuEvent>((event, emit) async {
      emit(MenuLoadingState());
      try {
        var products = await _productRepository.getAllProduct();
        //emit(MenuLoadSuccessState(products));

        //test
        emit(MenuLoadSuccessState([
          CategoryProductsEntity(
              category:
                  CategoryEntity(id: '1', name: '1123123', imageUrl: '1223'),
              products: [
                ProductEntity(id: '1', name: '1', imgUrl: '1223', price: 45000)
              ])
        ]));
      } catch (e) {
        //do something
        //emit(MenuLoadFailState());
      }
      print('hihihi');
    });
  }

  final ProductRepository _productRepository;
}
