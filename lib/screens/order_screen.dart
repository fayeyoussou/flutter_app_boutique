import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item_widget.dart';

import '../providers/orders.dart';

///  Created by youssouphafaye on 10/9/22.
class OrderScreen extends StatelessWidget {
  static String route = "/order";
  @override
  Widget build(BuildContext context) {
    Orders orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        
      ),
      drawer: AppDrawer(),
      body: ListView.builder(itemBuilder: (context,i)=>OrderItemWidget(key: ValueKey(orders.list[i].id), orderItem: orders.list[i]),itemCount: orders.list.length,),
    );
  }
}
