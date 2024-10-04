import 'package:coffeeshop/mainscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:coffeeshop/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shop',
      home: AnimatedSplashScreen(
        splash: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('img/logo.png'),
              ),
            ),
          ),
        ),
        nextScreen: MainScreen(),
        duration: 1500,
        splashIconSize: 300,
        backgroundColor: Color.fromARGB(255, 222, 190, 163),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}

