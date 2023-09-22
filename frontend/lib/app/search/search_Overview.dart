import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/users/user_manager.dart';
import 'search_grid.dart';

class GetData extends StatefulWidget{
  final String filter;
  static const routeName = '/searchOverView';
  const GetData(this.filter, {super.key});
  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData>{

late Future<void> _getUser;
  @override
  void initState(){
    super.initState();
    _getUser = context.read<UsersManager>().getUser();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder(
        future: _getUser,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return SearchGrid();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}