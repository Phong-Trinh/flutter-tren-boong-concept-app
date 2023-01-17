import 'package:flutter/material.dart';
import '../widgets/shimmer_loading/card_list_item.dart';

class ShimmerNews extends StatelessWidget {
  const ShimmerNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 16),
          for (var i in [1, 2, 3, 4, 5, 6, 7])
            Container(
                margin: EdgeInsets.only(top: 12),
                height: 150,
                child: CardListItem())
        ]));
  }
}
