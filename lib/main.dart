import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_state.dart';
import 'package:uni_links/uni_links.dart';
import 'domain/bloc/authentication/authentication_bloc.dart';
import 'domain/bloc/authentication/authentication_event.dart';
import 'features/authen/sign_in/signin_screen.dart';
import 'features/home/home.dart';
import 'features/loading/loading_screen.dart';
import 'features/order/order_result.dart';
import 'firebase_options.dart';
import 'infrastructure/repository/user_repository.dart';
import 'utility/save_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  StreamSubscription? _sub;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _listenMessage();
    _handleIncomingLinks();
  }

  void _listenMessage() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'notification_icon',
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print("Notification Opened");
    });
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
                  return MaterialApp(
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: _locale,
                    debugShowCheckedModeBanner: false,
                    home: LoginScreen(),
                  );
                }
                if (state is AuthenticatedState) {
                  return MaterialApp(
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: _locale,
                    home: const HomePage(),
                  );
                }
                return LoadingScreen();
              },
            )));
  }
}
