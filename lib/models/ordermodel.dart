// class Ordermodel {
//   final String? id;
//   final String name;
//   final DateTime date;
//   final int quantity;

//   const Ordermodel({
//     this.id,
//     required this.name,
//     required this.date,
//     required this.quantity
//   });

//   tojson(){
//     return {
//       "name": name,
//       "datetime":date,
//       "quantity": quantity
//     };
//   }
  
// }

import 'package:coffeeshop/services/cartlogic.dart';
import 'package:intl/intl.dart';

class Purchase {
  final String orderId; // Unique identifier for the order
  final DateTime orderDate; // Date when the order was placed
  final double totalPrice; // Total cost of the order
  final List<CartItem> items; // List of items in the order

  Purchase({
    required this.orderId,
    required this.orderDate,
    required this.totalPrice,
    required this.items,
  });

  // Convert Purchase to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderDate': orderDate.millisecondsSinceEpoch,
      // 'orderDate': date(),
      'totalPrice': totalPrice,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // Create Purchase from Firestore JSON
  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      orderId: json['orderId'],
      orderDate:
          DateTime.fromMillisecondsSinceEpoch(json['orderDate'] as int),
      totalPrice: json['totalPrice'].toDouble(),
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
//   String date() {

//   int timestamp = 1736426394662; // Your timestamp in milliseconds
//   DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

//   // Format the date
//   String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);

//   return formattedDate;
// }
}
