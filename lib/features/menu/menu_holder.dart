import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../domain/bloc/menu/menu_bloc.dart';
import '../../../domain/bloc/menu/menu_state.dart';
import 'menu_category.dart';
import 'menu_product.dart';
import 'shimmer_category.dart';
import 'shimmer_product.dart';

class MenuHolder extends StatelessWidget {
  MenuHolder({super.key});
  final scrollDirection = Axis.vertical;
  late AutoScrollController controller;
  late List<List<int>> randomList;
  int counter = -1;
  @override
  Widget build(BuildContext context) {
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    return BlocBuilder<MenuBloc, MenuState>(
        builder: (BuildContext context, MenuState state) {
      if (state is MenuLoadSuccessState) {
        return ListView(
          shrinkWrap: true,
          scrollDirection: scrollDirection,
          controller: controller,
          children: []
            ..insert(
                0,
                MenuCategory(
                    categories: state.products.map((e) => e.category).toList(),
                    onCategoryClick: (index) => _scrollToCounter(index)))
            ..insert(
                1,
                MenuProduct(
                    categories: state.products, controller: controller)),
        );
      }
      return ListView(children: const [
        ShimmerCategory(),
        ShimmerProduct(),
        SizedBox(height: 120)
      ]);
    });
  }

  Future _scrollToCounter(int index) async {
    await controller.scrollToIndex(index,
        duration: Duration(seconds: 2),
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(1000);
  }
}
