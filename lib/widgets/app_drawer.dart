import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

///  Created by youssouphafaye on 10/9/22.
class AppDrawer extends StatelessWidget {
  List<Widget> setDrawerElement(
      {required IconData icons, required BuildContext context, required String title,required String route}){
    return [
      const Divider(thickness: 2,),
      ListTile(
        leading: Icon(icons),
        title: Text(title),
        onTap: (){
          Navigator.of(context).pushReplacementNamed(route);
        },
      )
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text("Drawer here"),automaticallyImplyLeading: false,),
          ...setDrawerElement(
              icons: Icons.shop,
              context: context,
              title: "Shop",
              route: ProductOverviewScreen.route),
          ...setDrawerElement(
              icons: Icons.payment,
              context: context,
              title: "Orders",
              route: OrderScreen.route),
          ...setDrawerElement(
              icons: Icons.edit,
              context: context,
              title: "manage product",
              route: UserProductsScreen.route)


        ],
      ),
    );
  }
}
