import 'package:frontend/app/models/producttype.dart';
import 'package:frontend/app/views/users/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'table_gridtitle.dart';
import 'table_manager.dart';

class TableGrid extends StatelessWidget {
  final String tables;
  const TableGrid(this.tables, {super.key});
  @override
  Widget build(BuildContext context) {
    // final tableManager = context.read<TablesManager>();
    final userManager = context.read<UsersManager>();

    return Scaffold(
        appBar: AppBar(actions: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Nhân viên oder',
                      style: TextStyle(
                          color: Color.fromRGBO(230, 81, 0, 1), fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Sơ đồ',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      print('hihi');
                    },
                    icon: const Icon(Icons.search)),
              ],
            ),
          ),
        ]),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.pinkAccent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Color.fromRGBO(230, 81, 0, 1),
                            size: 30,
                          ),
                          Text('Tạm tính:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black26,
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.local_cafe_rounded,
                            color: Color.fromRGBO(230, 81, 0, 1),
                            size: 30,
                          ),
                          Text('Đang dùng:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black26,
                              )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: const SizedBox(
                  height: 200,
                  width: 300,
                ),
              ),
            ),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 0.5)),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.add_comment),
                            Text('Tại quán'),
                          ],
                        ),
                        Expanded(
                          child: userManager.soBan < 0
                              ? const Text('Danh sách rỗng')
                              : GridView.builder(
                                  padding: const EdgeInsets.all(10),
                                  scrollDirection: Axis.vertical,
                                  itemCount: userManager.soBan,
                                  itemBuilder: (ctx, i) {
                                    return TableGridTitle(userManager.item[i]);
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.9,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 10),
                                ),
                        ),
                      ],
                    )))
          ]),
        ));
  }
}

Widget gridFilter(List tables) {
  return GridView.builder(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.all(10),
    itemCount: tables.length,
    itemBuilder: (ctx, i) {
      return TableGridTitle(tables[i]);
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10),
  );
}
