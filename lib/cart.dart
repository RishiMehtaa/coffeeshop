import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coffeeshop/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'signup.dart';
// import 'splash.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'menu.dart';
import 'home.dart';
import 'profile.dart';



// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Coffee Shop',
//       // darkTheme: ThemeData(brightness: Brightness.dark),
//       // home: CoffeeShopHomeScreen(),
//       // home: LoginPage(),
//       home: AnimatedSplashScreen(splash: Center(
//         child: Container(
//         decoration: BoxDecoration(
//         // borderRadius: BorderRadius.circular(16),
//         image: DecorationImage(
//           image: AssetImage('img/logo.png'),
//           // fit: BoxFit.cover,
//         ),
//       ),

          
//         ),
//       ),
//       nextScreen: LoginPage(),
//       duration: 1500,
//       splashIconSize: 300,
//       backgroundColor: Color.fromARGB(255, 222, 190, 163),
//       splashTransition: SplashTransition.fadeTransition,
//       ),
      


//     );
//   }
// }

// void getusername()
// {
//    User? user = FirebaseAuth.instance.currentUser;
// }

// class CoffeeShopHomeScreen extends StatelessWidget {
class cart extends StatefulWidget{
  cartstate createState() => cartstate();

}
class cartstate extends State<cart> {

  Future<String?> getUsername() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      return userDoc.get('username');
    }
  }

  return null;
}

  _tohome(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));

  }

  _tomenu(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>menu()));
  }

  _tocart(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>cart()));
  }

  _toprofile(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>profile()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 255, 233, 227),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 64, 44, 38),
        elevation: 0,
        title: Text('Good Morning, Rishi !', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: 
        Padding(
          padding: const EdgeInsets.all(0),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color:  const Color.fromARGB(255, 64, 44, 38),borderRadius:BorderRadius.only(bottomLeft: Radius.circular(46),bottomRight: Radius.circular(46))),
                child: Column( 
                  children:[
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 252, 242)
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        categoryItem('Espresso', Icons.local_cafe),
                        categoryItem('Latte', Icons.coffee),
                        categoryItem('Cold Brew', Icons.icecream),
                      ],
                    )
                  ]
                )
              ),
              SizedBox(height: 24),
               Container(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Featured Drinks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    featuredItem('img/coffee1.jpeg', 'Caramel Latte', 'Rs 260'),
                    featuredItem('img/coffee2.jpeg', 'Espresso', 'Rs 300'),
                    featuredItem('img/coffee3.jpeg', 'Cold Brew', 'Rs 220'),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
              ),
              Expanded(
                child: 
                GridView.count(
                  // physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    menuItem('img/coffee1.jpeg', 'Caramel Latte', 'Rs 260'),
                    menuItem('img/coffee2.jpeg', 'Espresso', 'Rs 300'),
                    menuItem('img/coffee3.jpeg', 'Cold Brew', 'Rs 220'),
                    menuItem('img/coffee4.jpeg', 'Cappuccino', 'Rs 265'),
                    menuItem('img/coffee1.jpeg', 'Caramel Latte', 'Rs 260'),
                    menuItem('img/coffee2.jpeg', 'Espresso', 'Rs 300'),
                    menuItem('img/coffee3.jpeg', 'Cold Brew', 'Rs 220'),
                    menuItem('img/coffee4.jpeg', 'Cappuccino', 'Rs 265'),

                  ],
                ),
              ),
          
            ],
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 64, 44, 38),
            icon: IconButton(icon: Icon(Icons.home),
            onPressed: _tohome(),),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(icon: Icon(Icons.menu_book),
            onPressed: _tomenu(),),
            label: 'Menu',

          ),
          BottomNavigationBarItem(
            icon: IconButton(icon: Icon(Icons.shopping_cart),
            onPressed: _tocart(),),
            label: 'Cart',

          ),
          BottomNavigationBarItem(
            icon: IconButton(icon: Icon(Icons.person),
            onPressed: _toprofile(),),
            label: 'Profile',

          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 255, 231, 222),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
      ),
    
    );
  }

  Widget featuredItem(String imagePath, String title, String price) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.brown[200],
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color:  const Color.fromARGB(255, 255, 255, 255)),
        ),
      ],
    );
  }

  Widget menuItem(String imagePath, String title, String price) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
