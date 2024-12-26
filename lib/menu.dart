
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'services/model.dart';


// // Menu Screen with HTTP GET Method
// class menu extends StatefulWidget {
//   @override
//   menustate createState() => menustate();
// }

// class menustate extends State<menu> {
//   late Future<List<Welcome>> _products;

//   @override
//   void initState() {
//     super.initState();
//     _products = fetchProducts(); // Load products on init
    
//   }

//   // Function to fetch products using HTTP GET
//   Future<List<Welcome>> fetchProducts() async {
//     final response = await http.get(Uri.parse('https://unicode-flutter-lp-new.onrender.com/get_all_products'));

//     if (response.statusCode == 200) {
//       // Parse the JSON response into a list of Welcome objects
//       return welcomeFromJson(response.body);
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 222, 190, 163),
//       // appBar: AppBar(
//       //   title: Text('Menu'),
//       // ),
//       body: 
//               Column(
//               children: [
//                 //  Expanded(
//                 //   child: 
//               Container(
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 66, 73, 52),
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(46),
//                     bottomRight: Radius.circular(46)),
//               ),
//               child: Column(
                
//                 children: [
//                                     const SizedBox(height: 20,),

//                   const Text(
//                     'Menu',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 255, 252, 242),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       // Container(),Container()
//                       // categoryItem('Espresso', Icons.local_cafe),
//                       // categoryItem('Latte', Icons.coffee),
//                       // categoryItem('Cold Brew', Icons.icecream),
//                     ],
//                   ),
//                 ],
//               ),
            
//             ),
            
//             Expanded(child: 
//             Container(
              
//               child: 
//       FutureBuilder<List<Welcome>>(
//         future: _products,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No products available'));
//           } else {
            
//             // ListView.builder to display the products
//             return
//             // ListView.builder(
//             //   padding: const EdgeInsets.all(10),
//             //   itemCount: snapshot.data!.length,
//             //   itemBuilder: (context, index) {
//             //     final product = snapshot.data![index];
//             //     // return ListTile(
//             //     //   leading: Image.network(product.image, width: 50, height: 50),
//             //     //   title: Text(product.name),
//             //     //   subtitle: Text(product.description),
//             //     //   onTap: () {
//             //     //     // Add navigation to product details if needed
//             //     //   },
//             //     // );
//             //     return menucards(product.image, product.name);
//             //   },
//             // );
//             ListView.builder(
//   padding: const EdgeInsets.all(10),
//   itemCount: snapshot.data!.length,
//   itemBuilder: (context, index) {
//     final product = snapshot.data![index];
//     // return menucards(
//     //   product.image,
//     //   product.name,
//     //   // product.description,
//     // );
//         return ExpandableMenuCard(img: 
//       product.image,
//       name: 
//       product.name,
//       description: 
//       product.description,
//     );

//   },
// );

//           }
//         },
//       )))
//   ]));
//   }


//   Widget menucards(String img, String name,) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       height: 150,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         image: DecorationImage(
//           image: NetworkImage(img),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         height: 30,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           gradient: LinearGradient(
//             colors: [
//               Colors.black.withOpacity(0.7),
//               Colors.transparent,
//             ],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                 //   fit: BoxFit.fitHeight,
//                 // margin:EdgeInsets.only(right: 30),
//                 width: 260,
                  
                
                  
//                   child:
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )
//                 ),
//                 // SizedBox(width: 30,),
//                 IconButton(
//                   onPressed: (){}, 
//                   icon: const Icon(Icons.add_circle_sharp),
//                   color: Colors.white,
//                   )
//               ]
//             ),
//             // Text(
//             //   price,
//             //   style: TextStyle(
//             //     color: Colors.white,
//             //     fontSize: 14,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

// }

// class ExpandableMenuCard extends StatefulWidget {
//   final String img;
//   final String name;
//   final String description;

//   ExpandableMenuCard({required this.img, required this.name, required this.description});

