import 'users.dart';

class Comment {
  final String id;
  final String cmt_ma;
  final String cmt_userId;
  final String cmt_content;
  final bool cmt_status;
  final String cmt_date;
  // final Object? cmt_user;
  final List<User> cmt_user = [];

  Comment(
      {
        required this.id,
        required this.cmt_ma,
        required this.cmt_userId,
        required this.cmt_content,
        required this.cmt_status,
        required this.cmt_date,
        required cmt_user,
      });
  Comment copyWith(
      {String? id, String? cmt_ma, String? cmt_userId, String? cmt_content, bool? cmt_status, String? cmt_date, List<User>? cmt_user}) {
    return Comment(
        id: id ?? this.id,
        cmt_ma: cmt_ma ?? this.cmt_ma,
        cmt_content: cmt_content ?? this.cmt_content,
        cmt_userId: cmt_userId ?? this.cmt_userId,
        cmt_status: cmt_status ?? this.cmt_status,
        cmt_date: cmt_date ?? this.cmt_date,
        cmt_user: cmt_user ?? this.cmt_user,
    );
  }

  static Comment fromJson(Map<String, dynamic> json){
    return Comment(
      id: json['_id'],
      cmt_ma: json['cmt_ma'],
      cmt_content: json['cmt_content'],
      cmt_userId: json['cmt_userId'],
      cmt_status: json['cmt_status'],
      cmt_date: json['cmt_date'],
      cmt_user: json['cmt_user'],
    );
  }

  Map<String, dynamic> toJson(String? id){
    return {
      'id':id,
      'cmt_ma' : cmt_ma,
      'cmt_content' : cmt_content,
      'cmt_userId' : cmt_userId,
      'cmt_status' : cmt_status,
      'cmt_date' : cmt_date,
      'cmt_user' : cmt_user,
    };
  }
}
