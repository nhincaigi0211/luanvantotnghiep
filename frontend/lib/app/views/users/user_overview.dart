import 'package:flutter/material.dart';
import 'package:frontend/app/views/users/admin/user_form.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import 'user_manager.dart';
import 'user_grid.dart';

class UserOverViewScreen extends StatefulWidget{
  static const routeName = '/userOverView';
  final String filter;
  const UserOverViewScreen(this.filter, {super.key});
  @override
  State<UserOverViewScreen> createState() => _UserOverViewScreenState();
}

class _UserOverViewScreenState extends State<UserOverViewScreen>{
  late Future<void> _getUser;

  Future<void> _handRefresh() async{
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState(){
    super.initState();
    _getUser = context.read<UsersManager>().getUser();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:LiquidPullToRefresh(
        onRefresh: _handRefresh,
        child: 
        SizedBox(
          child: FutureBuilder(
        future: _getUser,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return UserGrid(widget.filter);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      ),)
    );
  }
}
