import 'package:flutter/material.dart';
import 'package:frontend/app/views/users/admin/user_form.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../../agruments.dart';
import '../../../route.dart';
import '../../models/users.dart';

class UserGridTitle extends StatefulWidget {
  final User user;
  const UserGridTitle(this.user, {super.key});
  @override
  State<UserGridTitle> createState() => _UserGirdTitleState();

}
class _UserGirdTitleState extends State<UserGridTitle>{
  @override
  Widget build(BuildContext context){
    return ExpansionTile(
      leading: CircleAvatar(
        radius: 20,
        child: Text(widget.user.CapBac.toString(), style: TextStyle(fontSize: 20),),
      ),
        title: Text(widget.user.Name.toString()),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(UserDetail.routeName,
                      arguments: ScreenArguments(widget.user.id, widget.user.Name.toString()));
                    },
                    child: Text('Chi Tiết')
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context)
            .pushNamed(UserForm.routeName, arguments: widget.user.id);
                  }, 
                  child: Text('Chỉnh sửa')
                ),
                TextButton(
                    onPressed: (){
                      context.read<UsersManager>().deleteUser(widget.user.id!);
                      print('xóa thành công!');
                    },
                    child: const Text('Xóa'),
                    )
              ],
            ),
          )

      ],
    );
  }
  _ShowConfirm(){
    QuickAlert.show(
      context: context,
      title: 'Warning',
      text: 'Bạn có muốn xóa tài khoản này không?',
      type: QuickAlertType.confirm,
       );
  }
}