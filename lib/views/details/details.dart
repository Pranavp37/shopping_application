import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingui/controller/cart_page_controller.dart';
import 'package:shoppingui/controller/product_details_controller.dart';
import 'package:shoppingui/util/app_url.dart';
import 'package:shoppingui/views/cart_page/cart_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.id, required this.index});

  final int id;
  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context
          .read<ProductDetailsController>()
          .getProductDetails(widget.id);
      // context.read<CartPageController>().getProduct();
      // Check if the widget is still mounted before updating state or interacting with the context
      // if (mounted) {
      //   Provider.of<CartPageController>(context, listen: false).getProduct();
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerDetails = context.watch<ProductDetailsController>();

    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: providerDetails.isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(
                            context,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                        ),
                        Text(
                          'Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                        Stack(
                          children: [
                            Icon(
                              Icons.notifications_none,
                              size: 40,
                            ),
                            Positioned(
                              top: 6,
                              right: 4,
                              child: CircleAvatar(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                radius: 9,
                                backgroundColor: Colors.black,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  //scroll
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        providerDetails.productDetails != null
                                            ? providerDetails
                                                .productDetails!.image
                                                .toString()
                                            : AppURL.defaultImg,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.favorite_border_outlined,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              providerDetails.productDetails!.title.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '⭐ ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '4.5/5',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '(45 reviews)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                providerDetails.productDetails!.description
                                    .toString()),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Choose Size',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      )),
                                  child: Center(
                                    child: Text(
                                      'S',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      )),
                                  child: Center(
                                    child: Text(
                                      'M',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      )),
                                  child: Center(
                                    child: Text(
                                      'L',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 9.0),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(width: .9)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 12),
                            ),
                            Text(
                              providerDetails.productDetails!.price.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),

                        // add to cart btn
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<CartPageController>(context,
                                      listen: false)
                                  .addProduct(
                                      id: providerDetails.productDetails!.id!,
                                      name:
                                          providerDetails
                                              .productDetails!.title
                                              .toString(),
                                      price: providerDetails
                                              .productDetails!.price ??
                                          0,
                                      desc: providerDetails
                                          .productDetails!.description
                                          .toString(),
                                      image: providerDetails
                                          .productDetails!.image
                                          .toString());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(
                                      id: providerDetails.productDetails!.id!,
                                    ),
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
