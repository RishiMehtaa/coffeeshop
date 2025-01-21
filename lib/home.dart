

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


// ignore: camel_case_types
class home extends StatefulWidget {
  final Function(int) onTabSelected;
  
  const home({super.key,required this.onTabSelected});
  

  @override
  // ignore: library_private_types_in_public_api
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  Future<String?> getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc.get('username').toString();
      }
    }
    return null;
  }

  @override

  Widget build(BuildContext context) {
  return Scaffold(
    // backgroundColor: const Color.fromARGB(255, 218, 198, 181),
    backgroundColor: DarkThemeColors.bg1,

    appBar: AppBar(
      scrolledUnderElevation: BorderSide.strokeAlignCenter,
      // backgroundColor: const Color.fromARGB(255, 66, 73, 52),
      backgroundColor: DarkThemeColors.bg2,

      elevation: 0,
      title: FutureBuilder<String?>
      (
        future: getUsername(), 
        builder: (context,snapshot)
        {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                "Loading...",
                style: TextStyle(color: DarkThemeColors.text1),
              );
            } else if (snapshot.hasError) {
              return const Text(
                "Error",
                style: TextStyle(color: DarkThemeColors.text1),
              );
            } else if (snapshot.hasData) {
              return Text(
                "Hello, ${snapshot.data}!",
                style: const TextStyle(color: DarkThemeColors.text1),
              );
            } else {
              return const Text(
                "Hello, Guest!",
                style: TextStyle(color: DarkThemeColors.text1),
              );
            }

        })
      
      // const Text(
      //   "Hello, $getUsername()!",
      //   style: TextStyle(color: DarkThemeColors.text1),
      // ),
      // actions: [
        // IconButton(
        //   icon: const Icon(Icons.search),
        //   color: DarkThemeColors.text1,
        //   onPressed: () {},
        // ),
      // ],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [                                           
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                          Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
      // color: const Color.fromARGB(255, 66, 73, 52),
      color: DarkThemeColors.bg2,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(46),
              bottomRight: Radius.circular(46),
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Choose your city',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: DarkThemeColors.text1,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  categoryItem('Mumbai', Icons.location_city_outlined),
                  categoryItem('Delhi', Icons.home_work_rounded),
                  categoryItem('Bangalore', Icons.cabin_rounded),
                ],
              ),
            ],
          ),
        ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Today\'s Special',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: DarkThemeColors.text1
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
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
                  const SizedBox(height: 24),
                  const Text(
                    'Offers',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: DarkThemeColors.text1
                    ),
                  ),
                  const SizedBox(height: 16),
                   GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      menuItem('img/off1.png', '', ''),
                      menuItem('img/off2.png', '', ''),
                      menuItem('img/off3.png', '', ''),
                      menuItem('img/off4.png', '', ''),
                      menuItem('img/off5.png', '', ''),
                      // menuItem('img/off3.png', '', ''),
                    ],
                  ),
                    const SizedBox(height: 56),

                    const Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: DarkThemeColors.text1
                    ),
                  ),
                  Container(
                    padding:const EdgeInsets.all(12),
                    // color: DarkThemeColors.card,
                    child: Column(children: [
                      const Text('Capulus, a part of Coffee Day Global Limited,is India’s favourite hangout for coffee and conversations. Popularly known as CPS, we strive to provide the best experience to our guests. Our coffees are sourced from thousands of small coffee planters, who made us who we are today and we\'re glad to be a part of their lives. We opened our first cafe in 1996 at Brigade Road in Bangalore – the youth and the young at heart immediately took to the cafe, and it continues to be one of the most happening places in the city. CPS to the youth is a “hangout” spot where they meet people, make conversations, and have a whole lot of fun over steaming cups of great coffee.It\'s been an exciting journey since then to becoming the largest organised retail cafe chain in the country.'
                    ,style: TextStyle(color: DarkThemeColors.text2 ),),
                            const Divider(thickness: 1,color: DarkThemeColors.text1,),

                    aboutItem('img/abt1.png', 'ETHICALLY SOURCED', 'We work closely with producers to ensure that the beans are of the highest quality, grown sustainably and traded responsibly.'),
                    const SizedBox(height: 10),
                            const Divider(thickness: 1,color: DarkThemeColors.text1,),

                    aboutItem('img/abt2.png', 'FRESHLY ROASTED', 'We specially roast your coffee in our in-house, state-of-the-art coffee roaster with specific profiles to ensure optimal flavour notes.'),
                    const SizedBox(height: 10),
                            const Divider(thickness: 1,color: DarkThemeColors.text1,),

                    aboutItem('img/abt3.png', 'SAFELY DELIVERED', 'We do our best to ensure that your coffee reaches you properly packaged, completely fresh and well in time.'),
                    const SizedBox(height: 10),
                            const Divider(thickness: 1,color: DarkThemeColors.text1,),

                    aboutItem('img/abt4.png', 'EASY TO MAKE', 'Life is better simplified. That’s why our coffee is easy to make both with and without equipment.'),




                    ],
                    )
                    
              
                    ),


              ],)

              ),

                ],
              ),
            ),
          ),
        
      ],
    ),
  );


            
  }

  Widget featuredItem(String imagePath, String title, String price) {
    return GestureDetector(
      onTap: _onofferTapped,
      child: Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
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
              style: const TextStyle(
                color: DarkThemeColors.text1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                            Text(
              price,
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationColor: DarkThemeColors.text1,
                color: DarkThemeColors.text1,
                fontSize: 14,
              ),
            ),
            const Text(
              'Rs.100',
              style: TextStyle(
                color: DarkThemeColors.text1
              ),)


              ],
            )
          ],
        ),
      ),
    ));
  }

  void _onofferTapped() {
     widget.onTabSelected(1);
    }



  Widget categoryItem(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          // backgroundColor: const Color.fromARGB(255, 110, 117, 96),
          backgroundColor: DarkThemeColors.citybg,
          child: Icon(icon, color: DarkThemeColors.text1, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ],
    );
  }

  Widget menuItem(String imagePath, String title, String price) {
    return
         GestureDetector(
      onTap: _onofferTapped,
child: 
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.0),
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
              style: const TextStyle(
                color: DarkThemeColors.text1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                color: DarkThemeColors.text1,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

  Widget aboutItem(String imagePath, String title, String desc) {
    return 
    Container(
    //   width: 250,
    //   height: 250,
    //   margin: const EdgeInsets.only(right: 16),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(16),
    //     image: DecorationImage(
    //       image: AssetImage(imagePath),
    //       fit: BoxFit.contain,
    //     ),
    //   ),
    //   child: Container(
    //     padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
      width: 250,
      height: 250,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(80),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      // child: 
      // Container(
      //   padding: const EdgeInsets.all(12),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(16),
      //     gradient: LinearGradient(
      //       colors: [
      //         Colors.black.withOpacity(0.8),
      //         Colors.transparent,
      //       ],
      //       begin: Alignment.bottomCenter,
      //       end: Alignment.topCenter,
      //     ),
      //   ),)
        ),
            Text(
              title,
              style: const TextStyle(
                color: DarkThemeColors.text1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              desc,
              style: const TextStyle(
                color: DarkThemeColors.text2,
                fontSize: 14,
              ),
            ),
          ],
        )
        );
    //   ),
    // );
  
  }

