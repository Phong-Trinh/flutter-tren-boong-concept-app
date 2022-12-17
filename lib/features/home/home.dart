import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = SaveData.scaffoldKey;
  int currentPageIndex = 0;

  void _changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
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
