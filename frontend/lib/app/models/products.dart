// ignore_for_file: non_constant_identifier_names

class Product {
  final String? id;
  final String product_productId;
  final String product_Ma;
  final String product_Ten;
  final String product_MoTa;
  final int product_Price;
  final Object? product_cmt;

  Product({
    this.id,
    required this.product_productId,
    required this.product_Ma,
    required this.product_Ten,
    required this.product_MoTa,
    required this.product_Price,
    required this.product_cmt,
  });

  Product coppyWith({
    String? id,
    String? product_productId,
    String? product_Ma,
    String? product_Ten,
    String? product_MoTa,
    int? product_Price,
    Object? product_cmt,
}){
    return Product(
      id: id ?? this.id,
      product_Ma: product_Ma ?? this.product_Ma,
      product_Ten: product_Ten ?? this.product_Ten,
      product_MoTa: product_MoTa ?? this.product_MoTa,
      product_Price: product_Price ?? this.product_Price,
      product_cmt: product_cmt ?? this.product_cmt,
      product_productId: product_productId ?? this.product_productId,
    );
  }

  static Product fromJson(Map<String, dynamic> json){
    return Product(
      id: json['_id'],
      product_Ma: json['product_Ma'],
      product_Ten: json['product_Ten'],
      product_MoTa: json['product_MoTa'],
      product_Price: json['product_Price'],
      product_cmt: json['product_cmt'],
      product_productId: json['product_productId'],
    );
  }

  Map<String, dynamic> toJson(String? id){
    return {
      'id':id,
      'product_Ma' : product_Ma,
      'product_Ten' : product_Ten,
      'product_MoTa' : product_MoTa,
      'product_Price' : product_Price,
      'product_cmt' : product_cmt,
      'product_productId' : product_productId,
    };
  }
}