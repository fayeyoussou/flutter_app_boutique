import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

///  Created by youssouphafaye on 10/9/22.
class EditProductScreen extends StatefulWidget {
  static String route = "/produit/edit";
  const EditProductScreen({Key? key}) : super(key: key);
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocus = FocusNode();
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  bool isNew = false;
  bool added = false;
  var _editedProduct = Product(
      id: "",
      title: "",
      description: "",
      price: 0.0,
      imageUrl: "");

  @override
  void initState() {
    _imageFocus.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageFocus.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descNode.dispose();
    _imageUrlController.dispose();
    _imageFocus.removeListener(_updateImageUrl);
    _imageFocus.dispose();
  }

  void saveForm() {
    final isValid = _form.currentState?.validate();
    if(!isValid!) return;
    _form.currentState?.save();
    var products = Provider.of<Products>(context,listen: false);

    if(isNew){
      products.addProduct(_editedProduct).then((value) {
            setState(() {
              isLoading= true;
            });
            Navigator.of(context).pop();
      }).catchError((error){
           showDialog(context: context, builder: (ctx)=>
            AlertDialog(
             title: const Text("Error occurred"),
             content: Text(error.toString()),
             actions: [
               TextButton(onPressed: (){
                 setState(() {

                   isLoading = false;
                 });
                 Navigator.of(context).pop();
               }, child: const Text("OK"))
             ],
           )
         ).then((value) => Navigator.of(context).pop());
      }).then((value) => (_){
        setState(() {
          isLoading=false;
          Navigator.of(context).pop();
        });
      });
    }
    else {
      products.editProduct(_editedProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Product? product = ModalRoute.of(context)?.settings.arguments as Product?;
    isNew = product == null;
    if (!isNew && !added) {
      added =true;
      _editedProduct.id=product!.id;
      _imageUrlController.text = product.imageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? "Add produit" : "Edit Produit ${product!.title}"),
        actions: [
          IconButton(
              onPressed: () {
                saveForm();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: isLoading? const Center(
        child: CircularProgressIndicator(),
      ): Padding(
        padding: const EdgeInsets.all(60),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "titre",
                  ),
                  textInputAction: TextInputAction.next,
                  initialValue: isNew ? "" : product!.title,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: value as String,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) return "price can't be null";
                    if (value.isEmpty) return "price can't be empty";
                    if (double.tryParse(value) == null) {
                      return "price have to be a decimal number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "price",
                  ),
                  textInputAction: TextInputAction.next,
                  initialValue: isNew ? "" : product!.price.toStringAsFixed(2),
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_imageFocus);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value as String),
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 1)),
                      child: FittedBox(
                        child: Image.network(_imageUrlController.text.isEmpty
                            ? "https://www.depiend.hu/images/missing.png"
                            : _imageUrlController.text),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        maxLines: 4,
                        focusNode: _imageFocus,
                        controller: _imageUrlController,
                        decoration:
                            const InputDecoration(labelText: "image url"),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_descNode);
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value as String);
                        },
                      ),
                    )
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "description",
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  initialValue: isNew ? "" : product!.description,
                  focusNode: _descNode,
                  onFieldSubmitted: (_) {
                    saveForm();
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: value as String,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
