import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/app/models/producttype.dart';
import '../../services/productTypeService.dart';
import '../../models/producttype.dart';


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
