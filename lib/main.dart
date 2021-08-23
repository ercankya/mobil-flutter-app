import 'package:fal_zamani/modals/authentication.dart';
import 'package:fal_zamani/screens/home_screen.dart';
import 'package:fal_zamani/screens/login_screen.dart';
import 'package:fal_zamani/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Authentication())],
        child: MaterialApp(
          title: 'Fal Zamani',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginScreen(),
          routes: {
            SignupScreen.routeName: (ctx) => SignupScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
          },
        ));
  }
}
