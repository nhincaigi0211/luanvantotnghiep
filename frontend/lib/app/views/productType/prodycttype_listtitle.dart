import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../agruments.dart';
import '../../../route.dart';

import '../../models/producttype.dart';

class ProductlistTitle extends StatelessWidget {
  final Producttype producttype;

  const ProductlistTitle(this.producttype, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 30,
        width: 100,
          child: TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 239, 175, 196)),
            ),
            onPressed: (){
              Navigator.of(context).pushNamed(ProductFilter.routeName,
                        arguments: ScreenArguments(producttype.proT_Code,producttype.proT_Name));
            },
            child: Text(producttype.proT_Name, style: const TextStyle(color: Colors.white,),),
          )
      ),
    );
  }
}