import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../models/producttype.dart';

  final Url = Uri.parse('http://192.168.1.101:8000/api/producttype/prot');


class ProductTypeService extends ChangeNotifier{
  ProductTypeService();

  Future<List<Producttype>> makeProducttypeGetRequest() async {
    final List<Producttype> producttype = [];
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(Url, headers: requestHeaders);

      final producttypeMap = await json.decode(response.body);

      if (response.statusCode != 200) {
        print(producttypeMap['error']);
        return producttype;
      }
      producttypeMap.forEach((element) {
        producttype.add(Producttype.fromJson(element));
      });
      print(producttypeMap);

      return producttype;
    } catch (error) {
      print(error);
      return producttype;
    }
  }

  Future makeDeleteRequest(String id) async {
    try{
      final response = await http.delete(Url);

      if(response.statusCode != 200){
        throw Exception(json.decode(response.body)['error']);
      }
      print(response.body);
      return true;
    }catch (error){
      print(error);
      return false;
    }
  }

  Future<List<Producttype>> makeGetProducttypeRequest (String id) async{
    final List<Producttype> producttype = [];
    try{
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final url = Uri.parse('$Url/$id');
      final response = await http.get(url, headers: requestHeaders);

      final producttypeMap = await json.decode(response.body);

      if (response.statusCode != 200) {
        print(producttypeMap['error']);
        return producttype;
      }
      producttypeMap.forEach((element) {
        producttype.add(Producttype.fromJson(element));
      });
      print(producttypeMap);

      return producttype;
    }catch(error){
      print(error);
      return producttype;
    }
  }

  Future<Producttype?> addUser(Producttype producttype) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.post(Url,
          body: json.encode(producttype.toJson(producttype.id)
            ..addAll({})),
          headers: requestHeaders);
      print(response.body);
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return producttype.coppyWith(id: json.decode(response.body));
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateUser(Producttype producttype) async{
    try{
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final url = Uri.parse('$Url/${producttype.id}');
      final response = await http.put(url,
          body: json.encode(producttype.toJson(producttype.id)),
          headers: requestHeaders
      );
      print(producttype.id);
      if(response.statusCode != 200){
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    }catch(error){
      print(error);
      return false;
    }
  }
}