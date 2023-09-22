import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../agruments.dart';
import '../cart/cart_Item.dart';
import 'table_manager.dart';
import '../../models/table.dart';
import '../../../route.dart';

class TableGridTitle extends StatefulWidget {
  final Tables tables;

  const TableGridTitle(this.tables, {super.key});

  @override
  State<TableGridTitle> createState() => _TableGridTitleState();
}

class _TableGridTitleState extends State<TableGridTitle> {
  String check(){
    String a ='';
    if(widget.tables.table_TrangThai == true){
      a = 'Hoạt động';
    }else{
      a = 'Bảo trì';
    }
    return a;
  }

  @override
  Widget build(BuildContext context) {
  final cart = context.watch<CartManager>();
    return GridTile(
      footer: buildGridFooterBar(context),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.pinkAccent),
              borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: (){},
            // ignore: unrelated_type_equality_checks
            child: cart.totalAmount != 0.0
            ? buildCartDetail(cart, context) : status(),
            ),
      ),
    );
  }

  Widget status(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(check())
      );
  }

  Widget buildCartDetail(CartManager cart, BuildContext context){
    String b = cart.getMa;
    print(b);
    return Padding(
      padding: const EdgeInsets.all(0),
      child: widget.tables.table_Ma != b 
      ? status() :
       Row(
        children: <Widget>[
        const Icon(Icons.monetization_on),
        Text(
          cart.totalAmount.toString(),
        )
        ]),  
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return Container(
      height: 41,
      decoration:
          BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.pinkAccent,),
          ),
      child: GridTileBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: TextButton(
          onPressed: () {
          },
          child: Column(
            children: [
              Text(
                widget.tables.cart.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}