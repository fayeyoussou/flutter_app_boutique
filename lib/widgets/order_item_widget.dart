import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/order_item.dart';

///  Created by youssouphafaye on 10/9/22.
class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItem;

  const OrderItemWidget({required Key key, required this.orderItem}) : super(key: key);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var expanded = false; 
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$ ${widget.orderItem.amount.toStringAsFixed(2)}"),
            subtitle: Text(DateFormat('dd/M/yyyy hh:mm').format(widget.orderItem.dateOrder)),
            trailing: IconButton(
              icon: expanded ? const Icon(Icons.expand_less): const Icon(Icons.expand_more),
              onPressed: () { 
                setState(() {
                  expanded=!expanded;
                });
              },
            ),
          ),
          if(expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(widget.orderItem.products.length*20.0+100, 100),
              child: ListView(
                children: widget.orderItem.products.
                map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(prod.title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('\$ ${prod.price} x ${prod.quantity}',style: const TextStyle(fontSize: 18,color: Colors.blueGrey),)
                  ],
                )).toList(),
              ),
            )
        ],
      ),
    );
  }
}
