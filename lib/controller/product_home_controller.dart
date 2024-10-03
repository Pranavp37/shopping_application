import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingui/model/product_model.dart';

class ProductHomeController with ChangeNotifier {
  int selectedcat = 0;

  List productCategories = ['All'];

  bool isCategoriesLoading = false;

  bool isloading = false;


  List<ProductModel> productData = [];

  Future<void> getAlldata() async {
    isloading = true;
    notifyListeners();
    var url = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        productData = productModelFromJson(response.body);
      }
    } catch (error) {
      log('$error');
    }
    isloading = false;
    notifyListeners();
  }

  Future<void> getCategory() async {
    productCategories = ['All'];
    isCategoriesLoading = true;
    notifyListeners();
    var url = Uri.parse('https://fakestoreapi.com/products/categories');
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        productCategories.addAll(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    isCategoriesLoading = false;
    notifyListeners();
  }

  void onCaterogorySelection(int index) {
    selectedcat = index;
    if (selectedcat == 0) {
      getAlldata();
    } else {
      getCatgoryDAta(productCategories[index]);
    }
    notifyListeners();
  }

  Future<void> getCatgoryDAta(String categories) async {
    isloading = true;
    notifyListeners();
    var url =
        Uri.parse('https://fakestoreapi.com/products/category/$categories');
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        productData = productModelFromJson(response.body);
      }
    } catch (error) {
      log('$error');
    }
    isloading = false;
    notifyListeners();
  }
}