//   @override
//   _ExpandableMenuCardState createState() => _ExpandableMenuCardState();
// }

// class _ExpandableMenuCardState extends State<ExpandableMenuCard> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isExpanded = !isExpanded;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.all(10),
//         height:  210,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           image: DecorationImage(
//             image: NetworkImage(widget.img),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Container(
          
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             gradient: LinearGradient(
//               colors: [
//                 Colors.black.withOpacity(0.7),
//                 Colors.transparent,
//               ],
//               begin: Alignment.bottomCenter,
//               end: Alignment.topCenter,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: isExpanded ? MainAxisAlignment.start : MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                 //   fit: BoxFit.fitHeight,
//                 // margin:EdgeInsets.only(right: 30),
//                 width: 260,
                  
                
                  
//                   child:
//                 Text(
//                   widget.name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )
//                 ),
//                 // SizedBox(width: 30,),
//                 IconButton(
//                   onPressed: (){}, 
//                   icon: const Icon(Icons.add_circle_sharp),
//                   color: Colors.white,
//                   )
//               ]
//             ),

//               if (isExpanded)
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 5.0),
//                   // child: 
//                   Text(
//                     widget.description,
//                     style: const TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'services/model.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  menustate createState() => menustate();
}

class menustate extends State<menu> {
  late Future<List<Welcome>> _products;
  String selectedCategory = 'ALL'; // Tracks the currently selected category

  @override
  void initState() {
    super.initState();
    _products = fetchProducts(); // Load all products on init
  }

  // Function to fetch all products or by category
  Future<List<Welcome>> fetchProducts({String category = 'ALL'}) async {
    final url = category == 'ALL'
        ? 'https://unicode-flutter-lp-new.onrender.com/get_all_products'
        : 'https://unicode-flutter-lp-new.onrender.com/get_products_by_category?category=$category';
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response into a list of Welcome objects
      return welcomeFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 198, 181),
      body: Column(children: [
        Container(
          // width: 560,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 66, 73, 52),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(46),
              bottomRight: Radius.circular(46),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 252, 242),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                padding:EdgeInsets.all(10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                scrollDirection: Axis.horizontal,
                child: 
              Wrap(
              
                spacing: 18,
                children: [
                  filterChip('ALL'),
                  filterChip('HOT BEVERAGES'),
                  filterChip('ICED BEVERAGES'),
                  filterChip('ADD-INS'),
                  filterChip('SYRUPS'),
                  filterChip('FOOD'),
                ],
              )),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Welcome>>(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products available'));
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return ExpandableMenuCard(
                      img: product.image,
                      name: product.name,
                      description: product.description,
                      price: 100,
                    );
                  },
                );
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget filterChip(String category) {
    return ChoiceChip(
      label: Text(category),
      selected: selectedCategory == category,
      selectedColor: const Color.fromARGB(255, 33, 37, 26),
      backgroundColor: Colors.brown[200],
      showCheckmark: false,
      labelStyle: TextStyle(
        color: selectedCategory == category ? Colors.white : Colors.black,
      ),
      onSelected: (isSelected) {
        if (isSelected && selectedCategory != category) {
          setState(() {
            selectedCategory = category;
            _products = fetchProducts(category: category);
          });
        }
      },
    );
  }
}

class ExpandableMenuCard extends StatefulWidget {
  final String img;
  final String name;
  final String description;
  final int price;

  const ExpandableMenuCard({super.key, 
    required this.img,
    required this.name,
    required this.description,
    required this.price,

  });

  @override
  _ExpandableMenuCardState createState() => _ExpandableMenuCardState();
}

class _ExpandableMenuCardState extends State<ExpandableMenuCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(widget.img),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            
            gradient:
            isExpanded?  LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6),
               Colors.black.withOpacity(0.6),



              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ): 
            LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: isExpanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 260,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Rs.${widget.price}",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),)
              ]),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_sharp),
                  color: Colors.white,
                )
              ]),
              if (isExpanded)
                Text(
                  widget.description,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
