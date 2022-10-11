import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  List<Product> get listAll {
    return [..._items];
  }
  void set items (List<Product> products){
    _items = products;
    notifyListeners();
  }

  List<Product> get listFavorites {
    return [..._items.where((element) => element.isFavorite == true)];
  }

  Product getProductById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
  updateProducts(){
    final Uri url= Uri.parse("https://flutter-learn-760fe-default-rtdb.firebaseio.com/products.json");
    try{
      http.get(url).then((res){
        var val = json.decode(res.body) as Map<String,dynamic>;
        List<Product> products = [];
        val.forEach((key, value) {
          String id = key;
          String title = value['title'] as String;
          String description = value['description'] as String;
          double price = value['price'] as double;
          String imageUrl = value['imageUrl'] as String;
          products.add(Product(id: id, title: title, description: description, price: price, imageUrl: imageUrl));

        });
        _items = products;
        notifyListeners();
      });
    }catch(error){
      rethrow;
    }
  }

  Future<Response> fetchAndSetProducts() async {
    final Uri url= Uri.parse("https://flutter-learn-760fe-default-rtdb.firebaseio.com/products.json");
    try {
      return await http.get(url);
    } catch(error){
      rethrow;
    }
  }
  Future<void> addProduct(Product value) async {
    final Uri url= Uri.parse("https://flutter-learn-760fe-default-rtdb.firebaseio.com/products.json");
    try {
      var res = await http.post(url, body: json.encode({
        'title': value.title,
        'description': value.description,
        'imageUrl': value.imageUrl,
        'price': value.price,
        'isFavorite': value.isFavorite
      }));
      value.id = json.decode(res.body)['name'];
      updateProducts();
    }catch(err){
      print(err);
      rethrow;
    }
  }

  void editProduct(Product product) {
    final Uri url= Uri.parse("https://flutter-learn-760fe-default-rtdb.firebaseio.com/products/${product.id}.json");
    _items = _items.map((e) {
      if (e.id == product.id) {
        http.patch(url,body:json.encode({
          'title' : product.title,
          'isFavorite': product.isFavorite,
          'price':product.price,
          'description': product.description
        }));
        updateProducts();
        return product;
      } else {
        return e;
      }
    }).toList();

    notifyListeners();
  }
  void deleteProduct(String id){
    final Uri url= Uri.parse("https://flutter-learn-760fe-default-rtdb.firebaseio.com/products/$id.json");
    http.delete(url);
    updateProducts();
    notifyListeners();
  }
}
