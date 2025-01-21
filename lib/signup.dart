import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/models/usermodel.dart';
import 'package:coffeeshop/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userRepo = Get.put(UserRepo());
  String? uid;

  // void _signUp() {
  //   if (_formKey.currentState!.validate()) {
  //     // Perform sign-up logic here (e.g., API call, registration)
  //     Navigator.pop(context);  // Go back to the login page after successful sign-up
  //   }
  // }

Future<void> createuser() async {
   User? curuser = FirebaseAuth.instance.currentUser;
    final user = Usermodel(
      id: curuser?.uid,
      username: _usernameController.text.trim(), 
      email: _emailController.text.trim(),
      password: _confirmPasswordController.text.trim()
      );
    
  await userRepo.createuser(user,curuser?.uid);
}
  
  void navtologin ()
  {
            Navigator.pop(context);

  }

   Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
                     

      try {
        // UserCredential userCredential = 
          await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          
        );
        createuser()
          .whenComplete(
      () => Get.snackbar("Success", "Your account has been created",
      backgroundColor: Colors.green.withOpacity(0.2),
      colorText: Colors.white),
      )
      .catchError((error, stackTrace) {
        Get.snackbar("Error", "Something went wrong. Try again",
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.white);
        print(error.toString());
      })
        ;
        
        //  User? user = userCredential.user;

    // if (user != null) {
    //   await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    //     'username': _usernameController.text.trim(),
    //     'email': _emailController.text.trim(),
    //   });}
        
        Navigator.pop(context);
      } catch (e) {
        print('Failed to sign up: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up: $e')),
        );
      }
    }
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     backgroundColor: const Color.fromARGB(255, 228, 228, 228),
  //     appBar: AppBar(
  //       scrolledUnderElevation: 4,
  //       backgroundColor: Color.fromARGB(68, 0, 0, 0),
  //       foregroundColor:  Color.fromARGB(255, 255, 255, 255),
  //       // title: Text('Sign Up'),
  //       // centerTitle: true,
  //       // titleTextStyle: TextStyle(color: Colors.white),
  //     ),
  //           body: 
            
  //           Container(
  //           padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
  //           decoration: const BoxDecoration(
  //             image: DecorationImage(image: AssetImage('img/bg.jpg'),fit: BoxFit.cover)
  //           ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //         children:[
  //           Container( 
              
  //           decoration: const BoxDecoration(
  //             color: Color.fromARGB(104, 86, 59, 59),
  //             borderRadius: BorderRadius.all(Radius.circular(56))
  //              ),

  //     child: Padding(
  //       padding: const EdgeInsets.all(26.0),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextFormField(
  //               controller: _emailController,
  //               decoration: InputDecoration(
  //                 filled: true,
  //                 fillColor: const Color.fromRGBO(255, 255, 255, 1),
  //                 labelText: 'Email',
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide.none,
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your email';
  //                 }
  //                 if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
  //                   return 'Please enter a valid email';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 16),
  //             TextFormField(
  //               controller: _usernameController,
  //               decoration: InputDecoration(
  //                 filled: true,
  //                 fillColor: const Color.fromRGBO(255, 255, 255, 1),
  //                 labelText: 'Username',
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide.none,
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your username';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 16),
  //             TextFormField(
  //               controller: _passwordController,
  //               decoration: InputDecoration(
  //                 filled: true,
  //                 fillColor: const Color.fromRGBO(255, 255, 255, 1),
  //                 labelText: 'Password',
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide.none,
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //               ),
  //               obscureText: true,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your password';
  //                 }
  //                 if (value.length < 8) {
  //                   return 'Password should have a minimum of 8 characters';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 16),
  //             TextFormField(
  //               controller: _confirmPasswordController,
  //               decoration: InputDecoration(
  //                 filled: true,
  //                 fillColor: const Color.fromRGBO(255, 255, 255, 1),
  //                 labelText: 'Confirm Password',
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide.none,
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //               ),
  //               obscureText: true,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please confirm your password';
  //                 }
  //                 if (value != _passwordController.text) {
  //                   return 'Passwords do not match';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             const SizedBox(height: 16),
  //             ElevatedButton(
  //               onPressed: (){
  //                 if(_formKey.currentState!.validate()){
  //                   // final user = Usermodel(
  //                   //   username: _usernameController.text.trim(), 
  //                   //   email: _emailController.text.trim(),
  //                   //   password: _confirmPasswordController.text.trim()
  //                   //   );
                       
  //                     // createuser(user);
  //                     _signUp();

  //                 }
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color.fromARGB(255, 102, 46, 38),
  //                 foregroundColor: const Color.fromARGB(255, 255, 255, 255),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //               ),
  //               child: const Text('Sign Up',),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //               )
  //         ]
  //       ),
  //     )

  //   );
  // }
  @override
Widget build(BuildContext context) {
      Color darkbg =  Color.fromARGB(255, 27, 27, 27);
    Color lightbg =  Color.fromARGB(255, 255, 255, 255);

  return Scaffold(
    resizeToAvoidBottomInset: true, // Allows scrolling to accommodate the keyboard
    backgroundColor: const Color.fromARGB(255, 228, 228, 228),
    appBar: AppBar(
      scrolledUnderElevation: 4,
      backgroundColor: const Color.fromARGB(68, 0, 0, 0),
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
    ),
    body: Stack(
      children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('img/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
        ),
        // Foreground Content
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(104, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(56)),
                  ),
                  padding: const EdgeInsets.all(26.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password should have a minimum of 8 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _signUp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkbg,
                            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

}

