import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tren_boong_concept/features/setting/user_setting/user_setting_view.dart';

class SettingPopup extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SizedBox(
                  width: 50,
                  height: 50,
                ),
                Text("Cài Đặt",style: TextStyle(
                    fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  width: 50,
                  height: 50,
                ),
              ],
            ),),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text("Tài khoản"),
                    trailing: InkWell(child: const Icon(Icons.arrow_forward_ios,color: Colors.black,),onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserSettingDetail()));
                    },),
                  ),
                  const Divider(color: Colors.brown,),
                  const ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text("Thông báo"),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                  const  Divider(color: Colors.brown,),
                  const ListTile(
                    leading: Icon(Icons.language),
                    title: Text("Ngôn ngữ"),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                  const  Divider(color: Colors.brown,),
                  const ListTile(
                    leading: Icon(Icons.security_rounded),
                    title: Text("Quyền riêng tư & Bảo mật"),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                  const Divider(color: Colors.brown,),
                  const ListTile(
                    leading: Icon(Icons.help),
                    title: Text("Trợ gúp & Hỗ trợ"),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                  const Divider(color: Colors.brown,),
                  const ListTile(
                    leading: Icon(Icons.details),
                    title: Text("Giới thiệu"),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }




}