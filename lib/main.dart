import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingui/controller/product_home_controller.dart';
import 'package:shoppingui/views/onboard/onboard.dart';

void main() {
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
      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Onboard(),
      ),
    );
  }
}
