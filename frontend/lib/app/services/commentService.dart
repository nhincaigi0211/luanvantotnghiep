import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../models/comment.dart';

  final Url = Uri.parse('http://192.168.1.101:8000/api/comments/comment/');

class CommentsService extends ChangeNotifier{
  CommentsService();

  Future<List<Comment>> makeCommentsGetRequest() async {
    final List<Comment> comments = [];
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(Url, headers: requestHeaders);

      final cmt = await json.decode(response.body);

      if (response.statusCode != 200) {
        print(cmt['error']);
        return comments;
      }
      cmt.forEach((element) {
        comments.add(Comment.fromJson(element));
      });
      print(cmt);
      

      return comments;
    } catch (error) {
      print(error);
      return comments;
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

  Future<List<Comment>> makeGetCommentRequest (String id) async{
    final List<Comment> comments = [];
    try{
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(Url, headers: requestHeaders);

      final cmt = await json.decode(response.body);

      if (response.statusCode != 200) {
        print(cmt['error']);
        return comments;
      }
      cmt.forEach((element) {
        comments.add(Comment.fromJson(element));
      });
      print(cmt);

      return comments;
    }catch(error){
      print(error);
      return comments;
    }
  }

  Future<Comment?> createComment(Comment comment) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await http.post(Url,
          body: json.encode(comment.toJson(comment.id)
            ..addAll({})),
          headers: requestHeaders);
      print(response.body);
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return comment.copyWith(id: json.decode(response.body)['product_Ten']);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateComment(Comment comment) async{
    try{
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final url = Uri.parse('$Url${comment.id}');
      final response = await http.put(url,
          body: json.encode(comment.toJson(comment.id)),
          headers: requestHeaders
      );
      print(comment.id);
      if(response.statusCode != 200){
        print('$Url${comment.id}');
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    }catch(error){
      print(error);
      return false;
    }
  }
}