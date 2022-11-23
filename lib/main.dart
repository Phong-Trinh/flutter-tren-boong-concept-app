import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_state.dart';
import 'domain/bloc/authentication/authentication_bloc.dart';
import 'domain/bloc/authentication/authentication_event.dart';
import 'features/authen/sign_in/signin_screen.dart';
import 'features/home/home.dart';
import 'infrastructure/repository/user_repository.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('lato_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['lato_fonts'], license);
  });
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                    debugShowCheckedModeBanner: false,
                    home: Login_Screen(),
                  );
                }
                if (state is AuthenticatedState) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: HomePage(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )));
  }
}
