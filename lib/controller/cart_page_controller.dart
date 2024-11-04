import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shoppingui/model/cart_model.dart';

class CartPageController with ChangeNotifier {
  List<CartModel> cartProduct = [];
  final cartBox = Hive.box<CartModel>('Card_box');
  List keys = [];
  double TotalAmt = 0;

  Future<void> addProduct({
    required int id,
    String? image,
    required String name,
    required double price,
    required String desc,
  }) async {
    bool isAlreadyCart = false;

    for (int i = 0; i < cartProduct.length; i++) {
      if (id == cartProduct[i].id) {
        isAlreadyCart = true;
      }
    }

    if (isAlreadyCart) {
      log('Already in cart');
    } else {
      await cartBox.add(CartModel(
        id: id,
        image: image,
        name: name,
        price: price,
        desc: desc,
        qty: 1,
      ));
    }

    log("${cartBox.values}");
    getProduct();
  }

  void getProduct() {
    keys = cartBox.keys.toList();
    cartProduct = cartBox.values.toList();
    calculateTotalAmt();
    notifyListeners();
  }

  void removeCartProduct(int index) {
    cartBox.deleteAt(index);
    getProduct();
  }

  void increment(int index) {
    int quantity = cartProduct[index].qty ?? 1;
    if (quantity < 10) {
      quantity++;

      cartBox.put(
          keys[index],
          CartModel(
            id: cartProduct[index].id,
            desc: cartProduct[index].desc,
            image: cartProduct[index].image,
            name: cartProduct[index].name,
            price: cartProduct[index].price,
            qty: quantity,
          ));
    }
    getProduct();
  }

  void decrement(int index) {
    int quantity = cartProduct[index].qty ?? 1;

    if (quantity > 1) {
      quantity--;

      cartBox.put(
          keys[index],
          CartModel(
            id: cartProduct[index].id,
            desc: cartProduct[index].desc,
            image: cartProduct[index].image,
            name: cartProduct[index].name,
            price: cartProduct[index].price,
            qty: quantity,
          ));
    }
    getProduct();
  }

  void calculateTotalAmt() {
    TotalAmt = 0;
    for (int i = 0; i < cartProduct.length; i++) {
      TotalAmt += (cartProduct[i].price! * cartProduct[i].qty!);
    }

    log('$TotalAmt');
  }
}
