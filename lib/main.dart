import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
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
  await GlobalConfiguration().loadFromAsset("configuration");
}

class MyApp extends StatelessWidget {
  final AAuthRepository repo;
  MyApp(this.repo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationSucceeded) {
          return HomePage();
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
        '/home': (context) => HomePage(),
      },
    );
  }
}
