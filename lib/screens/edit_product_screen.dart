import 'package:flutter/material.dart';

import '../providers/product.dart';

///  Created by youssouphafaye on 10/9/22.
class EditProductScreen extends StatefulWidget {
  static String route = "/produit/edit";
  const EditProductScreen({Key? key}) : super(key: key);
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Product? product = ModalRoute.of(context)?.settings.arguments as Product?;
    var isNew = product ==null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew?"Add produit":"Edit Produit ${product.title}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title",),
                  textInputAction: TextInputAction.next,
                  initialValue: isNew ? "":product.title,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title",),
                  textInputAction: TextInputAction.next,
                  initialValue: isNew ? "":product.price.toStringAsFixed(2),
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
