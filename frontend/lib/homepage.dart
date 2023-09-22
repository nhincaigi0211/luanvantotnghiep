import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'route.dart';
import 'app/views/productType/productType_Overview.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  int _selectedIndex = 0;

  static final List<Widget> _Pages = <Widget>[
    const UserOverViewScreen(''),
    const ProductsOverViewScreen('',''),
    const CartScreen(),
    const More(),
    const TableOverViewScreen(''),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Danh mục quản lý'),
              decoration: BoxDecoration(color: Colors.red),
            ),
            ListTile(
              title: const Text('Quản lý nhân viên'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Quán lý sản phẩm'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child:_Pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined, color: Colors.red,),
              label: 'Lịch hẹn'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.sell, color: Colors.red,),
              label: 'Bán hàng'
          ),
          BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: Colors.red,),
                label: "cart"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, color: Colors.red,),
              label: 'Thống kê'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu, color: Colors.red,),
              label: 'Thêm',
              backgroundColor: Colors.white
          ),
        ],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
            elevation: 5,
      ),
    );
  }
}