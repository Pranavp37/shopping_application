import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingui/controller/product_home_controller.dart';
import 'package:shoppingui/views/cart_page/cart_page.dart';
import 'package:shoppingui/views/categories/categories.dart';
import 'package:shoppingui/views/details/details.dart';
import 'package:shoppingui/views/widget/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<ProductHomeController>().getCategory();
      await context.read<ProductHomeController>().getAlldata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = context.watch<ProductHomeController>();

    return Scaffold(
      body: product.isCategoriesLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //appBar

                    _appBar(),
                    SizedBox(height: 20),

                    //searchBar
                    HomeSearchBar(),
                    SizedBox(height: 20),

                    //categories

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            product.productCategories.length,
                            (index) => InkWell(
                                  onTap: () async {
                                    context
                                        .read<ProductHomeController>()
                                        .onCaterogorySelection(index);
                                    // await context
                                    //     .read<ProductHomeController>()
                                    //     .getCatgoryDAta(product
                                    //         .productCategories[index]
                                    //         .toString());
                                    if (index == 0) {
                                      await context
                                          .read<ProductHomeController>()
                                          .getAlldata();
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Categories(
                                        text: product.productCategories[index]
                                            .toString(),
                                        containerClr: context
                                                    .watch<
                                                        ProductHomeController>()
                                                    .selectedcat ==
                                                index
                                            ? Colors.black
                                            : Colors.grey,
                                        textClr: context
                                                    .watch<
                                                        ProductHomeController>()
                                                    .selectedcat ==
                                                index
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                )),
                      ),
                    ),

                    //
                    SizedBox(height: 20),

                    //Gridview

                    product.isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: GridView.builder(
                              itemCount: product.productData.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 280,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                if (product.productData.isEmpty) {
                                  return const Text('DAta not Found');
                                }
                                if (product.productData.isNotEmpty) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                id: product
                                                    .productData[index].id!,
                                              ),
                                            )),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 195,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                product
                                                                    .productData[
                                                                        index]
                                                                    .image
                                                                    .toString())),
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10))),
                                                  ),
                                                  Positioned(
                                                    top: 12,
                                                    right: 12,
                                                    child: Container(
                                                      height: 45,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .favorite_border_outlined,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.productData[index]
                                                          .title
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                    Text(
                                                      product.productData[index]
                                                          .price
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      height: 1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                ),
                label: 'Saved'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                ),
                label: 'cart'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                ),
                label: 'Settings')
          ]),
    );
  }

  Row _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Discover',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ));
              },
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 40,
              ),
            ),
            Positioned(
              top: 6,
              right: 1,
              child: CircleAvatar(
                child: Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                radius: 9,
                backgroundColor: Colors.black,
              ),
            )
          ],
        )
      ],
    );
  }
}





//  Row(
//                   children: [
//                     Categories(
//                       text: 'All',
//                       containerClr: Colors.black,
//                       textClr: Colors.white,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Categories(
//                       text: 'Men',
//                       containerClr: Colors.grey,
//                       textClr: Colors.black,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Categories(
//                       text: 'Kids',
//                       containerClr: Colors.grey,
//                       textClr: Colors.black,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Categories(
//                       text: 'Women',
//                       containerClr: Colors.grey,
//                       textClr: Colors.black,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Categories(
//                       text: 'Adults',
//                       containerClr: Colors.grey,
//                       textClr: Colors.black,
//                     ),
//                   ],
//                 ),