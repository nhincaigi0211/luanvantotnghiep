import 'package:flutter/widgets.dart';
import 'package:frontend/app/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../models/products.dart';
import '../models/comment.dart';
  final Url = Uri.parse('http://192.168.1.101:8000/api/products/product/');

class ProductsService extends ChangeNotifier{
  ProductsService();

  Future<List<Product>> makeUsersGetRequest() async {
    final List<Product> products = [];
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(Url, headers: requestHeaders);

      final productMap = await json.decode(response.body);

      if (response.statusCode != 200) {
        print(productMap['error']);
        return products;
      }
      productMap.forEach((element) {
        products.add(Product.fromJson(element));
      });
      // print(productMap);
      final a = products[0].product_cmt as dynamic;
      final List<Comment> ah = [];
      final List<User> cmtUser = [];
      a.forEach((element){
        ah.add(Comment.fromJson(element));
      });
   

      return products;
    } catch (error) {
      print(error);
      return products;
    }
  }

  Future makeDeleteRequest(String id) async {
    try{
      final url = Uri.parse('$Url$id');
      final response = await http.delete(url);

      if(response.statusCode != 200){
      print('$Url$id');
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    }catch (error){
      print(error);
      return false;
    }
  }

  Future<List<Product>> makeGetUserRequest (String id) async{
    final List<Product> products = [];
    try{
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(Url, headers: requestHeaders);

      final productMap = await json.decode(response.body);

      if (response.statusCode != 200) {
        print(productMap['error']);
        return products;
      }
      productMap.forEach((element) {
        products.add(Product.fromJson(element));
      });
      print(productMap);

      return products;
    }catch(error){
      print(error);
      return products;
    }
  }

  Future<Product?> addProduct(Product product) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await http.post(Url,
          body: json.encode(product.toJson(product.id)
            ..addAll({})),
          headers: requestHeaders);
      print(response.body);
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return product.coppyWith(id: json.decode(response.body)['product_Ten']);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateProduct(Product product) async{
    try{
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final url = Uri.parse('$Url${product.id}');
      final response = await http.put(url,
          body: json.encode(product.toJson(product.id)),
          headers: requestHeaders
      );
      print(product.id);
      if(response.statusCode != 200){
        print('$Url${product.id}');
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    }catch(error){
      print(error);
      return false;
    }
  }
}