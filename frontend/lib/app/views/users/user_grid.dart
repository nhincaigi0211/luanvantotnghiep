import 'package:frontend/app/views/users/admin/user_form.dart';
import 'package:frontend/route.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'user_manager.dart';
import 'user_gridtitle.dart';

class UserGrid extends StatefulWidget{
  final String filter;
  const UserGrid(this.filter, {super.key});

  @override
  State<UserGrid> createState() => _UserGridState();
}

class _UserGridState extends State<UserGrid> {
  Widget build(BuildContext context){
    final userManager = context.read<UsersManager>();
    if(widget.filter != ''){
      final users = userManager.filterItems(widget.filter);
      if(users.isEmpty){
        return Text('Danh sách trống!');
      }else{
        return gridFilter(users);
      }
    }else{
      final users = context.read<UsersManager>();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách tài khoản', textAlign: TextAlign.center,),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(GetData.routeName);
              },
              icon: const Icon(
                Icons.search
              ))
          ],
          ),
          drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text('Danh mục quản lý'),
            ),
            ListTile(
              title: const Text('Thêm sản phẩm'),
              onTap: (){
                Navigator.of(context)
                              .pushNamed(UserForm.routeName);
              },
            ),
          ],
        ),
      ),
        body: users.itemCount < 0 ? Text('Danh sách rỗng')
          :Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: users.itemCount,
              itemBuilder: (context, i){
                return UserGridTitle(users.items[i]);
              },
            ),
          ),
          )
      );
    }
  }

  Widget gridFilter(List users){
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, i){
          return UserGridTitle(users[i]);
    }
    );
  }
}
