import 'package:flutter/material.dart';
import 'package:frontend/app/models/products.dart';
import 'package:frontend/app/views/table/table_manager.dart';
import 'package:frontend/app/views/users/admin/user_form.dart';
import 'package:frontend/homepage.dart';
import 'package:provider/provider.dart';
import 'app/views/calendar/calendar.dart';
import 'app/agruments.dart';
import 'route.dart';
void main() =>
  runApp (const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersManager>(create: (context) => UsersManager()),
        ChangeNotifierProvider<ProductsManager>(create: (ctx) => ProductsManager(),),
        ChangeNotifierProvider<ProductTypeManager>(create: (ctx) => ProductTypeManager(),),
        ChangeNotifierProvider<TablesManager>(create: (ctx) => TablesManager(),),
        ChangeNotifierProvider<CartManager>(create: (ctx) => CartManager(),),
        // ChangeNotifierProvider<UserManager>(create: (context) => UserManager()),
      ],
      child: Consumer<UsersManager>(builder: (context, usersManager, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Trang chủ',
          theme: ThemeData(
            fontFamily: 'Lato',
          ),
          home: usersManager.isLogin? const Home() : const LoginScreen(),
          routes: {
            UserOverViewScreen.routeName: (ctx) => const UserOverViewScreen(''),
            Manage_ProductsOverViewScreen.routeName: (ctx) => const Manage_ProductsOverViewScreen(''),
            GetData.routeName: (ctx) => const GetData(''),
            TableOverViewScreen.routeName: (ctx) => const TableOverViewScreen(''),
          },
          onGenerateRoute: (setting){
            final arg = setting.arguments;
            if(setting.name == UserDetail.routeName){
              return MaterialPageRoute(builder: (ctx){
                ScreenArguments? arguments = arg as ScreenArguments?;
                return UserDetail(
                  ctx.read<UsersManager>().findById(arguments!.id!)!
                );
              });
            }

            if(setting.name == ProductDetail.routeName){
              return MaterialPageRoute(builder: (ctx){
                ScreenArguments? arguments = arg as ScreenArguments?;
                return ProductDetail(
                  ctx.read<ProductsManager>().findById(arguments!.id!)!
                );
              });
            }

            if(setting.name == ProductForm.routeName){
              final id = setting.arguments as String?;
              return MaterialPageRoute(builder: (ctx){
                return ProductForm(id != null
                ? ctx.read<ProductsManager>().findById(id) :null);
              });
            }

            if(setting.name == UserForm.routeName){
              final id = setting.arguments as String?;
              return MaterialPageRoute(builder: (ctx){
                return UserForm(id != null
                ? ctx.read<UsersManager>().findById(id) :null);
              });
            }
             if (setting.name == ProductFilter.routeName) {
              return MaterialPageRoute(builder: (ctx) {
                ScreenArguments? arguments = arg as ScreenArguments?;
                return ProductFilter(arguments!.id!);
              });
            }
          },
        );
      }),
    );
  }
}
