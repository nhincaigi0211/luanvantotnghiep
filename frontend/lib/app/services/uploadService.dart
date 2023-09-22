// import 'dart:html';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';


class UploadService extends ChangeNotifier{
  UploadService();
  static ocr (File product) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
      };

      var bytes = product.readAsBytesSync();
      final Url = Uri.parse('http://10.0.2.2:3002/api/hinhannh/upload');
      final response = await http.post(Url,
          body: {"image":bytes},
          headers: requestHeaders);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      // return product.coppyWith(id: json.decode(response.body)['product_Ten']);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
