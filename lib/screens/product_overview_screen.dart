import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { favorites, all }

///  Created by youssouphafaye on 10/7/22.
class ProductOverviewScreen extends StatefulWidget {
  static const route = "/produits";
  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Overview "),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selected) {
                if (selected == FilterOptions.favorites) {
                  setState(() {
                    _showOnlyFavorites = true;
                  });
                } else {
                  setState(() {
                    _showOnlyFavorites = false;
                  });
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text("only favorites"),
                      value: FilterOptions.favorites,
                    ),
                    const PopupMenuItem(
                      child: Text("show all"),
                      value: FilterOptions.all,
                    )
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                key: ValueKey(Random.secure().nextInt(10)),
                child: ch as Widget,
                value: cart.numberOfItemInCart.toString(),
                color: Colors.amber ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.route);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(showOnlyFavorites: _showOnlyFavorites),
    );
  }
}
