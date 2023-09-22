import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../models/table.dart';

final Url = Uri.parse('http://192.168.1.101:8000/api/tables/table/');

class TablesService extends ChangeNotifier {
  TablesService();

  Future<List<Tables>> makeTablesGetRequest() async {
    final List<Tables> table = [];
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(Url, headers: requestHeaders);

      final tableMaps = await json.decode(response.body);

      if (response.statusCode != 200) {
        print(tableMaps['error']);
        return table;
      }
      tableMaps.forEach((element) {
        table.add(Tables.fromJson(element));
      });
      // print(tableMaps);
      return table;
    } catch (error) {
      print(error);
      return (table);
    }
  }

  Future makeDeleteRequest(String id) async {
    try {
      final url = Uri.parse('$Url$id');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      print(response.body);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<List<Tables>> makeGetTablesRequest(String id) async {
    final List<Tables> table = [];
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(Url, headers: requestHeaders);

      final Maps = await json.decode(response.body);

      if (response.statusCode != 200) {
        print(Maps['error']);
        return table;
      }
      Maps.forEach((element) {
        table.add(Tables.fromJson(element));
      });
      print(Maps);

      return table;
    } catch (error) {
      print(error);
      return table;
    }
  }

  Future<Tables?> addTable(Tables table) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.post(Url,
          body: json.encode(table.toJson(table.id)..addAll({})),
          headers: requestHeaders);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      // return table.copyWith(id: json.decode(response.body)['Name']);
    } catch (error) {
      print(error);
      return null;
    }

    Future<bool> updateTable(Tables table) async {
      try {
        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
        final url = Uri.parse('$Url${table.id}');
        final response = await http.put(url,
            body: json.encode(table.toJson(table.id)), headers: requestHeaders);
        if (response.statusCode != 200) {
          throw Exception(json.decode(response.body)['error']);
        }
        return true;
      } catch (error) {
        print(error);
        return false;
      }
    }
  }
}
