// import 'package:flutter/foundation.dart';
// import '../../models/login.dart';
// import '../../services/loginservice.dart';

// class UserManager with ChangeNotifier {
//   bool _isAdmin = false;
//   bool _isLogin = false;

//   Login? _user;
//   final UserService _userService;
//   UserManager() : _userService = UserService();

//   bool get isLogin {
//     return _isLogin;
//   }

//   String get email {
//     return _user?.email;
//   }

//   Future<void> login(String email, String pass) async {
//     _user = await _userService.login(email, pass);
//     print('hi');
//     print(_user);
//     if (_user != null) {
//       _isLogin = true;
//       notifyListeners();
//     }
//   }

//   bool logout() {
//     _isLogin = false;
//     _user = null;
//     notifyListeners();
//     return false;
//   }

//   Future<void> signup(String email, String pass) async {
//     _user = await _userService.signUp(email, pass);
//     if (_user != null) {
//       _isLogin = true;
//       notifyListeners();
//     }
//   }
// }
