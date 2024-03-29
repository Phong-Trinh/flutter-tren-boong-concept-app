import 'package:flutter/material.dart';
import 'package:tren_boong_concept/features/news/newsdetail.dart';
import '../../domain/entity/newfeeds_entity.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key, required this.news});
  final List<NewsEntity> news;

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var news in widget.news)
            GestureDetector(
                onTap: () {},
                child: NewsDetail(
                  news: news,
                ))
        ]));
  }
}
