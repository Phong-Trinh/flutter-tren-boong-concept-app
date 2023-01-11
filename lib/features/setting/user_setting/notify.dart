import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    bool _noti = true;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 234, 146, 57),
        title: Text('Thông báo'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Text(
                //   "Nhận thông báo",
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: SwitchListTile(
                    activeColor: Colors.purple,
                    title: Text("Nhận thông báo"),
                    value: _noti,
                    onChanged: (bool value) {
                      setState(() {
                        _noti = value;
                        AppSettings.openNotificationSettings();
                      });
                    },
                    secondary: const Icon(Icons.notifications),
                  ),
                ),
                // Card(
                //   child: ListView(
                //     shrinkWrap: true,
                //     children: [
                //       ListTile(
                //         onTap: () {},
                //         title: Text('thong bao 1'),
                //       ),
                //       const Divider(
                //         color: Colors.brown,
                //       ),
                //       ListTile(
                //         onTap: () {},
                //         title: Text('thong bao 2'),
                //       ),
                //       const Divider(
                //         color: Colors.brown,
                //       ),
                //       ListTile(
                //         onTap: () {},
                //         title: Text('thong bao 3'),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            )),
      ),
    );
  }
}
