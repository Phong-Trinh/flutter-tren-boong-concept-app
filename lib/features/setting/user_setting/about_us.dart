import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 234, 146, 57),
        title: Text(AppLocalizations.of(context)!.aboutUs),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                onTap: () {},
                title: Text(AppLocalizations.of(context)!.devInFo),
              ),
              const Divider(
                color: Colors.brown,
              ),
              ListTile(
                onTap: () {},
                title: Text(AppLocalizations.of(context)!.version),
              ),
              const Divider(
                color: Colors.brown,
              ),
              ListTile(
                onTap: () {},
                title: Text(AppLocalizations.of(context)!.trenBoongConcept),
              ),
            ],
          )),
    );
  }
}
