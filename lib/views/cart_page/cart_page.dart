import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoppingui/controller/cart_page_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, this.id});
  final int? id;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<CartPageController>().getProduct();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartcontroller = context.watch<CartPageController>();
    return Scaffold(
        appBar: AppBar(
          title: Text('My Cart'),
        ),
        bottomNavigationBar: Container(
            height: 100,
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  'Total Price -${cartcontroller.TotalAmt.toString()}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_live_ILgsfZCZoFIKMb',
                      'amount': cartcontroller.TotalAmt * 100,
                      'name': 'Acme Corp.',
                      'description': 'Fine T-Shirt',
                      'retry': {'enabled': true, 'max_count': 1},
                      'send_sms_hash': true,
                      'prefill': {
                        'contact': '8888888888',
                        'email': 'test@razorpay.com'
                      },
                      'external': {
                        'wallets': ['paytm']
                      }
                    };
                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                        handlePaymentErrorResponse);
                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                        handlePaymentSuccessResponse);
                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                        handleExternalWalletSelected);
                    razorpay.open(options);
                  },
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                    ),
                    child: Center(
                        child: Text(
                      'checkbox',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                )
              ],
            )),
        body: ListView.separated(
            itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(cartcontroller
                                        .cartProduct[index].image
                                        .toString())),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            SizedBox(width: 15),
                            // Title, Price, and Description Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    cartcontroller.cartProduct[index].name
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    maxLines: 2,
                                    cartcontroller.cartProduct[index].price
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    cartcontroller.cartProduct[index].desc
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                            // Quantity and Remove Button Column
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartPageController>()
                                        .increment(index);
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_up_sharp,
                                    size: 38,
                                  ),
                                ),
                                Text(
                                  cartcontroller.cartProduct[index].qty
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                ),

                                IconButton(
                                  onPressed: () {
                                    Provider.of<CartPageController>(context,
                                            listen: false)
                                        .decrement(index);
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    size: 38,
                                  ),
                                ),
                                SizedBox(height: 10),

                                //Remove Button
                                MaterialButton(
                                  color: Colors.redAccent,
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<CartPageController>()
                                        .removeCartProduct(index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: cartcontroller.cartProduct.length));
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
