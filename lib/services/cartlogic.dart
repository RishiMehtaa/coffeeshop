import 'package:flutter/material.dart';
import '../models/model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void addItem(Welcome product) {
    final existingIndex = _items.indexWhere((item) => item.id == product.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        quantity: 1, 
        id: product.id, 
        name: product.name, 
        price: product.price, 
        image: product.image,
        // price: product.price,
        
      ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    final itemIndex = _items.indexWhere((item) => item.id == productId);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String productId) {
    final itemIndex = _items.indexWhere((item) => item.id == productId);
    if (itemIndex >= 0 && _items[itemIndex].quantity > 1) {
      _items[itemIndex].quantity--;
      notifyListeners();
    }
  }

   void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Convert the cart to a list of JSON objects for Firestore
  List<Map<String, dynamic>> toFirestore() {
    return _items.map((item) => item.toJson()).toList();
  }
}

// class CartItem {
//   final Welcome product;
//   int quantity;
//   int price;

//   CartItem({required this.product, required this.quantity, required this.price });

//    Map<String, dynamic> toJson() {
//     return {
//       'id': product.id,
//       'name': product.name,
//       'price': product.price,
//       'image': product.image,
//       'quantity': quantity,
//     };
//   }

//   // Create CartItem from Firestore JSON
//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'].toDouble(),
//       image: json['image'],
//       quantity: json['quantity'],
//     );
//   }
// }


// class CartItem {
//   final Welcome product;
//   int quantity;

//   CartItem({required this.product, required this.quantity});

//   // Convert CartItem to JSON for Firestore
//   Map<String, dynamic> toJson() {
//     return {
//       'id': product.id,
//       'name': product.name,
//       'price': product.price,
//       'image': product.image,
//       'quantity': quantity,
//     };
//   }

//   // Create CartItem from Firestore JSON
//   // factory CartItem.fromJson(Map<String, dynamic> json) {
//   //   return CartItem(
//   //     product: Welcome(
//   //       id: json['id'],
//   //       name: json['name'],
//   //       price: json['price'],
//   //       image: json['image'],
//   //     ),
//   //     quantity: json['quantity'],
//   //   );
//   // }
// }


class CartItem {
  final String id;
  final String name;
  final int price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  // Convert CartItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  // Create CartItem from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
      quantity: json['quantity'] as int,
    );
  }
}

// class Product {
//   final String id;
//   final String name;
//   final double price;
//   final String image;

//   Product({required this.id, required this.name, required this.price, required this.image});
// }
