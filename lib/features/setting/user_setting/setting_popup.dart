import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_bloc.dart';
import 'package:tren_boong_concept/features/setting/user_setting/setlang.dart';
import 'package:tren_boong_concept/features/setting/user_setting/user_setting_view.dart';
import '../../../domain/bloc/authentication/authentication_event.dart';
import 'about_us.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPopup extends StatefulWidget {
  @override
  State<SettingPopup> createState() => _SettingPopupState();
}

class _SettingPopupState extends State<SettingPopup> {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.signOut,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              child: Text(AppLocalizations.of(context)!.wantToLogOut),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.skip),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.signOut),
                onPressed: () {
                  context.read<AuthenticationBloc>().add(SignoutUserEvent());
                },
              ),
            ],
          );
        },
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    AppLocalizations.of(context)!.setting,
                    style: TextStyle(
                        fontSize: 16,
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
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserSettingDetail()));
                      },
                      leading: const Icon(Icons.account_circle),
                      title: Text(AppLocalizations.of(context)!.account),
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
                      onTap: () {},
                      leading: Icon(Icons.notifications),
                      title: Text(AppLocalizations.of(context)!.notification),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                    // const Divider(
                    //   color: Colors.brown,
                    // ),
                    // ListTile(
                    //   onTap: () {},
                    //   leading: Icon(Icons.security_rounded),
                    //   title: Text(
                    //     AppLocalizations.of(context)!.privacyAndSecurity,
                    //   ),
                    //   trailing: Icon(
                    //     Icons.arrow_forward_ios,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    const Divider(
                      color: Colors.brown,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AboutUs()));
                      },
                      leading: const Icon(Icons.details),
                      title: Text(AppLocalizations.of(context)!.aboutUs),
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SetLang()));
                      },
                      leading: Icon(Icons.menu),
                      title: Text(AppLocalizations.of(context)!.more),
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
                        _showMyDialog();
                      },
                      leading: const Icon(Icons.logout),
                      title: Text(AppLocalizations.of(context)!.signOut),
                      trailing: InkWell(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
