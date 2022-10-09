import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';


///  Created by youssouphafaye on 10/8/22.
class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavorites;
  const ProductsGrid({
     required this.showOnlyFavorites,
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    List<Product> loadedProduct= [];
    if (showOnlyFavorites == false) loadedProduct = Provider.of<Products>(context).listAll;
    if(showOnlyFavorites == true)  loadedProduct = Provider.of<Products>(context).listFavorites;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProduct.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(
        value: loadedProduct[i],
        child: ProductItem(
          key: ValueKey(loadedProduct[i].id),),
      ),
    );
  }
}
