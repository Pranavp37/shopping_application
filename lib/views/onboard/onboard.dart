import 'package:flutter/material.dart';
import 'package:shoppingui/views/HomeScreen/home_screen.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://img.freepik.com/premium-photo/fun-illustration-american-referee_183364-64970.jpg'))),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        )),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            border: Border(
                                top: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ))),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35,
                              )
                            ],
                          ),
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
