import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../agruments.dart';
import '../../../route.dart';

import '../../models/products.dart';

// ignore: must_be_immutable
class ProductGridTitle extends StatelessWidget {
  final Product product;
  int a = 0;
  ProductGridTitle(this.product, {super.key});
  sum(){
    a++;
  }
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(children: [
        GridTile(
        footer: buildGridFooterBar(context),
        child: GestureDetector(
          onTap: () {
            sum();
            print(a); 
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.pinkAccent),
                borderRadius: BorderRadius.circular(10)),
            child:  Row(
              children: <Widget>[
                buildEditButton(context),
              ],
            ),
          ),
        ),
      ),
      
      ],)
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return Container(
      
      height: 70,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.pinkAccent)),
      child: GridTileBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ProductDetail.routeName,
                arguments: ScreenArguments(
                    product.id, product.product_Ten.toString()));
          },
          child: Column(
            children: [
              Text(
                product.product_Ten.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${product.product_Price} VND',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context)
            .pushNamed(ProductForm.routeName, arguments: product.id);
      },
      icon: const Icon(Icons.edit),
      color: Colors.red,
    );
  }
}
