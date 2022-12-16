import 'package:flutter/material.dart';

import '../../domain/entity/category_entity.dart';

class MenuCategory extends StatelessWidget {
  const MenuCategory({super.key, required this.categories});
  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 1 / 1.3,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        crossAxisSpacing: 25,
        mainAxisSpacing: 15,
        crossAxisCount: 4,
        children: <Widget>[
          for (var category in categories)
            Column(children: [
              Expanded(
                  child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(category.imageUrl),
                      fit: BoxFit.cover,
                    )),
              )),
              SizedBox(height: 5),
              Text(category.name, style: TextStyle(fontSize: 12)),
            ]),
          // Column(children: [
          //   Expanded(
          //       child: Container(
          //     height: 100,
          //     width: 100,
          //     decoration: BoxDecoration(
          //         border: Border.all(
          //             width: 0.7, color: Color.fromARGB(255, 191, 186, 186)),
          //         shape: BoxShape.circle,
          //         image: DecorationImage(
          //           image: AssetImage("assets/images/category/more-option.png"),
          //           fit: BoxFit.cover,
          //         )),
          //   )),
          //   SizedBox(height: 5),
          //   Text('Xem thêm', style: TextStyle(fontSize: 12))
          // ])
        ]);
  }
}
