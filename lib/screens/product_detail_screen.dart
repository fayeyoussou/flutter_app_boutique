import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products.dart';

///  Created by youssouphafaye on 10/8/22.
class ProductDetailScreen extends StatelessWidget {
  static const route = "product/detail";

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)?.settings.arguments as String;
    Product product =
        Provider.of<Products>(context, listen: false).getProductById(id);
    const Widget height10 = SizedBox(height: 10,);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          height10,
          Text(
            '\$ ${product.price}',
            style: const TextStyle(color: Colors.green, fontSize: 20),
          ),
          height10,
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(product.description,textAlign: TextAlign.center,softWrap: true,))
        ]),
      ),
    );
  }
}
