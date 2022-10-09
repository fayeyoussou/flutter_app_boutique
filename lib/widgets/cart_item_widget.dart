import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

///  Created by youssouphafaye on 10/9/22.
class CartItemWidget extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  const CartItemWidget(
      {required Key key,
      required this.id,
      required this.price,
      required this.quantity,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),

      onDismissed: (_) {
          cart.deleteItem(id);
      },
      confirmDismiss: (dir) {
        if (dir.index != 2) {
          cart.addAnother(id);
          return Future.value(false);
        } else {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Are you sure ? "),
                    content: Text("Do you want remove $title from the cart"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop(false);
                      }, child: const Text("NO")),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop(true);
                      }, child: const Text("YES"))
                    ],
                  ),

          );
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: FittedBox(child: Text('\$ $price'))),
              ),
              title: Text('$title x $quantity'),
              subtitle: Text('Total : \$ ${price * quantity}'),
              trailing: Text('x $quantity')),
        ),
      ),
    );
  }
}
