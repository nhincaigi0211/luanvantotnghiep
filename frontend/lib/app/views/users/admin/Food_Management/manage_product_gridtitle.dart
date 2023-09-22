import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../agruments.dart';
import '../../../../models/products.dart';
import '../../../../../route.dart';


class Manage_ProductsGridTitle extends StatefulWidget {
  final Product product;
  const Manage_ProductsGridTitle(this.product, {super.key});
  @override
  State<Manage_ProductsGridTitle> createState() => _Manage_ProductsGirdTitleState();

}
class _Manage_ProductsGirdTitleState extends State<Manage_ProductsGridTitle>{
  @override
  Widget build(BuildContext context){
    return ExpansionTile(
      leading: CircleAvatar(
        radius: 20,
        child: Text(widget.product.product_Ma.toString(), style: TextStyle(fontSize: 20),),
      ),
        title: Text(widget.product.product_Ten.toString()),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(ProductDetail.routeName,
                arguments: ScreenArguments(
                    widget.product.id, widget.product.product_Ten.toString()));
                    },
                    child: Text('Chi Tiết')
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context)
            .pushNamed(ProductForm.routeName, arguments: widget.product.id);
                  }, 
                  child: Text('Chỉnh sửa')
                ),
                TextButton(
                    onPressed: (){
                      context.read<ProductsManager>().deleteProduct(widget.product.id!);
                      _ShowConfirm();
                    },
                      child: const Text('Xóa'),)
                      
              ],
            ),
          )

      ],
    );
  }
  
  _ShowConfirm(){
    QuickAlert.show(
      context: context,
      title: 'Warning',
      text: 'Bạn có muốn xóa sản phẩm này không?',
      type: QuickAlertType.confirm);

  }
}