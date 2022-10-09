import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

///  Created by youssouphafaye on 10/9/22.
class UserProductsScreen extends StatelessWidget {
  static String route ="/products";
  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.route,arguments: null);
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(itemBuilder: (context,index){
          return Column(children: [
            UserProductItem(products.listAll[index], ValueKey(products.listAll[index])),
            const Divider()
          ]);
        },itemCount: products.listAll.length,),
      ),
      drawer: AppDrawer(),
    );
  }
}
