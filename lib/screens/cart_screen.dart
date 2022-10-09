import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item_widget.dart';

import '../models/cart_item.dart';

///  Created by youssouphafaye on 10/9/22.
class CartScreen extends StatelessWidget {
  static String route = "cart";
  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);

    List<CartItem> cartItems = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("your cart"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemBuilder: (context,i)=> CartItemWidget(key: ValueKey(cartItems[i].id), id: cartItems[i].id, price: cartItems[i].price, quantity: cartItems[i].quantity, title: cartItems[i].title),
                itemCount: cart.numberOfItemInCart,)
          ),
          const SizedBox(height: 10,),
          Card(
            margin: const EdgeInsets.all(50),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total",style: TextStyle(fontSize: 20),),
                  const Spacer(),
                  const SizedBox(width: 10,),
                  Chip(
                    label: Text('\$ ${cart.totalAmount.toStringAsFixed(2)}'),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                      onPressed: (){
                        Orders orders = Provider.of<Orders>(context,listen: false);
                        orders.addOrder(cartItems, cart.totalAmount);
                        cart.clear();
                      },
                      child: const Text("Order Now"),
                      style:TextButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                      ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
