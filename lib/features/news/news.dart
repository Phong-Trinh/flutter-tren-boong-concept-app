import 'package:flutter/widgets.dart';

class MyNews extends StatefulWidget {
  const MyNews({super.key});

  @override
  State<MyNews> createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: SingleChildScrollView(
            child: Column(
      children: const [],
    )));
  }
}
