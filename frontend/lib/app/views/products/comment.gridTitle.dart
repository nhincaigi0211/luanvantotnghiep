import 'package:flutter/material.dart';
import 'package:frontend/app/models/comment.dart';
import 'package:frontend/app/views/users/user_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';

class CommentGirdTitle extends StatefulWidget {
  final Comment ah;
  const CommentGirdTitle(this.ah, {super.key});
  @override
  State<CommentGirdTitle> createState() => _CommentGirdTitleState();
}

class _CommentGirdTitleState extends State<CommentGirdTitle> {
  @override
  Widget build(BuildContext context) {
    var usersManager = context.read<UsersManager>();

    return ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration:const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      // backgroundImage: 
                      child: Text(widget.ah.cmt_ma),
                      ),
                ),
              ),
              title: Text(
                usersManager.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.ah.cmt_content),
              trailing: Text(widget.ah.cmt_date, style: TextStyle(fontSize: 10)),
            );
  }
}


// const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               child: SizedBox(
//                 height: 20,
//                 width: 1000,
//                 child: Text(
//                   'Các sản phẩm khác',
//                   style: TextStyle(fontSize: 18),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 160,
//               child: ProductsGrid(widget.product.product_Ma),
//             ),