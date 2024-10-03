import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.all(20),
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.red.shade100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "data",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_drop_up)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
