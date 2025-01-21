
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeshop/appcolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/cartlogic.dart'; 

// ignore: camel_case_types
class cart extends StatelessWidget {
  const cart({super.key});


  void placeOrder(BuildContext context,String? userId, CartProvider cart) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ordercon(context, 'Error', 'You need to log in to place an order.');
      return;
    }
        
        if (cart.items.isEmpty) {
      ordercon(context, 'Cart is empty', 'Please add items to your cart before placing an order.');
      return;
    }

    try{
  final firestore = FirebaseFirestore.instance;
  final orderId = firestore.collection('Users').doc(userId).collection('Purchases').doc().id;

  final orderData = {
    'orderId': orderId,
    'orderDate': DateTime.now().millisecondsSinceEpoch,
    'totalPrice': cart.totalPrice,
    'items': cart.toFirestore(),
  };

  await firestore
      .collection('Users')
      .doc(userId)
      .collection('Purchases')
      .doc(orderId)
      .set(orderData);

  cart.clearCart();
  ordercon(context, 'Congratulations!','Your order has been placed successfully' );

  }
   catch (e) {
      ordercon(context, 'Order Failed', 'An error occurred while placing your order. Please try again.');
    }
}



  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    
    return Scaffold(
    // backgroundColor: const Color.fromARGB(255, 218, 198, 181),
    backgroundColor: DarkThemeColors.bg1,
      body: Column(
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
                    'Cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [],
                  ),
                ]
                            )
              ),
              // child:  Column(
                
              //   children: [
              Expanded(
              child: 
              Padding(padding: const EdgeInsets.all(16),
                
                child: 
      Container(
        
        decoration: const BoxDecoration(color: Color.fromARGB(0, 233, 227, 222),borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          children: [
          cart.items.isEmpty
          ?  const Expanded(
            child: 
            Center(
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [         
                  Icon(Icons.remove_shopping_cart_rounded,size: 150,color: Colors.grey,),
                  SizedBox(height: 40,),
                  
                  Text('Your cart is empty',style: TextStyle(color: DarkThemeColors.text1),)
                  ],) 
              )
          )
            
          
          : 
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart.items[index];
                      return CartItemCard(cartItem: cartItem);
                    },
                  ),
                ), 
                // Divider(endIndent: 10,indent: 10,thickness: 1,color: Colors.black,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Row(
                        children: [   
                        const Text(
                        'Total:  ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,color: DarkThemeColors.text1),
                      ),
                      Text(
                        'Rs.${cart.totalPrice}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: DarkThemeColors.text1),
                      ),
                      ],)),
                      ElevatedButton(
                    onPressed: () {
                        User? user = FirebaseAuth.instance.currentUser;

                      placeOrder(context,user?.uid, cart);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all( 16),
      // backgroundColor: const Color.fromARGB(255, 66, 73, 52),
      backgroundColor: DarkThemeColors.bg2,
                    ),
                    child: const Text('Order',
                    style: TextStyle(color: Colors.white),),
                  ),
                      
                    ],
                  ),
                ),
            
      
              ]
            )
          )
          )
          )

          ]
          )
          );
          
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Card(
      color: DarkThemeColors.card,
      margin: const EdgeInsets.all(10),
      elevation: 3,
      shadowColor: const Color.fromARGB(255, 0, 0, 0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Image.network(cartItem.image, fit: BoxFit.contain,),
        title: Text(cartItem.name,style: TextStyle(color: DarkThemeColors.text1),),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Rs.${cartItem.price}',style: TextStyle(color: DarkThemeColors.text1),),
            Row(
              children: [
                IconButton(
                  color: DarkThemeColors.text2,
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if(cartItem.quantity>1) {
                      cart.decrementQuantity(cartItem.id);
                    } else {
                      deletecon(context, cartItem);
                    }
                  },
                ),
                Text('${cartItem.quantity}',style: TextStyle(color: DarkThemeColors.text1,fontWeight: FontWeight.bold),),

                IconButton(
                  color: DarkThemeColors.text2,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    cart.incrementQuantity(cartItem.id);
                  },
                ),
                IconButton(
                  color: DarkThemeColors.del,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deletecon(context, cartItem);
                    

                    // cart.removeItem(cartItem.product.id);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


  void deletecon(BuildContext context, CartItem cartItem) {


    final cart = Provider.of<CartProvider>(context, listen: false);

    showDialog(
      
      context: context,
      barrierDismissible: true, // Allows tapping outside to dismiss
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Center(
          child: Card(
            color: DarkThemeColors.card,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Confirm Deletion',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: DarkThemeColors.text1
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Do you want to delete this item from the cart?', style: TextStyle(color: DarkThemeColors.text1),),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Delete',style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          // Perform delete action here
                          cart.removeItem(cartItem.id);
                          Navigator.of(context).pop(); // Close dialog
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 114, 114, 114),
                        ),
                        child: const Text('Cancel',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }



  void ordercon(BuildContext context, String title, String msg) {

    showDialog(
      context: context,
      barrierDismissible: true, // Allows tapping outside to dismiss
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Center(
          child: Card(
            color: DarkThemeColors.card,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text( title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: DarkThemeColors.text1
                    ),
                  ),
                  const SizedBox(height: 10),
                   Text(msg,style: TextStyle(color: DarkThemeColors.text1),),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 54, 98, 255),
                        ),
                        child: const Text('Cool',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
