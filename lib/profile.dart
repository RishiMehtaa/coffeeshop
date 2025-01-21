import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/appcolors.dart';
import 'package:coffeeshop/histpage.dart';
import 'package:coffeeshop/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Menu Screen with HTTP GET Method
// ignore: camel_case_types
class profile extends StatefulWidget {
  const profile({super.key});

  @override
  profilestate createState() => profilestate();
}

// ignore: camel_case_types
class profilestate extends State<profile> {

  FutureBuilder<String?> buildProfileDetail(String fieldName, String displayname) {
  return FutureBuilder<String?>(
    future: getdata(fieldName),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text('$displayname: Loading...',style:TextStyle(color: DarkThemeColors.text1),);
      } else if (snapshot.hasError) {
        return Text('$displayname: Error',style: TextStyle(color: DarkThemeColors.text1),);
      } else if (snapshot.hasData) {
        return Text('$displayname: ${snapshot.data}',style: TextStyle(color: DarkThemeColors.text1),);
      } else {
        return Text('$displayname: Not available');
      }
    },
  );
}

    Future<String?> getdata(String data) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc.get(data).toString();
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // backgroundColor: const Color.fromARGB(255, 218, 198, 181),
    backgroundColor: DarkThemeColors.bg1,
      body: 
              Column(
              children: [
                //  Expanded(
                //   child: 
              Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
      // color: const Color.fromARGB(255, 66, 73, 52),
      color: DarkThemeColors.bg2,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(46),
                    bottomRight: Radius.circular(46)),
              ),
              child: const Column(
                
                children: [
                  SizedBox(height: 20,),

                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: DarkThemeColors.text1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [],
                  ),
                ],
              ),
            
            ),
            const SizedBox(height: 12,),
            Expanded(child: 
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: 
              Column(  
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                // crossAxisAlignment: CrossAxisAlignment.start,           
                children: [
                  // Column(
                  // children: [
                                Container(  
                                  height: 220,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage('img/prof.png')),
                                  shape: BoxShape.circle,
                                  // color: Color.fromARGB(110, 180, 227, 217),
                                  
                                  ),
                                margin: const EdgeInsets.all(10),
                                padding:const EdgeInsets.all(10),
                              
                                // child:const Icon(Icons.person,size: 130,color: Color.fromARGB(255, 23, 64, 24),)
                                ),
                        
                                // const Divider(height: 8,color: Color.fromARGB(255, 0, 0, 0),indent: 40,endIndent: 40,),
                                buildProfileDetail('username','Name'),
                      // const Divider(height: 8, color: Colors.black, indent: 40, endIndent: 40),
                      buildProfileDetail('email','Email ID'),
                      // const Divider(height: 8, color: Colors.black, indent: 40, endIndent: 40),
                      buildProfileDetail('password', 'Password'),
                      // const Divider(height: 8, color: Colors.black, indent: 40, endIndent: 40),
                                    TextButton(onPressed: (_navigateTohist), child: const Text('Your Orders',style: TextStyle(color: DarkThemeColors.text1),)),
              TextButton(onPressed: (_navigateToLogin), child: const Text('Sign Out',style: TextStyle(color: DarkThemeColors.del),)),

                                // ]
                                // ),
             

                

                ]
               )
              ))
            
          ]
        )
      );
  }
  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _navigateTohist() {
    Navigator.push(
      context,
      MaterialPageRoute(
        
        
        builder: (context) => const OrderHistoryPage()),
    );
  }

  



}

