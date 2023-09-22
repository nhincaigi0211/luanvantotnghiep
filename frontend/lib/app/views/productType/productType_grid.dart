import 'package:frontend/app/models/producttype.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'prodycttype_listtitle.dart';
import '../products/product_manager.dart';

class ProductTypeGrid extends StatelessWidget{
  final String productt;
  const ProductTypeGrid(this.productt, {super.key});
  @override
  Widget build(BuildContext context){
    final productTypeManager = context.read<ProductTypeManager>();
    if(productt != ''){
      final producttype = productTypeManager.filterItems(productt);
      if(producttype.isEmpty){
        return Text('Danh sách trống');
      }else{
        return gridFilter(producttype);
      }
    }else{
      final producttype = context.read<ProductTypeManager>();

      return Scaffold(
        body: producttype.itemCount < 0
          ? const Text('Danh sách rỗng')
          : ListView.builder(
            // padding: EdgeInsets.all(),
            scrollDirection: Axis.horizontal,
            itemCount: producttype.itemCount,
            itemBuilder: (ctx, i){
              return ProductlistTitle(producttype.items[i]);
            },
        ),
      );
    }
  }
  Widget gridFilter(List producttype) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      itemCount: producttype.length,
      itemBuilder: (ctx, i) {
        return Text(producttype[i]);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}