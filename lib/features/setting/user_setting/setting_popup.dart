import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_state.dart';
import 'package:tren_boong_concept/domain/entity/user_entity.dart';
import 'package:tren_boong_concept/features/setting/user_setting/user_setting_view.dart';

import '../../../domain/bloc/authentication/authentication_event.dart';
import '../../news/news.dart';
import 'about_us.dart';
import 'notify.dart';

class SettingPopup extends StatefulWidget {
  @override
  State<SettingPopup> createState() => _SettingPopupState();
}

class _SettingPopupState extends State<SettingPopup> {
  bool _noti = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Đăng xuất',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: const SingleChildScrollView(
              child: Text('Bạn thật sự muốn đăng xuất khỏi tài khoản?'),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('BỎ QUA'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('ĐĂNG XUẤT'),
                onPressed: () {
                  // call Logout Function here
                  context.read<AuthenticationBloc>().add(SignoutUserEvent());
                },
              ),
            ],
          );
        },
      );
    }

    late UserEntity? _user;

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        _user = state.user;
        return Container(
          color: Colors.grey[300],
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          "Tài Khoản",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Điểm tích lũy :  ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        state.user!.score.toString(),
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 25,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          "assets/icon/point-coin.png",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        "Đưa mã này cho nhân viên của bạn",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                        height: 5,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          width: 350,
                          height: 100,
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: BarcodeWidget(
                              barcode: Barcode.codabar(),
                              data: state.user!.id,
                              errorBuilder: (context, error) =>
                                  Center(child: Text(error)),
                            ),
                            width: 300,
                            height: 80,
                          )),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserSettingDetail()));
                                  },
                                  leading: const Icon(Icons.account_circle),
                                  title: const Text("Thông tin cá nhân"),
                                  trailing: InkWell(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.brown,
                                ),
                                ListTile(
                                  leading: Icon(Icons.notifications),
                                  title: Text("Thông báo"),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Notify()));
                                  },
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ),
                                const Divider(
                                  color: Colors.brown,
                                ),
                                ListTile(
                                  leading: Icon(Icons.event),
                                  title: Text("Tin tức"),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyNews()));
                                  },
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ),
                                const Divider(
                                  color: Colors.brown,
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AboutUs()));
                                  },
                                  leading: const Icon(Icons.details),
                                  title: const Text("Giới thiệu"),
                                  trailing: InkWell(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          Text(
                            'Khác',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const ListTile(
                                  leading: Icon(Icons.help),
                                  title: Text("Trợ gúp & Hỗ trợ"),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ),
                                const Divider(
                                  color: Colors.brown,
                                ),
                                const Divider(
                                  color: Colors.brown,
                                ),
                                ListTile(
                                  onTap: () {
                                    _showMyDialog();
                                  },
                                  leading: const Icon(Icons.logout),
                                  title: const Text("Đăng xuất"),
                                  trailing: InkWell(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
