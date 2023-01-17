import 'package:flutter/material.dart';
import '../../domain/entity/newfeeds_entity.dart';
import 'news_date.dart';
import 'news_title.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail({super.key, required this.news});
  final NewsEntity news;

  @override
  Widget build(BuildContext context) {
    Future<void> _showNewsDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Nội dung sự kiện',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              child: NewsInfor(
                title: news.title,
                details: [news.content],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Đóng',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: GestureDetector(
          onTap: () {
            _showNewsDialog();
          },
          child: Card(
            child: Column(children: [
              NewsInfor(
                title: news.title,
                details: [],
              ),
              TextButton(
                  onPressed: () {
                    _showNewsDialog();
                  },
                  child: Text(
                    "Chi tiết",
                    style: TextStyle(fontSize: 20),
                  )),
              const Divider(height: 10, thickness: 1),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text("Thời gian diễn ra: ",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  NewsDate(date: news.dateTime, icon: Icons.timeline),
                ],
              )
            ]),
          ),
        ));
  }
}
