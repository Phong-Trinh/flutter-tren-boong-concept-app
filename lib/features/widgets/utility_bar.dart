import 'package:flutter/material.dart';
import '../pop_up/list_card.dart';
import '../pop_up/menu.dart';
import '../promotion/promotion.dart';
import '../setting/user_setting/setting_popup.dart';
import 'pop_over.dart';

class UtilityBar extends StatefulWidget {
  UtilityBar({super.key, required this.scaffoldKey});

  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<UtilityBar> createState() => _UtilityBarState();
}

class _UtilityBarState extends State<UtilityBar> with TickerProviderStateMixin {
  PersistentBottomSheetController? persistentBottomSheetController;
  late AnimationController controller;
  bool pressHome = true;
  bool pressOrder = true;
  bool pressPromotion = true;
  bool pressSetting = true;

  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 500);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (persistentBottomSheetController != null) {
    //   persistentBottomSheetController!.closed
    //       .then((value) => print('close ne ck'));
    // }
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: ("Change card"),
            color: pressHome ? Colors.black : Colors.green[700],
            onPressed: () {
              setState(() {
                pressHome = false;
                pressOrder = true;
                pressPromotion = true;
                pressSetting = true;
                persistentBottomSheetController =
                    widget.scaffoldKey.currentState!.showBottomSheet(
                        (context) => const Popover(child: ListCard()));
                
              });
            },
          ),
          IconButton(
              tooltip: ("Orders"),
              icon: const Icon(Icons.shopping_bag),
              color: pressOrder ? Colors.black : Colors.green[700],
              onPressed: () {
                setState(() {
                  pressOrder = false;
                  pressHome = true;
                  pressPromotion = true;
                  pressSetting = true;
                  persistentBottomSheetController =
                      widget.scaffoldKey.currentState!.showBottomSheet(
                          (context) => const Popover(child: MenuPopup() ));
                });
              }
              // child: Text("Orders")
              ),
          IconButton(
              icon: const Icon(Icons.videogame_asset),
              tooltip: ("promotion"),
              color: pressPromotion ? Colors.black : Colors.green[700],
              onPressed: () {
                setState(() {
                  pressPromotion = false;
                  pressHome = true;
                  pressSetting = true;
                  pressOrder = true;
                  persistentBottomSheetController =
                      widget.scaffoldKey.currentState!.showBottomSheet(
                          (context) => Popover(child: PromotionPopup()));
                });
              }),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: ("setting"),
            color: pressSetting ? Colors.black : Colors.green[700],
            onPressed: () {
              setState(() {
                pressSetting = false;
                pressHome = true;
                pressPromotion = true;
                pressOrder = true;
                widget.scaffoldKey.currentState!.showBottomSheet(
                    (context) => Popover(child: SettingPopup()));
              });
            },
          ),
          // widget,
        ],
      ),
    );
  }
}
