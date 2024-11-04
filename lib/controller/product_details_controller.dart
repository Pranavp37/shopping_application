import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingui/model/product_model.dart';

class ProductDetailsController with ChangeNotifier {
  bool isloading = false;
  ProductModel? productDetails;
  Future<void> getProductDetails(int id) async {
    isloading = true;
    notifyListeners();
    var url = Uri.parse('https://fakestoreapi.com/products/$id');
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        productDetails = productModelFromjson(response.body);
      }
    } catch (error) {
      log('$error');
    }
    isloading = false;
    notifyListeners();
  }
}
