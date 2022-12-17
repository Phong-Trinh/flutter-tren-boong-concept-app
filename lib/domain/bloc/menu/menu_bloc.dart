import 'package:flutter_bloc/flutter_bloc.dart';
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
        emit(MenuLoadSuccessState(products));
      } catch (e) {
        //do something
        emit(MenuLoadFailState());
      }
    });
  }

  final ProductRepository _productRepository;
}
