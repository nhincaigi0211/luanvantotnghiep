import 'package:frontend/app/models/products.dart';
import '../views/cart/cart_manager.dart';
import '../models/cart_item.dart';
class Tables {
  final String? id;
  final String table_Ma;
  final String table_Ten;
  final bool table_TrangThai;
  final List<CartItem> cart = [];
  Tables({
    this.id,
    required this.table_Ma,
    required this.table_Ten,
    required this.table_TrangThai,
    required cart,
  });

  static Tables fromJson(Map<String, dynamic> json){
    return Tables(
      id: json['_id'],
      table_Ma : json['table_Ma'],
      table_Ten: json['table_Ten'],
      table_TrangThai: json['table_TrangThai'], 
      cart: [],
    );
  }
  Map<String, dynamic> toJson(String? id){
    final Map<String, dynamic> Tables = new Map<String, dynamic>();
    Tables['id'] = this.id;
    Tables['table_Ma'] = this.table_Ma;
    Tables['table_Ten'] = this.table_Ten;
    Tables['table_TrangThai'] = this.table_TrangThai;
    Tables['cart'] = this.cart;
    return Tables;
  }
  void addItem(Product product, int quantily,String ma) {
    // final cartManager = CartManager();
    // cartManager.addItem(product,quantily, ma);
    if (cart.isEmpty) {
      cart.addAll( {CartItem(
              id: product.id!,
              tensp: product.product_Ten,
              giasp: product.product_Price,
              ma: ma,
              // hinhsp: product.hinhsp,
              soluongsp: quantily > 1 ? quantily : 1)});
    }else{
      for(int i=0; i<cart.length; i++ ){
        if(cart[i].id == product.id){
              cart[i].soluongsp = cart[i].soluongsp + quantily;
        }
      }
    }
    print(cart.length);
  }
  
    // notifyListeners();
}