import 'package:flutter/material.dart';
import 'package:frontend/app/views/users/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import 'login_manager.dart';

enum UserMode { signup, login }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  UserMode _userMode = UserMode.login;
  final Map<String, String> _authData = {'email': '', 'password': ''};
  final _isSubmiting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();
  var isEmailCorrect = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    _isSubmiting.value = true;

    try {
      if (_userMode == UserMode.login) {
        await context
            .read<UsersManager>()
            .login(_authData['email']!, _authData['password']!);
      } else {
        await context
            .read<UsersManager>()
            .signup(_authData['email']!, _authData['password']!);
      }
    } catch (error) {
      print(error);
    }
    _isSubmiting.value = false;
  }

  void _switchUserMode() {
    _userMode == UserMode.login
        ? setState(() {
            _userMode = UserMode.signup;
          })
        : setState(() {
            _userMode = UserMode.login;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            // color: Colors.red.withOpacity(0.1),
            image: DecorationImage(
                image: NetworkImage(
                    // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShp2T_UoR8vXNZXfMhtxXPFvmDWmkUbVv3A40TYjcunag0pHFS_NMblOClDVvKLox4Atw&usqp=CAU',
                    // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                    'https://i.pinimg.com/736x/87/48/53/874853f94d850a38ca889dd90bc1a1bc.jpg'),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'WELCOME                         TO                                      LAU DO GIA CAO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: isEmailCorrect && _userMode == UserMode.login
                          ? 250
                          : 300,
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          buildEmailField(),
                          buildPasswordField(),
                          const SizedBox(
                            height: 10,
                          ),
                          _userMode == UserMode.signup
                              ? buildPasswordConfirmField()
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          isEmailCorrect
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      backgroundColor: isEmailCorrect == false
                                          ? Colors.red
                                          : const Color.fromARGB(
                                              255, 245, 130, 168),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 20)),
                                  onPressed: () {
                                    _submit();
                                  },
                                  child: Text(
                                    _userMode == UserMode.login
                                        ? 'Đăng nhập'
                                        : 'Đăng kí',
                                    style: const TextStyle(fontSize: 18),
                                  ))
                              : Container(),
                        ],
                      ),
                    ),
                    buildSwitchMode()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            isEmailCorrect = isEmail(val);
          });
        },
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.purple,
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.purple),
        ),
        onSaved: (val) {
          _authData['email'] = val!;
        },
      ),
    );
  }

  Widget buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: _passwordController,
        obscuringCharacter: '*',
        obscureText: true,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.purple,
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: "Mật khẩu",
          labelStyle: TextStyle(color: Colors.purple),
        ),
        validator: (value) {
          if (value!.isEmpty && value.length < 5) {
            return 'Enter a valid password';
          }
          return null;
        },
        onSaved: (val) {
          _authData['password'] = val!;
        },
      ),
    );
  }

  Widget buildPasswordConfirmField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
          controller: _passwordController,
          obscuringCharacter: '*',
          obscureText: true,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.purple,
            ),
            filled: true,
            fillColor: Colors.white,
            labelText: "Nhập lại mật khẩu",
            hintText: '*********',
            labelStyle: TextStyle(color: Colors.purple),
          ),
          validator: _userMode == UserMode.signup
              ? (val) {
                  if (val != _passwordController.text) {
                    return "password not match";
                  }
                  return null;
                }
              : null),
    );
  }

  Widget buildSwitchMode() {
    return TextButton(
      onPressed: () {
        _switchUserMode();
      },
      child: Text(
        _userMode == UserMode.login ? 'Đăng kí' : 'Đăng nhập',
        style:
            const TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
      ),
    );
  }
}
