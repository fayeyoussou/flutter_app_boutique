import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

///  Created by youssouphafaye on 10/9/22.
class UserProductItem extends StatelessWidget {
  final Product product;
  const UserProductItem(this.product,Key key):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl),),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(EditProductScreen.route,arguments: product);
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
                onPressed: (){
                  Provider.of<Products>(context,listen: false).deleteProduct(product.id);
                },
                icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
