// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:frontend/app/models/table.dart';
// import 'package:frontend/app/views/table/table_manager.dart';

// import '../../services/commentService.dart';
// import '../../models/comment.dart';

// class CommentsManager with ChangeNotifier {
//   List<Comment> _comments = [

//   ];
//   final CommentsService _commentsService;

//   CommentsManager() : _commentsService = CommentsService();

//   int get itemCount{
//     return _comments.length;
//   }

//   List<Comment> get items{
//     return [..._comments];
//   }

//   // List<Comment> filterItems(String filter){
//   //   return _comments.where((element) => element.Name!.toLowerCase().contains(filter.toLowerCase())).toList();
//   // }

//   Comment? findById(String id){
//     try{
//       return _comments.firstWhere((element) => element.id == id);
//     }catch(error){
//       return null;
//     }
//   }

//   void deleteAllComments() {
//     _comments = [];
//     notifyListeners();
//   }

//   Future<void> getComment() async{
//     _comments = await _commentsService.makeCommentsGetRequest();
//     notifyListeners();
//   }

//   Future<void> deleteComment(String id) async{
//     final index =_comments.indexWhere((element) => element.id == id);
//     Comment? exit = _comments[index];
//     _comments.removeAt(index);
//     notifyListeners();

//     if(!await _commentsService.makeDeleteRequest(id)){
//       _comments.insert(index, exit);
//       notifyListeners();
//     }
//   }

//   Future<void> addUser(User user) async {
//     final newUser = await _usersService.addUser(user);
//     if (newUser != null) { 
//       _Users.add(newUser);
//       notifyListeners();
//     }
//   }

//   Future<void> updateUser(User user) async {
//     final index = _Users.indexWhere((element) => element.id == user.id);
//     if (index >= 0) {
//       if (await _usersService.updateUser(user)) {
//         _Users[index] = user;
//         notifyListeners();
//       }
//     }
//   }

//   where(Function(dynamic element) param0) {}
// }
