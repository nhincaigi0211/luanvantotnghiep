import 'package:frontend/app/models/users.dart';
import 'package:frontend/app/views/users/user_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../route.dart';
import 'user_grid.dart';
import '../views/users/user_manager.dart';

class SearchGrid extends StatefulWidget {
    String display = '';
  @override
  State<SearchGrid> createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  @override
  Widget build(BuildContext context) {
    final users = context.read<UsersManager>();
    // List<User> display = List.from(users as Iterable);

    void updateList(String value){
      setState(() {
        widget.display = value;
      });
  }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tìm kiếm',
            textAlign: TextAlign.center,
          ),
        ),
        body: users.itemCount < 0
            ? Text('Danh sách rỗng')
            : Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          child: TextField(
                            onChanged: (value) { updateList(value);},
                          decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search",
                            suffix: Icon(Icons.search),
                            prefixIconColor: Color.fromARGB(255, 142, 142, 142),
                          ),
                        ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            height: 600,
                            child: searchUserGrid(widget.display)),
                        )
                      ]),
                ),
              );
  }
}
