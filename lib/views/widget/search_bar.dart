import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(15)),
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: 18),
              fillColor: Colors.grey[300],
              filled: true,
              prefixIcon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 55,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black),
          child: Icon(
            Icons.filter_list,
            color: Colors.white,
            size: 28,
          ),
        )
      ],
    );
  }
}