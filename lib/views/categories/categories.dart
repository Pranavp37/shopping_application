import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  Categories({super.key, required this.text, this.containerClr, this.textClr});
  final String text;
  final Color? containerClr;
  final Color? textClr;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: containerClr,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(
              color: textClr,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
