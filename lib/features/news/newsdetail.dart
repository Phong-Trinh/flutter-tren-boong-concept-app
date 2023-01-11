import 'package:flutter/material.dart';

import '../../domain/entity/newfeeds_entity.dart';
import '../../utility/formater.dart';
import 'newsDate.dart';
import 'news_infor.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail({super.key, required this.news});
  final NewsEntity news;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(children: [
          NewsInfor(
            title: news.title,
            details: [
              'tieu de',
            ],
          ),
          Divider(height: 10, thickness: 0.4),
          NewsDate(date: 'date', icon: Icons.access_time_filled_rounded)
        ]));
  }
}
