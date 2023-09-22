import 'package:frontend/app/models/producttype.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'product_manager.dart';
import 'product_gridtitle.dart';

class ProductsGrid extends StatelessWidget {
  final String filter;

  const ProductsGrid(this.filter,{super.key});
  @override
  Widget build(BuildContext context) {
    final productsManager = context.read<ProductsManager>();
    if (filter != '') {
      final products = productsManager.filterItems(filter);
      if (products.isEmpty) {
        return Text('Danh sách trống!');
      } else {
        return gridFilter(products);
      }
    } else {
      final products = context.read<ProductsManager>();
      return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 600,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                  ),
                  child: products.itemCount <= 0
                            ? const Text('Danh sách rỗng') : GridView.builder(
                          padding: const EdgeInsets.all(10),
                          scrollDirection: Axis.vertical,
                          itemCount: products.itemCount,
                          itemBuilder: (ctx, i) {
                            return ProductGridTitle(products.items[i]);
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                        ),
                ),
              ),
              // Container(
              //   height: 60,
              //   width: 376,
              //   decoration: BoxDecoration(border: Border.all(width: 0.5)),
              //     child: const Padding(
              //       padding: EdgeInsets.all(10),
              //       child: Text('Tổng tiền: ', style: TextStyle(fontSize: 15),),
              //     ),
              //   )
            ],)
          );
    }
  }

  Widget gridFilter(List products) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(5),
      itemCount: products.length,
      itemBuilder: (ctx, i) {
        return ProductGridTitle(products[i]);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}

