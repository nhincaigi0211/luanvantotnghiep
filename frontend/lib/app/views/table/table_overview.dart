import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'table_grid.dart';
import 'table_manager.dart';

class TableOverViewScreen extends StatefulWidget{
  static const routeName = '/TableTypeOverView';
  final String tables;
  const TableOverViewScreen(this.tables, {super.key});
  @override
  State<TableOverViewScreen> createState() => _TableOverViewScreenState();
}

class _TableOverViewScreenState extends State<TableOverViewScreen>{
  late Future<void> _getTable;
  @override
  void initState(){
    super.initState();
    _getTable = context.read<TablesManager>().getTable();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder(
        future: _getTable,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return TableGrid(widget.tables);
            }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}