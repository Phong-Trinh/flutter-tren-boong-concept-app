import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/order/order_bloc.dart';
import '../../domain/bloc/order/order_event.dart';
import '../../domain/entity/category_products_entity.dart';
import '../../domain/entity/product_entity.dart';
import '../../utility/formater.dart';

class MenuProduct extends StatefulWidget {
  const MenuProduct({super.key, required this.categories});

  final List<CategoryProductsEntity> categories;

  @override
  State<MenuProduct> createState() => _MenuProductState();
}

class _MenuProductState extends State<MenuProduct> {
  late List<CategoryProductsEntity> drinkCategories;
  late CategoryProductsEntity cardCategory;
  @override
  void initState() {
    super.initState();
    cardCategory = widget.categories.removeLast();
    drinkCategories = widget.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var category in drinkCategories) ...[
            if (category.products.isNotEmpty)
              Text(category.category.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20, height: 4)),
            for (var item in category.products)
              detailDrinkProduct(context, item)
          ],
          if (cardCategory.products.isNotEmpty)
            Text(cardCategory.category.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 20, height: 4)),
          for (var item in cardCategory.products)
            detailCardProduct(context, item)
        ]));
  }

  Widget detailDrinkProduct(BuildContext context, ProductEntity item) {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        height: 130,
        child: Stack(children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(3), // Image border
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(65), // Image radius
                      child: Image.network(item.imgUrl, fit: BoxFit.cover))),
              const SizedBox(width: 12),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.8)),
                    Text(Formater.vndFormat(item.price),
                        style: const TextStyle(fontSize: 16, height: 1.4))
                  ]))
            ],
          ),
          GestureDetector(
              onTap: () {
                context.read<OrderBloc>().add(AddProductItem(item));
              },
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10, right: 10),
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 234, 146, 57)),
                      child: const Icon(Icons.add, color: Colors.white))))
        ]));
  }

  Widget detailCardProduct(BuildContext context, ProductEntity item) {
    return Container(
        height: 130,
        child: Stack(children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(3), // Image border
                  child: SizedBox(
                      width: 78,
                      child: Image.network(item.imgUrl, fit: BoxFit.fill))),
              const SizedBox(width: 12),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const SizedBox(height: 10),
                    Text(item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.8)),
                    Text(Formater.vndFormat(item.price),
                        style: const TextStyle(fontSize: 16, height: 1.4))
                  ]))
            ],
          ),
          GestureDetector(
              onTap: () {
                if (item.available) {
                  context.read<OrderBloc>().add(AddProductItem(item));
                  setState(() {
                    item.available = false;
                  });
                  print(item.available);
                }
              },
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10, right: 10),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.available
                              ? const Color.fromARGB(255, 234, 146, 57)
                              : const Color.fromARGB(255, 74, 73, 72)),
                      child: const Icon(Icons.add, color: Colors.white))))
        ]));
  }
}
