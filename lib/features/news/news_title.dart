import 'package:flutter/material.dart';

class NewsInfor extends StatelessWidget {
  String title;
  List<String> details;

  NewsInfor({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, top: 10, bottom: 15, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    wordSpacing: 1.6,
                    fontSize: 20)),
            for (var i in details)
              Container(
                  height: 32,
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 0.0, right: 0.0),
                    minLeadingWidth: 10,
                    minVerticalPadding: 10,
                    horizontalTitleGap: 8,
                    leading: Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                    ),
                    title: Text(i,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            wordSpacing: 0)),
                  ))
          ],
        ));
  }
}
