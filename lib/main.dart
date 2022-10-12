import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => Products(),),
        ChangeNotifierProvider(create: (BuildContext context) => Cart(),),
        ChangeNotifierProvider(create: (BuildContext context) => Orders(),),
        ChangeNotifierProvider(create: (BuildContext ctx)=>Auth())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestion Des Dons',
        theme: ThemeData(
          colorScheme:
          ColorScheme
              .fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: const Color.fromRGBO(200, 255, 190, 0.9))
              .copyWith(tertiary: const Color.fromRGBO(230, 190, 174, 1))
              .copyWith(error: const Color.fromRGBO(225, 43, 53, 1)),
          fontFamily: 'Lato'
        ),
        home:  AuthScreen(),
        routes: {
            ProductOverviewScreen.route :(ctx)=> ProductOverviewScreen(),
            ProductDetailScreen.route : (ctx)=>ProductDetailScreen(),
            CartScreen.route:(ctx)=>CartScreen(),
            OrderScreen.route:(ctx)=>OrderScreen(),
            UserProductsScreen.route:(ctx)=>UserProductsScreen(),
            EditProductScreen.route:(ctx)=> EditProductScreen(),
            AuthScreen.routeName:(ctx)=>AuthScreen()
        },
      ),
    );
  }
}


