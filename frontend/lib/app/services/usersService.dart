import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../models/users.dart';

      final Url = Uri.parse('http://192.168.1.101:8000/api/users/user/');


class UsersService extends ChangeNotifier{
  UsersService();

  Future<List<User>> makeUsersGetRequest() async {
    final List<User> products = [];
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
        products.add(User.fromJson(element));
      });
      final a = products[0].Sum as dynamic;
      final List<Sum> ah = [];
      a.forEach((element){
        ah.add(Sum.fromJson(element));
      });
      print(ah[0].Ten);

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
        throw Exception(json.decode(response.body)['error']);
      }
      print(response.body);
      return true;
    }catch (error){
      print(error);
      return false;
    }
  }

  Future<List<User>> makeGetUserRequest (String id) async{
    final List<User> products = [];
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
        products.add(User.fromJson(element));
      });
      print(productMap);

      return products;
    }catch(error){
      print(error);
      return products;
    }
  }

  Future<User?> addUser(User user) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.post(Url,
          body: json.encode(user.toJson(user.id)
            ..addAll({})),
          headers: requestHeaders);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return user.copyWith(id: json.decode(response.body)['Name']);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateUser(User user) async{
    try{
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final url = Uri.parse('$Url${user.id}');
      final response = await http.put(url,
        body: json.encode(user.toJson(user.id)),
        headers: requestHeaders
      );
      if(response.statusCode != 200){
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    }catch(error){
      print(error);
      return false;
    }
  }

  Future<User?> login(email, pass) async {
    // final Login? user;
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final Map<String, String> reqBody = {'email': email, 'pass': pass};
      final userUrl = Uri.parse('$Url''login');
      final response = await http.post(userUrl,
          headers: requestHeaders, body: json.encode(reqBody));
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      print(json.decode(response.body));
      final user = json.decode(response.body);
      print(User.fromJson(user[0]));
      return User.fromJson(user[0]);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<User?> signUp(String email, String pass) async {
    final User? user;
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final Map<String, String> reqBody = {'email': email, 'pass': pass};
      final userUrl = Uri.parse('$Url''signup');
      final response = await http.post(userUrl,
          body: json.encode(reqBody), headers: requestHeaders);

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['error']);
      }

      final user = User(email: email, pass: pass, id: '', Username: '', SoBan: 0, Address: '', CapBac: '', Name: '', Phone: '', Sum: null);
      // print(user);
      return user;
    } catch (error) {
      return null;
    }
  }
  Future logout() async{
    try{
      final userUrl = Uri.parse('$Url' 'logout');
      final response = await http.get(userUrl);

      if(response.statusCode != 200){
        throw Exception(jsonDecode(response.body)['error']);
      }

      return true;
    }catch (error){
      return false;
    }
  }
}
