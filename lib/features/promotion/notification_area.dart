import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationArea extends StatelessWidget {
  const NotificationArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
        margin: const EdgeInsets.fromLTRB(14, 10, 14, 30),
        decoration: const BoxDecoration(
            color: Color.fromARGB(174, 219, 142, 232),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(
            Icons.info,
            color: Color.fromARGB(255, 64, 23, 93),
            size: 20,
          ),
          SizedBox(width: 12),
          Flexible(
              child: Text(AppLocalizations.of(context)!.promoRemind,
                  style: TextStyle(
                      color: Color.fromARGB(255, 64, 23, 93),
                      fontWeight: FontWeight.w700,
                      fontSize: 16)))
        ]));
  }
}
