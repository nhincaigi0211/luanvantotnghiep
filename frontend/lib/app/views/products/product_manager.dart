import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../services/productTypeService.dart';
import '../../models/producttype.dart';
import '../../services/productsService.dart';
import '../../models/products.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _product = [

  ];

  final ProductsService _productsService;

  ProductsManager() : _productsService = ProductsService();

  int get itemCount{
    return _product.length;
  }

  Product? findByMa(String id){
    try{
      return _product.firstWhere((element) => element.product_Ma == id);
    }catch(error){
      return null;
    }
  }

  List<Product> get items{
    return [..._product];
  }

  List<Product> filterItems(String filter){
    return _product.where((element) => element.product_Ma == filter).toList();
  }

  Product? findById(String id){
    try{
      return _product.firstWhere((element) => element.id == id);
    }catch(error){
      return null;
    }
  }

  void deleteAllUsers() {
    _product = [];
    notifyListeners();
  }

  Future<void> getProducts() async{
    _product = await _productsService.makeUsersGetRequest();
    notifyListeners();
  }

  Future<void> findByProduct(String id) async{
    _product = await _productsService.makeGetUserRequest(id);
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async{
    final index =_product.indexWhere((element) => element.id == id);
    Product? exitUser = _product[index];
    _product.removeAt(index);
    notifyListeners();

    if(!await _productsService.makeDeleteRequest(id)){
      _product.insert(index, exitUser);
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _product.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _product.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _product[index] = product;
        notifyListeners();
      }
    }
  }
}

class ProductTypeManager with ChangeNotifier {
  List<Producttype> _Producttype = [

  ];

  final ProductTypeService _producttypeService;

  ProductTypeManager() : _producttypeService = ProductTypeService();

  int get itemCount{
    return _Producttype.length;
  }

  List<Producttype> get items{
    return [..._Producttype];
  }

  List<Producttype> filterItems(String filter){
    return _Producttype.where((element) => element.id == filter).toList();
  }

  Producttype? findById(String id){
    try{
      return _Producttype.firstWhere((element) => element.proT_Code == id);
    }catch(error){
      return null;
    }
  }

  void deleteAllProducttype() {
    _Producttype = [];
    notifyListeners();
  }

  Future<void> getUser() async{
    _Producttype = await _producttypeService.makeProducttypeGetRequest();
    notifyListeners();
  }

  Future<void> findByProductType(String id) async{
    _Producttype = await _producttypeService.makeGetProducttypeRequest(id);
    notifyListeners();
  }

  Future<void> deleteProductType(String id) async{
    final index =_Producttype.indexWhere((element) => element.id == id);
    Producttype? exitProductType = _Producttype[index];
    _Producttype.removeAt(index);
    notifyListeners();

    if(!await _producttypeService.makeDeleteRequest(id)){
      _Producttype.insert(index, exitProductType);
      notifyListeners();
    }
  }

  Future<void> addUser(Producttype producttype) async {
    final newProducttype = await _producttypeService.addUser(producttype);
    if (newProducttype != null) {
      _Producttype.add(newProducttype);
      notifyListeners();
    }
  }

  Future<void> updateUser(Producttype producttype) async {
    final index = _Producttype.indexWhere((element) => element.id == producttype.id);
    if (index >= 0) {
      if (await _producttypeService.updateUser(producttype)) {
        _Producttype[index] = producttype;
        notifyListeners();
      }
    }
  }
}

