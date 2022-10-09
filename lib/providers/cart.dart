import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get numberOfItemInCart {
    return _items.length;
  }

  void deleteItem(String id) {
    _items.removeWhere((key, value) => value.id == id);
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  void addItem(
      {required String productId,
      required double price,
      required String title}) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (cartItem) {
        cartItem.quantity += 1;
        return cartItem;
      });
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  String findKeyByCartItemId(String id){
    String key = "";
    _items.forEach((keyi, value) {
      if(value.id == id) {
        key = keyi;
        return;
      }
    });
    return key;
  }
  void addAnother (String id){
    String key = findKeyByCartItemId(id);
    _items.update(key, (value) {
      value.quantity+=1;
      return value;
    });
    notifyListeners();
  }
  void undoAddItem(String productId) {
    CartItem? ci = _items[productId];
    print(productId);
    print("quantity : ${ci?.quantity}");
    if (ci?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(productId, (value) {
        value.quantity -= 1;
        return value;
      });
    }

    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
