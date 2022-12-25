import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_bloc.dart';
import '../../domain/bloc/authentication/authentication_event.dart';
import '../../domain/bloc/main_card/main_card_bloc.dart';
import '../../domain/bloc/main_card/main_card_event.dart';
import '../../domain/bloc/order/order_bloc.dart';
import '../../domain/bloc/order/order_event.dart';
import '../../infrastructure/repository/card_repository.dart';
import '../../infrastructure/repository/order_repository.dart';
import '../../utility/save_data.dart';
import '../order/short_order_bar.dart';
import '../widgets/utility_bar.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<String> _tokenStream;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String get hostname {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8888';
    } else {
      return 'http://localhost:1337';
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = SaveData.scaffoldKey;
  int currentPageIndex = 0;

  void _changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      //TODO: Get APN Key from Firebase
      FirebaseMessaging.instance
          .getToken(
              vapidKey:
                  'BBcLNMIPgQr7pfkAb8PagpcxRRZyd4y8mSBQkUiWUbezwIlymMA7PlX5DXyGILOmdl1RIAICrMqdvt1QiyCcrKA')
          .then(setToken);
    } else {
      //If Running android
      FirebaseMessaging.instance.getToken().then(setToken);
    }

    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  Future<void> setToken(String? token) async {
    print(token);
    context.read<AuthenticationBloc>().add(UpdateDeveiceFcmToken(token!));
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CardRepository>(
              create: (context) => CardRepository()),
          RepositoryProvider<OrderRepository>(
              create: (context) => OrderRepository())
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<MainCardBloc>(
                  create: (context) => MainCardBloc(
                      cardRepository: context.read<CardRepository>())
                    ..add(GetCardEvent())),
              BlocProvider<OrderBloc>(
                  create: (context) => OrderBloc(
                      orderrepository: context.read<OrderRepository>())
                    ..add(LoadOrderEvent()))
            ],
            child: SafeArea(
                child: Scaffold(
                    key: _scaffoldKey,
                    persistentFooterAlignment:
                        AlignmentDirectional.bottomCenter,
                    persistentFooterButtons: const [ShortOrderBar()],
                    bottomNavigationBar: UtilityBar(scaffoldKey: _scaffoldKey),
                    body: const HomeScreen()))));
  }
}
