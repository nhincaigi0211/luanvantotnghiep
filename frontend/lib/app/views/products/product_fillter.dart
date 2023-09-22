import 'package:flutter/material.dart';
import 'package:frontend/app/models/producttype.dart';
import 'product_grid.dart';
import 'package:provider/provider.dart';
import '../../../route.dart';

class ProductFilter extends StatelessWidget {
  final String filter;
  const ProductFilter(this.filter, {super.key});
  static const routeName = '/product_grid_filter';
  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductsManager>().filterItems(filter);
    final name = context.read<ProductTypeManager>().findById(filter);
      return Scaffold(
        appBar: AppBar(
          title: Text(name!.proT_Name.toString()),
        ),
        body: GridView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          itemBuilder: (ctx, i) {
            return ProductGridTitle(products[i]);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 10),
        ),
      );
  }
}
