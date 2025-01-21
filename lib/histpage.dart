import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/appcolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});


  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;



    if (userId == null) {
      return const Center(child: Text('Please log in to view your orders.'));
    }

    return Scaffold(
      backgroundColor: DarkThemeColors.bg1,
      appBar: AppBar(
        title: const Text('Your Orders', style: TextStyle(color: Colors.white),),
        backgroundColor: DarkThemeColors.bg2 ,
        foregroundColor: Colors.white,
        ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('Purchases')
            .orderBy('orderDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index].data();
              final items = order['items'] as List;

              return Card(
                color: DarkThemeColors.card,
                elevation: 2,
                
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  
                  title:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...items.map((item) => 
                      Column(children: [
                                              Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(image: NetworkImage(item['image']))
                          //   ),

                          // ),
                          Expanded(
                            // flex: 5,
                            child: Text(
                              '${item['name']} ',
                              style: TextStyle(fontWeight:FontWeight.bold,color: DarkThemeColors.text1),
                              )
                          ),
                          SizedBox(width: 7,),
                          // Expanded(
                            // flex: 1,
                            // child: 
                            Text(
                              'x${item['quantity']}',
                              style: TextStyle(fontWeight:FontWeight.bold,color: DarkThemeColors.text1),
                              )
                          // ),  
                        ],
                      ),
                      SizedBox(height: 10,)


                      ],)
                      
                      
                          ),
                          SizedBox(height: 26,)
                    ],
                  ),
                  
                  subtitle:    
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                            Text('Order placed on ',
                            style: TextStyle(color: DarkThemeColors.text3),
                            ),
                            Text('${date(order['orderDate'])}${time(order['orderDate'])}',style: TextStyle(fontWeight: FontWeight.w800,
                            color: DarkThemeColors.text2 ),
                            ),



                        ],
                      ),
                  Row(
                    children: [
                       Text('Total: ',
                       style: TextStyle(color: DarkThemeColors.text3),
                       ),
                       Text('Rs.${order['totalPrice']}', style: TextStyle(fontWeight: FontWeight.w500,
                       color: DarkThemeColors.text2                      
                        ),)


                    ],
                  )



                  ],)

                ),
              );
            },
          );
        },
      ),
    );
  }
}


  String date(int timestamp) {

  // timestamp = 1736426394662; // Your timestamp in milliseconds
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  // Format the date
  // String formattedDate = DateFormat('jm').format(date);
    String formattedDate = DateFormat('E, d MMM y, ').format(date);


  return formattedDate;
}

  String time(int timestamp) {

  // int timestamp = 1736426394662; // Your timestamp in milliseconds
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  // Format the date
  // String formattedDate = DateFormat('jm').format(date);
    String formattedDate = DateFormat('jm').format(date);


  return formattedDate;
}
