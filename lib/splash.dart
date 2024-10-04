import 'package:flutter/material.dart';
import 'login.dart';

class Splash extends StatefulWidget{
  SplashState createState() => SplashState();

}
class SplashState extends State<Splash> {

  void initState()
  {
    super.initState();
    // _navigatetologin();
  }

  _navigatetologin() async  
  {
    await Future.delayed(Duration(milliseconds: 2000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Container(
        decoration: BoxDecoration(
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