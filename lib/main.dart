import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_state.dart';
import 'package:tren_boong_concept/features/notifications/fcm_notifications.dart';
import 'package:uni_links/uni_links.dart';
import 'domain/bloc/authentication/authentication_bloc.dart';
import 'domain/bloc/authentication/authentication_event.dart';
import 'features/authen/sign_in/signin_screen.dart';
import 'features/home/home.dart';
import 'features/loading/loading_screen.dart';
import 'features/order/order_result.dart';
import 'firebase_options.dart';
import 'infrastructure/repository/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utility/save_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('lato_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['lato_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseCloudMessagingNotifications firebaseCloudMessagingNotifications = FirebaseCloudMessagingNotifications();

  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  StreamSubscription? _sub;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingNotifications.pushFCMToken();
    firebaseCloudMessagingNotifications.initMessaging(context);
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        if (uri!.queryParameters['resultCode'].toString() == '0') {
          print(uri.queryParameters['resultCode'].toString());
          SaveData.isPaymentSuccess = true;
          navigatorKey.currentState
              ?.push(MaterialPageRoute(builder: (context1) => OrderResult()));
        } else {
          SaveData.isPaymentSuccess = false;
        }
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => UserRepository(),
        child: BlocProvider(
            create: (context) => AuthenticationBloc(
                userRepository: context.read<UserRepository>())
              ..add(CheckLoginEvent()),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (BuildContext context, AuthenticationState state) {
                if (state is UnauthenticatedState) {
                  return const MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: LoginScreen(),
                  );
                }
                if (state is AuthenticatedState) {
                  return MaterialApp(
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: false,
                    home: const HomePage(),
                  );
                }
                return LoadingScreen();
              },
            )));
  }
}
