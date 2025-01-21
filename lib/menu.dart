

import 'package:coffeeshop/appcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'models/model.dart';
import 'services/cartlogic.dart';
import 'package:provider/provider.dart';


// ignore: camel_case_types
class menu extends StatefulWidget {
  const menu({super.key});

  @override
  menustate createState() => menustate();
}

// ignore: camel_case_types
class menustate extends State<menu> {
  late Future<List<Welcome>> _products;
  String selectedCategory = 'ALL'; // Tracks the currently selected category
  List<Welcome> allProducts = []; // To store all products fetched
  List<Welcome> filteredProducts = []; // To display products after filtering
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
    // _products = fetchProducts(); // Load all products on init
  }

   Future<void> _loadProducts() async {
    // Fetch initial products (ALL category by default)
    final products = await fetchProducts();
    setState(() {
      allProducts = products;
      filteredProducts = products;
    });
  }

  // Function to fetch all products or by category
  Future<List<Welcome>> fetchProducts({String category = 'ALL'}) async {
    final url = category == 'ALL'
        ? 'https://unicode-flutter-lp-new-final.onrender.com/get_all_products'
        : 'https://unicode-flutter-lp-new-final.onrender.com/get_products_by_category?category=$category';
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response into a list of Welcome objects
      return welcomeFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Filter products based on search query
  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts
            .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context);
    return Scaffold(
    // backgroundColor: const Color.fromARGB(255, 218, 198, 181),
    backgroundColor: DarkThemeColors.bg1,
      body: Column(children: [
        Container(
          // width: 560,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            // backgroundBlendMode: BlendMode.clear,
      // color: const Color.fromARGB(255, 66, 73, 52),
      color: DarkThemeColors.bg2,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(46),
              bottomRight: Radius.circular(46),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(width: 50,),
                const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              // SearchBar(),
          //             IconButton(
          // icon: const Icon(Icons.search),
          // color: DarkThemeColors.text1,
          // onPressed: () {
          // },
          
        // ),



              ],),
              const SizedBox(height: 10),
              TextField(
                controller: searchController,
                onChanged: (query) => filterProducts(query),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(),
                  filled: true,
                  fillColor: DarkThemeColors.text1,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),              
              // SearchBar(
              //   controller: SearchController(

              //   ),
              //   enabled: true,
              //   hintText: 'Search',
              //   hintStyle: WidgetStateProperty.all(TextStyle(fontStyle: FontStyle.italic)),

              //   constraints: BoxConstraints.tightForFinite(width: 450, height: 40),
              // ),
              // SearchAnchor.bar(
              //   suggestionsBuilder:(context, controller) => ,
              //  ),
              SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding:const EdgeInsets.all(10),
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
          child: filteredProducts.isEmpty
              ? const Center(child: Text('No products available'))
              : ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ExpandableMenuCard(
                      img: product.image,
                      name: product.name,
                      description: product.description,
                      price: product.price,
                      product: product,
                    );
                  },
                ),
        ),
                      // SizedBox(height: 4,),

        // Expanded(
        //   child: FutureBuilder<List<Welcome>>(
        //     future: _products,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else if (snapshot.hasError) {
        //         return Center(child: Text('Error: ${snapshot.error}'));
        //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //         return const Center(child: Text('No products available'));
        //       } else {
        //         return ListView.builder(
        //           physics: BouncingScrollPhysics(),                  
        //           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        //           padding: const EdgeInsets.all(10),
        //           itemCount: snapshot.data!.length,
        //           itemBuilder: (context, index) {
        //             final product = snapshot.data![index];
        //             return ExpandableMenuCard(
        //               img: product.image,
        //               name: product.name,
        //               description: product.description,
        //               price: product.price,
        //               product: product,
        //             );
        //           },
        //         );
        //       }
        //     },
        //   ),
        // ),
      ]),
    );
  }


 Widget filterChip(String category) {
    return ChoiceChip(
      label: Text(category),
      selected: selectedCategory == category,
      selectedColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: Color.fromARGB(255, 54, 92, 77),
      showCheckmark: false,
      labelStyle: TextStyle(
        color: selectedCategory == category
            ? const Color.fromARGB(255, 0, 0, 0)
            : const Color.fromARGB(255, 224, 224, 224),
      ),
      onSelected: (isSelected) async {
        if (isSelected && selectedCategory != category) {
          setState(() {
            selectedCategory = category;
          });
          final products = await fetchProducts(category: category);
          setState(() {
            allProducts = products;
            filteredProducts = products;
          });
        }
      },
    );
  }
}
//   Widget filterChip(String category) {
//     return ChoiceChip(
//       label: Text(category),
//       selected: selectedCategory == category,
//       selectedColor: const Color.fromARGB(255, 255, 255, 255),
//       // backgroundColor: Colors.brown[200],
//                 backgroundColor: const Color.fromARGB(255, 103, 105, 98),

//       showCheckmark: false,
//       labelStyle: TextStyle(
//         color: selectedCategory == category ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 224, 224, 224),
//       ),
//       onSelected: (isSelected) {
//         if (isSelected && selectedCategory != category) {
//           setState(() {
//             selectedCategory = category;
//             _products = fetchProducts(category: category);
//           });
//         }
//       },
//     );
//   }
// }

class ExpandableMenuCard extends StatefulWidget {
  final String img;
  final String name;
  final String description;
  final int price;
  final Welcome product;

  const ExpandableMenuCard({super.key, 
    required this.img,
    required this.name,
    required this.description,
    required this.price,
    required this.product,


  });

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableMenuCardState createState() => _ExpandableMenuCardState();
}

class _ExpandableMenuCardState extends State<ExpandableMenuCard> {
  bool isExpanded = false;
  //  final Welcome product;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
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
                      color: DarkThemeColors.text1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Rs.${widget.price}",style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),)
              ]),
                ),
                IconButton(
                  onPressed: () {
cart.addItem(widget.product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        
                      SnackBar(
                          duration: const Duration(milliseconds: 800),
                          backgroundColor: const Color.fromARGB(255, 43, 87, 43),
                          content: Text('${widget.name} added to cart!',style: const TextStyle(color: DarkThemeColors.text1),),
                        ),
                      );                  },
                  icon: const Icon(Icons.add_circle_sharp),
                  color: DarkThemeColors.text1,
                )
              ]),
              if (isExpanded)
                Text(
                  widget.description,
                  style: const TextStyle(color: DarkThemeColors.text1, fontSize: 12),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
