import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 234, 146, 57),
        title: const Text("About us"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                onTap: () {},
                title: const Text("Thông tin nhà phát hành phần mềm"),
              ),
              const Divider(
                color: Colors.brown,
              ),
              ListTile(
                onTap: () {},
                title: const Text("Phiên bản ứng dụng: 1.0.1"),
              ),
              const Divider(
                color: Colors.brown,
              ),
              ListTile(
                onTap: () {},
                title: const Text(
                    "Trên Boong Concept | ComeBack, một sản phẩm của Micro 7"),
              ),
            ],
          )),
    );
  }
}
