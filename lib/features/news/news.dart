import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tren_boong_concept/features/news/newsholder.dart';

class MyNews extends StatefulWidget {
  const MyNews({super.key});

  @override
  State<MyNews> createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 234, 146, 57),
          title: Text("Tin tức sự kiện")),
      body: Material(
        child: Container(
          color: Colors.grey[300],
          child: Expanded(
              child: SingleChildScrollView(
                  child: Column(
            children: const [NewsHolder()],
          ))),
        ),
      ),
    );
  }
}
