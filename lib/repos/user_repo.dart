import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createuser(Usermodel user, String? uid)
  async {
    await _db.collection("Users").doc(uid).set(user.tojson())
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
    
      
  }
}