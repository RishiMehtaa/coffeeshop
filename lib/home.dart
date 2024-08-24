import 'package:flutter/material.dart';
import 'package:coffeeshop/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shop',
      // darkTheme: ThemeData(brightness: Brightness.dark),
      // home: CoffeeShopHomeScreen(),
      home: LoginPage(),

    );
  }
}

// void getusername()
// {
//    User? user = FirebaseAuth.instance.currentUser;
// }
class CoffeeShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 255, 233, 227),
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        elevation: 0,
        title: Text('Good Morning, !', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
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
              // Featured Section
              // Categories Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color:  Colors.brown[700],borderRadius:BorderRadius.only(bottomLeft: Radius.circular(46),bottomRight: Radius.circular(46))),
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
              )),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                height: 150,
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

              // Menu Section
              // Container(
              //   padding: EdgeInsets.all(16),
              //   child: 
              //   Column(
              //     children: [
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
                        padding: EdgeInsets.only(left: 16,right: 16),
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
        // backgroundColor: const Color.fromARGB(255, 44, 39, 37),
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.brown[700],
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
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
