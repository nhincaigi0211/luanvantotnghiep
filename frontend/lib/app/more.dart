import 'package:flutter/material.dart';
import 'package:frontend/route.dart';
import 'package:provider/provider.dart';
class More extends StatefulWidget {
  const More({super.key});
  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lẩu dở giá cao'),),
      body: Container(
        child: GridView(
          padding: const EdgeInsets.all(20.0),
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.15,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red
                  ),
                  child: GridTileBar(
                      title: TextButton(
                        child: const Text(
                          'Đăng xuất',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          context.read<UsersManager>().logout() == false
                            ? const LoginScreen() : Container();
                        
                        },
                      )),
                )
              )
            ),
            SizedBox(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red
                      ),
                      child: GridTileBar(
                          title: TextButton(
                            child: const Text(
                              '2',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              print('object');
                              Navigator.of(context)
                                  .pushNamed(ProductForm.routeName);
                            },
                          )),
                    )
                )
            ),
            SizedBox(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red
                      ),
                      child: GridTileBar(
                          title: TextButton(
                            child: const Text(
                              'Món ăn',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              print('object');
                              Navigator.of(context).pushNamed(Manage_ProductsOverViewScreen.routeName);
                            },
                          )),
                    )
                )
            ),
            SizedBox(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red
                      ),
                      child: GridTileBar(
                          title: TextButton(
                            child: const Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                // Icon(
                                //     Icons.account_circle, color: Colors.white,
                                // ),
                                Text('Khách hàng', style: TextStyle(color: Colors.white, fontSize: 20),),
                              ],
                            ),
                            onPressed: () {
                              print('object');
                              Navigator.of(context).pushNamed(UserOverViewScreen.routeName);
                            },
                          )),
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}
