// import 'package:coffeeshop/login.dart';
// import 'package:coffeeshop/mainscreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:coffeeshop/home.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';


// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// // void main() {
// //   // WidgetsFlutterBinding.ensureInitialized();
// //   // await Firebase.initializeApp();
// //   runApp(MyApp());
// // }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
      
//       debugShowCheckedModeBanner: false,
//       title: 'Coffee Shop',
//       home: AnimatedSplashScreen(
//         splash: Center(
//           child: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('img/logo.png'),
//               ),
//             ),
//           ),
//         ),
//         nextScreen: const MainScreen(),
//         // nextScreen: const LoginPage(),
//         duration: 1500,
//         splashIconSize: 300,
//         backgroundColor: Color.fromARGB(255, 211, 188, 170),
//         splashTransition: SplashTransition.fadeTransition,
//       ),
//     );
//   }
// }

import 'package:coffeeshop/login.dart';
import 'package:coffeeshop/services/cartlogic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // Adding CartProvider
      ],
      child: MaterialApp(
        // theme: ThemeData(
        //   colorScheme: ColorScheme(brightness: , primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, surface: surface, onSurface: onSurface)
        // ),
        debugShowCheckedModeBanner: false,
        title: 'Coffee Shop',
        home: AnimatedSplashScreen(
          splash: Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('img/logo.png'),
                ),
              ),
            ),
          ),
          // nextScreen: const MainScreen(),
          nextScreen: const LoginPage(),
          duration: 1500,
          splashIconSize: 300,
          backgroundColor: Color.fromARGB(255, 196, 191, 187),
          splashTransition: SplashTransition.fadeTransition,
        ),
      ),
    );
  }
}
