import 'package:flutter/material.dart';

class NotiNewsArea extends StatelessWidget {
  const NotiNewsArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
        margin: const EdgeInsets.fromLTRB(14, 10, 14, 30),
        decoration: const BoxDecoration(
            color: Color.fromARGB(173, 142, 232, 195),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Icon(
            Icons.info,
            color: Color.fromARGB(255, 23, 93, 62),
            size: 20,
          ),
          SizedBox(width: 12),
          Flexible(
              child: Text(
                  'Danh sách các sự kiện sắp diễn ra tại Trên Boong Concept.',
                  style: TextStyle(
                      color: Color.fromARGB(255, 23, 93, 92),
                      fontWeight: FontWeight.w700,
                      fontSize: 16)))
        ]));
  }
}
