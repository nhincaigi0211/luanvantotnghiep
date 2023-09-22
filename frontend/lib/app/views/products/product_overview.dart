import 'package:flutter/material.dart';
import 'package:frontend/route.dart';
import 'package:provider/provider.dart';
import '../productType/productType_grid.dart';

import 'product_manager.dart';
import 'product_grid.dart';

class ProductsOverViewScreen extends StatefulWidget{
  static const routeName = '/productsOverView';
  final String producttype;
  final String filter;
  const ProductsOverViewScreen(this.filter, this.producttype, {super.key});
  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen>{
  late Future<void> _getUser;
  late Future<void> _getProducttype;
  @override
  void initState(){
    super.initState();
    _getUser = context.read<ProductsManager>().getProducts();
    _getProducttype = context.read<ProductTypeManager>().getUser();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Thực đơn'),
          backgroundColor: Colors.pinkAccent,
        ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: FutureBuilder(
            future: _getProducttype, 
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                 return ProductTypeGrid(widget.producttype);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            ),
          ),
          Expanded(child:FutureBuilder(
            future: _getUser,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                 return ProductsGrid(widget.filter);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),)
        ],
      ),
    );
  }
}