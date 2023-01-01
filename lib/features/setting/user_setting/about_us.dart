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
        title: Text('aboutUs'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.location_city),
                        title: Text('343/5 Tô Hiến Thành, Phường 12, Quận 10, Ho Chi Minh City, VietNam'),
                      ),
                      const Divider(
                        color: Colors.brown,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.email),
                        title: Text('trenboongconcept@gmail.com'),
                      ),
                      const Divider(
                        color: Colors.brown,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.facebook),
                        title: Text('facebook.com/trenboongconcept'),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.update),
                        title: Text('Phiên bản ứng dụng: 1.0.1'),
                      ),
                      const Divider(
                        color: Colors.brown,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.details),
                        title: Text('Trên Boong Concept 1 sản phẩm của Micro 7'),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
