import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/Services/AppLocalization.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/RegisterPage.dart';
import 'Constants/Colors.dart';

void main() async {
  await loadConfiguration();
  final repo = AuthRepository();
  runApp(BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(repo)..add(AuthenticationStarted());
      },
      child: MyApp(repo)));
}

Future loadConfiguration() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isProduction = bool.fromEnvironment('dart.vm.product');
  if (isProduction) {
    await GlobalConfiguration().loadFromAsset("configurationprod");
  } else {
    await GlobalConfiguration().loadFromAsset("configuration");
  }
}

class MyApp extends StatelessWidget {
  final AAuthRepository repo;
  final AppLocalizationDelegate _localeOverrideDelegate = AppLocalizationDelegate(Locale('hu', 'HU'));
  MyApp(this.repo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _localeOverrideDelegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('hu', 'HU')
      ],
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationSucceeded) {
          return HomePage(repo);
        } else if (state is AuthenticationExited) {
          return LoginPage(repo: repo);
        } else {
          return LoginPage(repo: repo);
        }
      }),
      debugShowCheckedModeBanner: false,
      title: 'Home app',
      theme: ThemeData(
        //canvasColor: Colors.black87,
        fontFamily: 'DroidSans',
        backgroundColor: AppColors.background,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
      ),
      //initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(
              repo: repo,
            ),
        '/register': (context) => RegisterPage(repo),
        '/home': (context) => HomePage(repo),
      },
    );
  }
}
