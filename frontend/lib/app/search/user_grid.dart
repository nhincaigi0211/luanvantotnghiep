import 'package:frontend/route.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../views/users/user_manager.dart';
import 'search_gridtitle.dart';

class searchUserGrid extends StatefulWidget{
  final String filter;
  const searchUserGrid(this.filter, {super.key});

  @override
  State<searchUserGrid> createState() => _searchUserGridState();
}

class _searchUserGridState extends State<searchUserGrid> {
  Widget build(BuildContext context){
    final userManager = context.read<UsersManager>();
      print(widget.filter);
    if(widget.filter != ''){
      final users = userManager.filterItems(widget.filter);
      if(users.isEmpty){
        return Text('Danh sách trống!');
      }else{
        return gridFilter(users);
      }
    } return SizedBox();
  }

  Widget gridFilter(List users){
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, i){
          return searchUserGridTitle(users[i]);
    }
    );
  }
}
