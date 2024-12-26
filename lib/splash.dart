import 'package:flutter/material.dart';
import 'login.dart';

class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();

}
class SplashState extends State<Splash> {

  @override
  void initState()
  {
    super.initState();
    // _navigatetologin();
  }

  _navigatetologin() async  
  {
    await Future.delayed(const Duration(milliseconds: 2000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Container(
        decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('img/logo.png'),
          // fit: BoxFit.cover,
        ),
      ),

          
        ),
      ),
    );
    
  }
}