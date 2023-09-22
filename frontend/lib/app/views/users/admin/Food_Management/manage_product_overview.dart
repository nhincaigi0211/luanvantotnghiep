import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/app/views/users/admin/product_form.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../../../products/product_manager.dart';
import 'package:frontend/app/views/users/admin/Food_Management/manage_product_Grid.dart';

// ignore: camel_case_types
class Manage_ProductsOverViewScreen extends StatefulWidget{
  static const routeName = '/Manage_productsOverView';
  final String products;
  const Manage_ProductsOverViewScreen(this.products, {super.key});
  @override
  State<Manage_ProductsOverViewScreen> createState() => _Manage_ProductsOverViewScreenState();
}

// ignore: camel_case_types
class _Manage_ProductsOverViewScreenState extends State<Manage_ProductsOverViewScreen>{
  late Future<void> _getProducts;

  // ignore: non_constant_identifier_names
  Future<Void> _RefreshProduct() async{
    return Future.delayed(const Duration(milliseconds: 1));
  }
  @override
  void initState(){
    super.initState();
    _getProducts = context.read<ProductsManager>().getProducts();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: _RefreshProduct,
        color: Colors.pinkAccent[100],
        height: 50,
        child: FutureBuilder(
        future: _getProducts,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Manage_ProductsGrid(widget.products);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),)
    );
  }
}
