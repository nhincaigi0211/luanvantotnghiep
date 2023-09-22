// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../models/login.dart';

//   final Url = Uri.parse('http://192.168.1.101:8000/api/users/user/');

// class UserService {
//   UserService();
//   Future<Login?> login(email, pass) async {
//     // final Login? user;
//     try {
//       Map<String, String> requestHeaders = {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       };
//       final Map<String, String> reqBody = {'email': email, 'pass': pass};
//       final userUrl = Uri.parse('$Url''login');
//       final response = await http.post(userUrl,
//           headers: requestHeaders, body: json.encode(reqBody));
//       if (response.statusCode != 200) {
//         throw Exception(json.decode(response.body)['error']);
//       }
//       print(json.decode(response.body));
//       final user = json.decode(response.body);
//       print(user);
//       return Login.fromJson(user[0]);
//     } catch (error) {
//       print(error);
//       return null;
//     }
//   }

//   Future<Login?> signUp(String email, String pass) async {
//     final Login? user;
//     try {
//       Map<String, String> requestHeaders = {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       };

//       final Map<String, String> reqBody = {'email': email, 'pass': pass};
//       final userUrl = Uri.parse('$Url''signup');
//       final response = await http.post(userUrl,
//           body: json.encode(reqBody), headers: requestHeaders);

//       if (response.statusCode != 200) {
//         throw Exception(jsonDecode(response.body)['error']);
//       }

//       final user = Login(email: email, pass: pass, id: '', Username: '', Address: '', Name: '', Phone: '', CapBac: '', SoBan: 0, Sum: null);
//       // print(user);
//       return user;
//     } catch (error) {
//       return null;
//     }
//   }

//   Future logout() async{
//     try{
//       final userUrl = Uri.parse('$Url' 'logout');
//       final response = await http.get(userUrl);

//       if(response.statusCode != 200){
//         throw Exception(jsonDecode(response.body)['error']);
//       }

//       return true;
//     }catch (error){
//       return false;
//     }
//   }
// }
