import 'package:flutter/material.dart';
import 'package:frontend/app/models/users.dart';
import 'package:provider/provider.dart';
import '../../../route.dart';

class searchUserGridTitle extends StatefulWidget {
  final User user;
  const searchUserGridTitle(this.user, {super.key});
  @override
  State<searchUserGridTitle> createState() => _searchUserGirdTitleState();

}
class _searchUserGirdTitleState extends State<searchUserGridTitle>{
  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed: (){
        print('object');
      }, 
      child: Text(widget.user.Name.toString(), style: TextStyle(fontSize: 20),),
      );
  }
}