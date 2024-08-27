import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart'; 
import 'signup.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  // void _login() {
  //   if (_formKey.currentState!.validate()) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => CoffeeShopHomeScreen()),
  //     );
  //     // Clear the text fields after successful login
  //     _emailController.clear();
  //     _usernameController.clear();
  //     _passwordController.clear();
  //   }
  // }

   Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CoffeeShopHomeScreen()),
        );
                _emailController.clear();
               _passwordController.clear();

      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'user-not-found') {
            _errorMessage = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            _errorMessage = 'Wrong password provided.';
          } else {
            _errorMessage = 'An error occurred. Please try again.';
          }
                      print(_errorMessage);

        });
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
        });
      }
    }
  }


  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 202, 187),
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 102, 46, 38),
      //   title: Text('Login'),
      //   centerTitle: true,
      //   titleTextStyle: TextStyle(color: Colors.white),
      // ),
      body: Container(
            padding: EdgeInsets.only(top: 100,left: 20,right: 20),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('img/bg.jpg'),fit: BoxFit.cover)
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Container( 
            decoration: BoxDecoration(
              color: Color.fromARGB(104, 86, 59, 59),
              borderRadius: BorderRadius.all(Radius.circular(56))
               ),
            child: Padding(
              padding: const EdgeInsets.only(left: 56,right: 56,top: 50,bottom: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
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
                        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value.trim())) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
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
                        // if(value!=)
                        //  return 'Incorrect Password';
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 102, 46, 38),
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                              _navigateToSignUp();
                              _emailController.clear();
                              _usernameController.clear();
                              _passwordController.clear();

                      },
                      child: Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(color: Color.fromARGB(255, 102, 46, 38)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            )
          ]
        ),
      )
    );
  }
}
