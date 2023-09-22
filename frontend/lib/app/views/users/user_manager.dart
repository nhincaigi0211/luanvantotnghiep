import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/app/models/table.dart';
import 'package:frontend/app/views/table/table_manager.dart';

import '../../services/usersService.dart';
import '../../models/users.dart';

class UsersManager with ChangeNotifier {
  bool _isAdmin = false;
  bool _isLogin = false;
  List<User> _Users = [

  ];
  late List<Tables> table;

  late User _user;
  final UsersService _usersService;

  UsersManager() : _usersService = UsersService();
  var tablemanager = TablesManager();

  int get itemCount{
    return _Users.length;
  }

  List<User> get items{
    return [..._Users];
  }

  User get userInfor{
    return _user;
  }

  List<User> filterItems(String filter){
    return _Users.where((element) => element.Name!.toLowerCase().contains(filter.toLowerCase())).toList();
  }

  User? findById(String id){
    try{
      return _Users.firstWhere((element) => element.id == id);
    }catch(error){
      return null;
    }
  }

  bool get isLogin {
    return _isLogin;
  }

  String get email {
    return _user?.email;
  }

  String get username {
    return _user?.username;
  }

  int get soBan{
    return _user.SoBan;
  }

  List<Tables> get item{
    return table;
  }
  

  void deleteAllUsers() {
    _Users = [];
    notifyListeners();
  }

  Future<void> getUser() async{
    _Users = await _usersService.makeUsersGetRequest();
    notifyListeners();
  }

  Future<void> login(String email, String pass) async {
    _user = (await _usersService.login(email, pass))!;
    print(_user.SoBan);
    tablemanager.item =_user.SoBan;
    table  = tablemanager.items;
    _isLogin = true;
    notifyListeners();
    }

  Future<bool> logout() async{
    !await _usersService.logout();
    _isLogin = false;
    User _user;
    notifyListeners();
    return false;
  }

  Future<void> signup(String email, String pass) async {
    _user = (await _usersService.signUp(email, pass))!;
    if (_user != null) {
      _isLogin = true;
      notifyListeners();
    }
  }


  Future<void> findByUser(String id) async{
    _Users = await _usersService.makeGetUserRequest(id);
    notifyListeners();
  }

  Future<void> deleteUser(String id) async{
    final index =_Users.indexWhere((element) => element.id == id);
    User? exitUser = _Users[index];
    _Users.removeAt(index);
    notifyListeners();

    if(!await _usersService.makeDeleteRequest(id)){
      _Users.insert(index, exitUser);
      notifyListeners();
    }
  }

  Future<void> addUser(User user) async {
    final newUser = await _usersService.addUser(user);
    if (newUser != null) {
      _Users.add(newUser);
      notifyListeners();
    }
  }

  Future<void> updateUser(User user) async {
    final index = _Users.indexWhere((element) => element.id == user.id);
    if (index >= 0) {
      if (await _usersService.updateUser(user)) {
        _Users[index] = user;
        notifyListeners();
      }
    }
  }

  where(Function(dynamic element) param0) {}
}
