// import 'package:flutter/material.dart';
// import 'package:frontend/app/views/productType/productType_grid.dart';
// import 'package:provider/provider.dart';
// import '../products/product_overview.dart';
// import 'productType_manager.dart';
// // import 'user_grid.dart';

// class ProductTypeOverViewScreen extends StatefulWidget{
//   static const routeName = '/ProductTypeOverView';
//   final String producttype;
//   const ProductTypeOverViewScreen(this.producttype, {super.key});
//   @override
//   State<ProductTypeOverViewScreen> createState() => _ProductTypeOverViewScreenState();
// }

// class _ProductTypeOverViewScreenState extends State<ProductTypeOverViewScreen>{
//   late Future<void> _getUser;
//   @override
//   void initState(){
//     super.initState();
//     _getUser = context.read<ProductTypeManager>().getUser();
//   }

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: FutureBuilder(
//         future: _getUser,
//         builder: (context, snapshot){
//           if(snapshot.connectionState == ConnectionState.done){
//             return ProductsOverViewScreen(widget.producttype);
//             }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }