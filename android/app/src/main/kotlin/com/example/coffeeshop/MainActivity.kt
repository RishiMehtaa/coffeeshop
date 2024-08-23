package com.example.coffeeshop

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()
@Override
fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    // Ensure Firebase is initialized
    FirebaseApp.initializeApp(this)
}
