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
  static const maxCount = 100;
  static const double maxHeight = 1000;
  final random = math.Random();
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
    randomList = List.generate(maxCount,
        (index) => <int>[index, (maxHeight * random.nextDouble()).toInt()]);
    return BlocBuilder<MenuBloc, MenuState>(
        builder: (BuildContext context, MenuState state) {
      if (state is MenuLoadSuccessState) {
        return ListView(
          shrinkWrap: true,
          scrollDirection: scrollDirection,
          controller: controller,
          children: []
            ..add(AutoScrollTag(
                key: ValueKey(10),
                controller: controller,
                index: 10,
                child: Container(height: 50, color: Colors.red)))
            ..insert(
                0,
                IconButton(
                  onPressed: () {
                    _scrollToCounter(counter++);
                  },
                  icon: Text('First'),
                ))
            ..insert(
                0,
                MenuCategory(
                    categories: state.products.map((e) => e.category).toList()))
            ..insert(
                2,
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
