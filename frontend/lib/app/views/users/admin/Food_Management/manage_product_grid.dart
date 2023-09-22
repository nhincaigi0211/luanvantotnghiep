import 'package:frontend/app/models/producttype.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../../../route.dart';
import '../../../products/product_manager.dart';
import 'manage_product_gridtitle.dart';

class Manage_ProductsGrid extends StatelessWidget {
  final String products;

  const Manage_ProductsGrid(this.products,{super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = context.read<ProductsManager>();
    if (products != '') {
      final product = productsManager.filterItems(products);
      if (products.isEmpty) {
        return Text('Danh sách trống!');
      } else {
        return gridFilter(product);
      }
    } else {
      final products = context.read<ProductsManager>();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách món ăn', textAlign: TextAlign.center,),
          actions: [
            IconButton(
              onPressed: (){
                // Navigator.of(context).pushNamed(GetData.routeName);
              },
              icon: const Icon(
                Icons.search
              ))
          ],
          ),
          drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Danh mục quản lý'),
              decoration: BoxDecoration(color: Colors.red),
            ),
            ListTile(
              title: const Text('Thêm sản phẩm'),
              onTap: (){
                Navigator.of(context)
                              .pushNamed(ProductForm.routeName);
              },
            ),
          ],
        ),
      ),
          body: products.itemCount < 0 ? Text('Danh sách rỗng')
          :Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: products.itemCount,
              itemBuilder: (context, i){
                return Manage_ProductsGridTitle(products.items[i]);
              },
            ),
          ),
        )
          );
    }
  }

  Widget gridFilter(List products) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(5),
      itemCount: products.length,
      itemBuilder: (ctx, i) {
        return Manage_ProductsGridTitle(products[i]);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}

