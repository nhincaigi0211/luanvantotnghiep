

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/models/cart_item.dart';
import 'package:frontend/app/models/products.dart';
import 'package:frontend/app/views/cart/cart_manager.dart';
import '../cart/cart_manager.dart';
import '../../services/tableService.dart';
import '../../models/table.dart';
  // final CartManager = _cartManager;

class TablesManager with ChangeNotifier {
  List<Tables> _Tables = [

  ];

  final TablesService _tablesService;
  final cartManager = CartManager();

  TablesManager() : _tablesService = TablesService();

  int get itemCount{
    return _Tables.length;
  }

  List<Tables> get items{
    return [..._Tables];
  }


  set item(int a){

    for(int i =0; i< a; i++){
      // ignore: prefer_interpolation_to_compose_strings
      _Tables.add(Tables(table_Ma: i.toString(), table_Ten: 'Bàn số ' + (i+1).toString(), table_TrangThai: true, cart: []));
    }
    notifyListeners();
  }

  List<Tables> filterItems(String filter){
    return _Tables.where((element) => element.id == filter).toList();
  }

  Tables? findById(String id){
    try{
      return _Tables.firstWhere((element) => element.id == id);
    }catch(error){
      return null;
    }
  }

  void deleteAllTable() {
    _Tables = [];
    notifyListeners();
  }

  String get cart{
    return cartManager.getMa;
  }

  void addCart(Product product, int quantily, String ma){
    // final index = _Tables.indexWhere((element) => element.table_Ma == ma);
    // // final cartManager = CartManager();
    // _Tables[index].addItem(product, quantily, ma);
    // print(ma);
    // print(index);
    for(int i = 0; i< _Tables.length; i++){
      if(_Tables[i].table_Ma == ma){
       _Tables[i].addItem(product, quantily, ma); 
       print(_Tables[i].cart.length);
      }
    }

    notifyListeners();
  }

  Future<void> getTable() async{
    _Tables = await _tablesService.makeTablesGetRequest();
    notifyListeners();
  }

  Future<void> findByTable(String id) async{
    _Tables = await _tablesService.makeGetTablesRequest(id);
    notifyListeners();
  }

  Future<void> deleteTables(String id) async{
    final index =_Tables.indexWhere((element) => element.id == id);
    Tables? exitTable = _Tables[index];
    _Tables.removeAt(index);
    notifyListeners();

    if(!await _tablesService.makeDeleteRequest(id)){
      _Tables.insert(index, exitTable);
      notifyListeners();
    }
  }

  // Future<void> addTable(Tables table) async {
  //   final newTable = await _tablesService.addTable(table);
  //   if (newTable != null) {
  //     _Tables.add(newTable);
  //     notifyListeners();
  //   }
  // }

  // Future<void> updateTable(Tables table) async {
  //   final index = _Tables.indexWhere((element) => element.id == table.id);
  //   if (index >= 0) {
  //     if (await _tablesService.updateTable(table)) {
  //       _Tables[index] = table;
  //       notifyListeners();
  //     }
  //   }
  // }

  where(Function(dynamic element) param0) {}
}

