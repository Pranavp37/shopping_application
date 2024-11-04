import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shoppingui/controller/cart_page_controller.dart';
import 'package:shoppingui/controller/product_details_controller.dart';
import 'package:shoppingui/controller/product_home_controller.dart';
import 'package:shoppingui/model/cart_model.dart';
import 'package:shoppingui/views/onboard/onboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  var box = await Hive.openBox<CartModel>('Card_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductHomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartPageController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Onboard(),
      ),
    );
  }
}
